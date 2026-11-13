import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../activity_log.dart';
import '../bill.dart';
import '../cash_box.dart';
import '../cash_box_provider.dart';
import '../catalog_provider.dart';
import '../expense_category.dart';
import '../price_category.dart';
import '../product.dart';
import '../payment_account.dart';
import '../pin_attempts.dart';
import '../shop_info.dart';
import '../staff_member.dart';
import '../stock.dart';
import '../unit.dart';
import 'app_database.dart';
import 'bill_mapper.dart';
import 'unit_mapper.dart';

/// What the shop PC keeps in its database: the devices (with their sessions), the price categories,
/// the shop's own device types, the menu and stock, and the drink orders of the running sessions.
/// The built-in types are in the code and are always part of [unitTypes].
class ShopData {
  const ShopData({
    required this.units,
    required this.categories,
    required this.unitTypes,
    this.catalog = const Catalog(),
    this.orders = const {},
    this.bills = const [],
    this.cashBox = const CashBoxState(),
    this.expenseCategories = const [],
    this.staff = const [],
    this.shopInfo,
    this.activity = const [],
  });

  final List<Unit> units;
  final List<PriceCategory> categories;
  final List<UnitType> unitTypes;
  final Catalog catalog;

  /// The order lines of each running session, by the id of the device it is on.
  final Map<String, List<OrderLine>> orders;

  /// Every paid bill, oldest first.
  final List<Bill> bills;

  /// Every cash box so far and the money moved in and out of them.
  final CashBoxState cashBox;
  final List<ExpenseCategory> expenseCategories;
  final List<StaffMember> staff;

  /// The shop itself. Null until the first-run setup is done.
  final ShopInfo? shopInfo;

  /// The activity log, oldest first.
  final List<ActivityEntry> activity;

  bool get isEmpty => units.isEmpty && categories.isEmpty;
}

String _pascal(Enum e) => e.name[0].toUpperCase() + e.name.substring(1);
String _kindName(StockMovementKind kind) => _pascal(kind);

/// Saves and loads [ShopData] (decision #65). This is the only code that reads and writes the tables;
/// the app works with [Unit] and friends and never sees a row.
///
/// Saving takes the whole current state and works out what changed: it writes only the rows that
/// really differ (so sync later sends only those), marks vanished rows deleted instead of removing
/// them, and closes the sessions that are over. All in one transaction: a power cut in the middle
/// leaves the old state, never half of the new one.
class ShopRepository {
  ShopRepository(this._db, {required this.venueId});

  final AppDatabase _db;
  final String venueId;

  /// The bills already in the database, each with what can still change after payment (its discount).
  /// Everything else about a bill is final, so a saved bill is only compared on that (a shop makes
  /// thousands a year; comparing every column of every bill on each save would slow the app down).
  /// Filled by [load] and [save].
  final _savedBills = <String, String>{};
  final _savedActivity = <String>{}; // lines already in the database: the log is only ever added to

  Future<ShopData> load() async {
    // Every row is read, deleted ones too: a unit can still point at a category deleted later.
    final rooms = {for (final r in await _db.select(_db.rooms).get()) r.id: r};
    final categoryRows = await _db.select(_db.priceCategories).get();
    final categories = {for (final c in categoryRows) c.id: c};
    final customTypes = [for (final t in await _db.select(_db.unitTypes).get()) UnitType(id: t.id, name: t.name)];
    final types = {for (final t in [...UnitType.defaults, ...customTypes]) t.id: t};
    final productRows = await _db.select(_db.products).get();

    final sessions = await (_db.select(_db.sessions)..where((t) => t.status.equals('Active'))).get();
    final sessionIds = [for (final s in sessions) s.id];
    final stretches = await (_db.select(_db.sessionsUnits)..where((t) => t.sessionId.isIn(sessionIds))).get();
    final orderRows = await (_db.select(_db.sessionsProducts)..where((t) => t.sessionId.isIn(sessionIds) & t.deletedAt.isNull())).get();

    // A session belongs to the device its latest stretch is on.
    final sessionOfUnit = <String, (SessionRow, List<SessionUnitRow>)>{};
    for (final session in sessions) {
      final own = stretches.where((s) => s.sessionId == session.id).toList()..sort((a, b) => a.startedAt.compareTo(b.startedAt));
      if (own.isEmpty) continue;
      sessionOfUnit[own.last.unitId] = (session, own);
    }

    final unitRows = [for (final u in await _db.select(_db.units).get()) if (u.deletedAt == null) u]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final units = <Unit>[];
    final orders = <String, List<OrderLine>>{};
    for (final row in unitRows) {
      final categoryId = row.priceCategoryId;
      final room = rooms[row.roomId];
      final category = categoryId == null ? null : categories[categoryId];
      final type = types[row.unitTypeId];
      if (room == null || category == null || type == null) {
        throw StateError('Unit ${row.id} points at a room, price category or type that is missing.');
      }
      final own = sessionOfUnit[row.id];
      units.add(unitFromRows(
        UnitRows(unit: row, session: own?.$1, stretches: own?.$2 ?? const []),
        room: room,
        category: category,
        type: type,
      ));
      if (own != null) {
        // The line keeps the product's name as it is now; the table keeps only the product's id.
        final lines = [
          for (final r in orderRows)
            if (r.sessionId == own.$1.id)
              OrderLine(
                productId: r.productId,
                name: productRows.where((p) => p.id == r.productId).firstOrNull?.name ?? '',
                unitPrice: r.unitPrice,
                quantity: r.quantity,
                orderedAt: r.orderedAt,
              ),
        ]..sort((a, b) => a.orderedAt.compareTo(b.orderedAt));
        if (lines.isNotEmpty) orders[row.id] = lines;
      }
    }

    final movementRows = [for (final m in await _db.select(_db.stockMovements).get()) if (m.deletedAt == null) m]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final purchaseRows = [for (final p in await _db.select(_db.purchases).get()) if (p.deletedAt == null) p]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    // Bills, with the session each one closed (its start, device, mode and price).
    final billRows = [for (final b in await _db.select(_db.bills).get()) if (b.deletedAt == null) b]
      ..sort((a, b) => a.paidAt.compareTo(b.paidAt));
    final billItemRows = await _db.select(_db.billItems).get();
    final billSessionIds = [for (final b in billRows) if (b.sessionId != null) b.sessionId!];
    final billSessions = {for (final s in await (_db.select(_db.sessions)..where((t) => t.id.isIn(billSessionIds))).get()) s.id: s};
    final billStretches = await (_db.select(_db.sessionsUnits)..where((t) => t.sessionId.isIn(billSessionIds))).get();
    final bills = [
      for (final b in billRows)
        billFromRows(
          BillRows(bill: b, items: [for (final i in billItemRows) if (i.billId == b.id && i.deletedAt == null) i]),
          session: billSessions[b.sessionId],
          stretches: [for (final s in billStretches) if (s.sessionId == b.sessionId) s],
        ),
    ];
    _savedBills
      ..clear()
      ..addAll({for (final b in billRows) b.id: _discountOf(b.discount, b.discountNote)});
    final activityRows = await (_db.select(_db.activityLog)..orderBy([(t) => OrderingTerm.asc(t.occurredAt)])).get();
    _savedActivity
      ..clear()
      ..addAll([for (final r in activityRows) r.id]);

    final shiftRows = [for (final s in await _db.select(_db.shifts).get()) if (s.deletedAt == null) s]
      ..sort((a, b) => a.openedAt.compareTo(b.openedAt));
    final cashRows = [for (final m in await _db.select(_db.cashMovements).get()) if (m.deletedAt == null) m]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return ShopData(
      units: units,
      categories: [
        for (final c in categoryRows)
          if (c.deletedAt == null) PriceCategory(id: c.id, name: c.name, hourlyPrice: c.hourlyPrice, multiHourlyPrice: c.multiHourlyPrice),
      ],
      unitTypes: [...UnitType.defaults, ...customTypes],
      orders: orders,
      bills: bills,
      cashBox: CashBoxState(
        boxes: [
          for (final s in shiftRows)
            CashBox(
              id: s.id,
              openedAt: s.openedAt,
              openedById: s.openedByStaffId,
              openingCash: s.openingCash,
              closedAt: s.closedAt,
              closedById: s.closedByStaffId,
              expectedCash: s.expectedCash,
              countedCash: s.countedCash,
              note: s.note,
            ),
        ],
        movements: [
          for (final m in cashRows)
            CashMovement(
              id: m.id,
              cashBoxId: m.shiftId,
              type: CashMovementType.values.firstWhere((t) => _pascal(t) == m.type),
              amount: m.amount,
              staffId: m.staffId,
              at: m.createdAt,
              note: m.note,
              paidFrom: PaidFrom.values.firstWhere((p) => _pascal(p) == m.paidFrom),
              owed: m.owed,
              reimbursedAt: m.reimbursedAt,
              purchaseId: m.purchaseId,
              categoryId: m.categoryId,
            ),
        ],
      ),
      expenseCategories: [
        for (final c in await _db.select(_db.expenseCategories).get())
          if (c.deletedAt == null)
            ExpenseCategory(
              id: c.id,
              name: c.name,
              kind: ExpenseCategoryKind.values.firstWhere((k) => _pascal(k) == c.kind),
              active: c.isActive,
            ),
      ],
      activity: [
        for (final r in activityRows)
          ActivityEntry(
            id: r.id,
            at: r.occurredAt,
            staffId: r.staffId,
            kind: r.kind,
            suspicious: r.suspicious,
            details: r.details == null ? const {} : Map<String, Object?>.from(jsonDecode(r.details!) as Map),
          ),
      ],
      shopInfo: [
        for (final v in await _db.select(_db.venues).get())
          if (v.deletedAt == null)
            ShopInfo(
              id: v.id,
              name: v.name,
              phone: v.phone,
              instapay: v.instapayLink == null ? null : PaymentAccount(link: v.instapayLink!, handle: v.instapayHandle, phone: v.instapayPhone),
              wallet: v.walletLink == null ? null : PaymentAccount(link: v.walletLink!, phone: v.walletPhone),
            ),
      ].firstOrNull,
      staff: [
        // A stopped person is a soft-deleted row. They are still loaded (old bills show their name), as inactive.
        for (final r in await _db.select(_db.staff).get())
          StaffMember(
            id: r.id,
            name: r.name,
            phone: r.phone,
            pinHash: r.pinHash ?? '', // an empty value never matches a PIN, so nobody can sign in as them
            isAdmin: r.role == 'Admin',
            isOwner: r.isOwner,
            active: r.deletedAt == null,
          ),
      ],
      catalog: Catalog(
        products: [
          for (final p in productRows)
            if (p.deletedAt == null) Product(id: p.id, name: p.name, price: p.price, stockItemId: p.stockItemId),
        ],
        stockItems: [
          for (final s in await _db.select(_db.stockItems).get())
            if (s.deletedAt == null)
              StockItem(id: s.id, name: s.name, deductsOnSale: s.deductsOnSale, onHand: s.onHand, lowStockAt: s.lowStockAt),
        ],
        movements: [
          for (final m in movementRows)
            StockMovement(
              id: m.id,
              stockItemId: m.stockItemId,
              kind: StockMovementKind.values.firstWhere((k) => _kindName(k) == m.kind),
              quantity: m.quantity,
              at: m.createdAt,
              purchaseId: m.purchaseId,
              cost: m.cost,
              expected: m.expectedQuantity,
              note: m.note,
            ),
        ],
        purchases: [for (final p in purchaseRows) Purchase(id: p.id, total: p.total, at: p.createdAt)],
      ),
    );
  }

  /// The id of the shop already in [db]. A database from before the setup existed (it started with the sample
  /// shop) has no shop row but has data: it keeps [legacyId], which its rows already carry. A brand new
  /// database returns null: the first-run setup creates the shop.
  static Future<String?> existingVenueId(AppDatabase db, {required String legacyId}) async {
    final venues = await db.select(db.venues).get();
    if (venues.isNotEmpty) return venues.first.id;
    final hasData = (await db.select(db.units).get()).isNotEmpty || (await db.select(db.staff).get()).isNotEmpty;
    return hasData ? legacyId : null;
  }

  /// The wrong-PIN counts saved on this computer, by staff id.
  Future<Map<String, PinAttempts>> loadPinAttempts() async => {
        for (final r in await _db.select(_db.staffPinAttempts).get())
          r.staffId: PinAttempts(wrong: r.wrongCount, lockedUntil: r.lockedUntil),
      };

  Future<void> savePinAttempts(String staffId, PinAttempts attempts) => _db.into(_db.staffPinAttempts).insertOnConflictUpdate(
        PinAttemptRow(
          staffId: staffId,
          wrongCount: attempts.wrong,
          lockedUntil: attempts.lockedUntil == null ? null : wholeSeconds(attempts.lockedUntil!),
        ),
      );

  /// Makes the database match [data]. [staffId] and [now] go into the sync columns of what changes.
  Future<void> save(ShopData data, {required String staffId, DateTime? now}) async {
    final at = wholeSeconds(now ?? DateTime.now());

    // A room only exists through its devices, so the rooms are worked out from them.
    final roomRows = <RoomRow>[];
    for (final unit in data.units) {
      if (roomRows.any((r) => r.id == unit.roomId)) continue;
      roomRows.add(RoomRow(
        updatedAt: at,
        updatedByStaffId: staffId,
        id: unit.roomId,
        venueId: venueId,
        name: unit.roomName,
        sortOrder: roomRows.length,
      ));
    }
    final unitRows = <UnitRows>[
      for (var i = 0; i < data.units.length; i++)
        unitToRows(data.units[i], venueId: venueId, staffId: staffId, now: at, sortOrder: i),
    ];
    final categoryRows = [
      for (final c in data.categories)
        PriceCategoryRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: c.id,
          venueId: venueId,
          name: c.name,
          pricingMode: 'Hourly',
          hourlyPrice: c.hourlyPrice,
          multiHourlyPrice: c.multiHourlyPrice,
        ),
    ];
    final typeRows = [
      for (final t in data.unitTypes)
        if (!t.isDefault) UnitTypeRow(updatedAt: at, updatedByStaffId: staffId, id: t.id, venueId: venueId, name: t.name),
    ];
    final productRows = [
      for (final p in data.catalog.products)
        ProductRow(updatedAt: at, updatedByStaffId: staffId, id: p.id, venueId: venueId, name: p.name, price: p.price, stockItemId: p.stockItemId),
    ];
    final stockRows = [
      for (final s in data.catalog.stockItems)
        StockItemRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: s.id,
          venueId: venueId,
          name: s.name,
          deductsOnSale: s.deductsOnSale,
          onHand: s.onHand,
          lowStockAt: s.lowStockAt,
        ),
    ];
    final movementRows = [
      for (final m in data.catalog.movements)
        StockMovementRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: m.id,
          venueId: venueId,
          stockItemId: m.stockItemId,
          kind: _kindName(m.kind),
          quantity: m.quantity,
          purchaseId: m.purchaseId,
          expectedQuantity: m.expected,
          staffId: staffId,
          cost: m.cost,
          note: m.note,
          createdAt: wholeSeconds(m.at),
        ),
    ];
    final purchaseRows = [
      for (final p in data.catalog.purchases)
        PurchaseRow(updatedAt: at, updatedByStaffId: staffId, id: p.id, venueId: venueId, staffId: staffId, total: p.total, createdAt: wholeSeconds(p.at)),
    ];
    // The order lines of the sessions that are running now.
    final liveSessionIds = {for (final r in unitRows) if (r.session != null) r.session!.id};
    final orderRows = [
      for (final r in unitRows)
        if (r.session != null)
          for (final line in data.orders[r.unit.id] ?? const <OrderLine>[])
            SessionProductRow(
              updatedAt: at,
              updatedByStaffId: staffId,
              id: orderRowId(r.session!.id, line.productId),
              venueId: venueId,
              sessionId: r.session!.id,
              productId: line.productId,
              quantity: line.quantity,
              unitPrice: line.unitPrice,
              orderedAt: wholeSeconds(line.orderedAt),
            ),
    ];

    final expenseRows = [
      for (final c in data.expenseCategories)
        ExpenseCategoryRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: c.id,
          venueId: venueId,
          name: c.name,
          kind: _pascal(c.kind),
          isActive: c.active,
        ),
    ];
    final venueRows = [
      if (data.shopInfo != null)
        VenueRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: venueId,
          name: data.shopInfo!.name,
          phone: data.shopInfo!.phone,
          instapayLink: data.shopInfo!.instapay?.link,
          instapayHandle: data.shopInfo!.instapay?.handle,
          instapayPhone: data.shopInfo!.instapay?.phone,
          walletLink: data.shopInfo!.wallet?.link,
          walletPhone: data.shopInfo!.wallet?.phone,
        ),
    ];
    final staffRows = [
      for (final m in data.staff)
        StaffRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: m.id,
          venueId: venueId,
          name: m.name,
          phone: m.phone,
          pinHash: m.pinHash.isEmpty ? null : m.pinHash,
          role: m.isAdmin ? 'Admin' : 'Staff',
          isOwner: m.isOwner,
          deletedAt: m.active ? null : at, // stopped = soft delete, so the stop can sync
        ),
    ];
    final shiftRows = [
      for (final b in data.cashBox.boxes)
        ShiftRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: b.id,
          venueId: venueId,
          openedByStaffId: b.openedById,
          openedAt: wholeSeconds(b.openedAt),
          openingCash: b.openingCash,
          closedByStaffId: b.closedById,
          closedAt: b.closedAt == null ? null : wholeSeconds(b.closedAt!),
          expectedCash: b.expectedCash,
          countedCash: b.countedCash,
          note: b.note,
        ),
    ];
    final cashRows = [
      for (final m in data.cashBox.movements)
        CashMovementRow(
          updatedAt: at,
          updatedByStaffId: staffId,
          id: m.id,
          venueId: venueId,
          shiftId: m.cashBoxId,
          staffId: m.staffId,
          type: _pascal(m.type),
          amount: m.amount,
          note: m.note,
          paidFrom: _pascal(m.paidFrom),
          owed: m.owed,
          reimbursedAt: m.reimbursedAt == null ? null : wholeSeconds(m.reimbursedAt!),
          purchaseId: m.purchaseId,
          categoryId: m.categoryId,
          createdAt: wholeSeconds(m.at),
        ),
    ];
    // Only log lines that are not in the database yet. Lines are never changed or removed.
    final newActivity = [
      for (final e in data.activity)
        if (!_savedActivity.contains(e.id))
          ActivityRow(
            id: e.id,
            venueId: venueId,
            staffId: e.staffId,
            occurredAt: wholeSeconds(e.at),
            kind: e.kind,
            suspicious: e.suspicious,
            details: e.details.isEmpty ? null : jsonEncode(e.details),
          ),
    ];
    // Only bills that are not in the database yet. One that cannot be saved is reported and skipped: it
    // must not stop everything else from being saved.
    final newBills = <BillRows>[];
    final correctedBills = <Bill>[]; // saved before, with a different discount now (a correction)
    for (final bill in data.bills) {
      final saved = _savedBills[bill.id];
      if (saved != null) {
        if (saved != _discountOf(bill.discount, bill.discountReason)) correctedBills.add(bill);
        continue;
      }
      try {
        newBills.add(billToRows(bill, venueId: venueId, now: at));
      } on StateError catch (error) {
        debugPrint('A bill could not be saved: $error');
      }
    }

    await _db.transaction(() async {
      final existingRooms = await _db.select(_db.rooms).get();
      final existingUnits = await _db.select(_db.units).get();
      final existingCategories = await _db.select(_db.priceCategories).get();
      final existingTypes = await _db.select(_db.unitTypes).get();
      final existingProducts = await _db.select(_db.products).get();
      final existingStock = await _db.select(_db.stockItems).get();
      final existingMovements = await _db.select(_db.stockMovements).get();
      final existingPurchases = await _db.select(_db.purchases).get();
      final existingOrders = await _db.select(_db.sessionsProducts).get();
      final existingExpenseCategories = await _db.select(_db.expenseCategories).get();
      final existingVenues = await _db.select(_db.venues).get();
      final existingStaff = await _db.select(_db.staff).get();
      final existingShifts = await _db.select(_db.shifts).get();
      final existingCashMovements = await _db.select(_db.cashMovements).get();
      final knownSessions = {for (final s in await _db.select(_db.sessions).get()) s.id: s};

      // Rows that are gone are marked deleted, not removed, so the delete can sync.
      await _markDeleted(_db.rooms, existingRooms, {for (final r in roomRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          RoomsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.units, existingUnits, {for (final r in unitRows) r.unit.id}, (r) => r.id, (r) => r.deletedAt,
          UnitsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.priceCategories, existingCategories, {for (final r in categoryRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          PriceCategoriesCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.unitTypes, existingTypes, {for (final r in typeRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          UnitTypesCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.products, existingProducts, {for (final r in productRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          ProductsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.stockItems, existingStock, {for (final r in stockRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          StockItemsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.stockMovements, existingMovements, {for (final r in movementRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          StockMovementsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _markDeleted(_db.purchases, existingPurchases, {for (final r in purchaseRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          PurchasesCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      // An order line missing from a session that is still running was taken off by hand. The lines of a
      // session that is over stay: they are what was sold.
      await _markDeleted(
          _db.sessionsProducts,
          [for (final r in existingOrders) if (liveSessionIds.contains(r.sessionId)) r],
          {for (final r in orderRows) r.id},
          (r) => r.id,
          (r) => r.deletedAt,
          SessionsProductsCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));

      await _upsert(_db.rooms, existingRooms, roomRows, (r) => r.id);
      await _upsert(_db.priceCategories, existingCategories, categoryRows, (r) => r.id);
      await _upsert(_db.unitTypes, existingTypes, typeRows, (r) => r.id);
      await _upsert(_db.units, existingUnits, [for (final r in unitRows) r.unit], (r) => r.id);
      await _upsert(_db.products, existingProducts, productRows, (r) => r.id);
      await _upsert(_db.stockItems, existingStock, stockRows, (r) => r.id);
      // A movement or a purchase keeps the staff member who recorded it.
      final movementOwner = {for (final m in existingMovements) m.id: m.staffId};
      await _upsert(_db.stockMovements, existingMovements,
          [for (final m in movementRows) movementOwner[m.id] == null ? m : m.copyWith(staffId: movementOwner[m.id]!)], (r) => r.id);
      final purchaseOwner = {for (final p in existingPurchases) p.id: p.staffId};
      await _upsert(_db.purchases, existingPurchases,
          [for (final p in purchaseRows) purchaseOwner[p.id] == null ? p : p.copyWith(staffId: purchaseOwner[p.id]!)], (r) => r.id);

      await _markDeleted(_db.staff, existingStaff, {for (final r in staffRows) r.id}, (r) => r.id, (r) => r.deletedAt,
          StaffCompanion(deletedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
      await _upsert(_db.venues, existingVenues, venueRows, (r) => r.id);
      // A person stopped earlier keeps the time they were stopped; it must not change on every save.
      final stoppedAt = {for (final r in existingStaff) r.id: r.deletedAt};
      await _upsert(
          _db.staff,
          existingStaff,
          [for (final r in staffRows) r.deletedAt != null && stoppedAt[r.id] != null ? r.copyWith(deletedAt: Value(stoppedAt[r.id])) : r],
          (r) => r.id);
      await _upsert(_db.expenseCategories, existingExpenseCategories, expenseRows, (r) => r.id);
      await _upsert(_db.shifts, existingShifts, shiftRows, (r) => r.id);
      await _upsert(_db.cashMovements, existingCashMovements, cashRows, (r) => r.id);
      await _db.batch((b) => b.insertAll(_db.activityLog, newActivity, mode: InsertMode.insertOrIgnore));
      // Bills are written once, except a correction, which changes the discount and the total.
      // "Or ignore" makes a second try harmless.
      await _db.batch((b) {
        b.insertAll(_db.bills, [for (final r in newBills) r.bill], mode: InsertMode.insertOrIgnore);
        b.insertAll(_db.billItems, [for (final r in newBills) ...r.items], mode: InsertMode.insertOrIgnore);
      });
      for (final bill in correctedBills) {
        await (_db.update(_db.bills)..where((t) => t.id.equals(bill.id))).write(BillsCompanion(
          discount: Value(bill.discount),
          total: Value(bill.total),
          discountNote: Value(bill.discountReason),
          updatedAt: Value(at),
          updatedByStaffId: Value(staffId),
        ));
      }

      // Sessions. One that already exists keeps the staff member who started it.
      final liveSessions = [
        for (final r in unitRows)
          if (r.session != null)
            knownSessions[r.session!.id] == null ? r.session! : r.session!.copyWith(staffId: knownSessions[r.session!.id]!.staffId),
      ];
      await _upsert(_db.sessions, knownSessions.values.toList(), liveSessions, (r) => r.id);
      await _upsert(_db.sessionsUnits, await _db.select(_db.sessionsUnits).get(), [for (final r in unitRows) ...r.stretches], (r) => r.id);
      await _upsert(_db.sessionsProducts, existingOrders, orderRows, (r) => r.id);

      // A session that was Active and has no device any more was paid: it is over. A stretch still open
      // ends now (the bill is made at the moment of payment).
      final over = [for (final s in knownSessions.values) if (s.status == 'Active' && !liveSessionIds.contains(s.id)) s.id];
      final paidSessionIds = {for (final b in data.bills) if (b.sessionId != null) b.sessionId!};
      if (over.isNotEmpty) {
        await (_db.update(_db.sessionsUnits)..where((t) => t.sessionId.isIn(over) & t.endedAt.isNull()))
            .write(SessionsUnitsCompanion(endedAt: Value(at), updatedAt: Value(at), updatedByStaffId: Value(staffId)));
        // A session with a bill was paid; one without was cancelled (decision #63).
        for (final id in over) {
          await (_db.update(_db.sessions)..where((t) => t.id.equals(id))).write(SessionsCompanion(
            status: Value(paidSessionIds.contains(id) ? 'Completed' : 'Cancelled'),
            updatedAt: Value(at),
            updatedByStaffId: Value(staffId),
          ));
        }
      }
    });
    // Only after the transaction went through.
    _savedBills.addAll({for (final r in newBills) r.bill.id: _discountOf(r.bill.discount, r.bill.discountNote)});
    for (final bill in correctedBills) {
      _savedBills[bill.id] = _discountOf(bill.discount, bill.discountReason);
    }
    _savedActivity.addAll([for (final e in newActivity) e.id]);
  }

  String _discountOf(int discount, String? note) => '$discount|${note ?? ''}';

  /// A row counts as changed when anything but the two "who and when" columns differs.
  String _content(DataClass row) => jsonEncode(row.toJson()..remove('updatedAt')..remove('updatedByStaffId'));

  Future<void> _upsert<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    List<D> existing,
    List<D> next,
    String Function(D) idOf,
  ) async {
    final old = {for (final row in existing) idOf(row): row};
    final changed = [
      for (final row in next)
        if (old[idOf(row)] == null || _content(old[idOf(row)]!) != _content(row)) row,
    ];
    if (changed.isEmpty) return;
    // The update spells out EVERY column, empty ones too. (insertAllOnConflictUpdate leaves a null column out,
    // so a value that was cleared, like a removed payment account or a phone, would have stayed in the row.)
    await _db.batch((b) {
      for (final row in changed.cast<Insertable<D>>()) {
        b.insert(table, row, onConflict: DoUpdate<T, D>((_) => RawValuesInsertable<D>(row.toColumns(false))));
      }
    });
  }

  /// Marks every live row of [existing] whose id is not in [keep] as deleted ([deleted] sets the three
  /// columns that say so).
  Future<void> _markDeleted<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    List<D> existing,
    Set<String> keep,
    String Function(D) idOf,
    DateTime? Function(D) deletedAtOf,
    Insertable<D> deleted,
  ) async {
    final ids = [for (final row in existing) if (deletedAtOf(row) == null && !keep.contains(idOf(row))) idOf(row)];
    if (ids.isEmpty) return;
    final idColumn = table.columnsByName['id']! as GeneratedColumn<String>;
    await (_db.update(table)..where((_) => idColumn.isIn(ids))).write(deleted);
  }
}
