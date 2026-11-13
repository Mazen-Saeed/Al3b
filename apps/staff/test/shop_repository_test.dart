import 'package:al3b_staff/data/activity_log.dart';
import 'package:al3b_staff/data/bill.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/catalog_provider.dart';
import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/shop_repository.dart';
import 'package:al3b_staff/data/expense_category.dart';
import 'package:al3b_staff/data/price_category.dart';
import 'package:al3b_staff/data/pin_attempts.dart';
import 'package:al3b_staff/data/pin_hasher.dart';
import 'package:al3b_staff/data/product.dart';
import 'package:al3b_staff/data/staff_member.dart';
import 'package:al3b_staff/data/stock.dart';
import 'package:al3b_staff/data/unit.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final day = DateTime(2026, 1, 2);
  DateTime at(int hour, [int minute = 0]) => DateTime(day.year, day.month, day.day, hour, minute);

  const customType = UnitType(id: 'type-cars', name: 'عربيات');
  const categories = [
    PriceCategory(id: 'cat-ps5', name: 'PS5 عادي', hourlyPrice: 5000, multiHourlyPrice: 7000),
    PriceCategory(id: 'cat-billiards', name: 'بلياردو عادي', hourlyPrice: 6000),
  ];

  Unit unit(
    String id, {
    String roomId = 'hall-1',
    String roomName = 'صالة 1',
    String categoryId = 'cat-ps5',
    UnitType type = UnitType.playstation,
    UnitStatus status = UnitStatus.free,
    DateTime? startedAt,
    String? sessionId,
    String? name,
  }) =>
      Unit(
        id: id,
        name: name ?? id.toUpperCase(),
        type: type,
        roomId: roomId,
        roomName: roomName,
        categoryId: categoryId,
        status: status,
        hourlyPrice: categoryId == 'cat-ps5' ? 5000 : 6000,
        multiHourlyPrice: categoryId == 'cat-ps5' ? 7000 : null,
        startedAt: startedAt,
        sessionId: sessionId,
      );

  Unit runningUnit() => unit('ps5-1', status: UnitStatus.running, startedAt: at(8), sessionId: 's1').withModeSwitched(at(8, 30));

  List<Unit> shop({Unit? first}) => [
        first ?? runningUnit(),
        unit('ps5-2'),
        unit('bil-1', roomId: 'hall-2', roomName: 'صالة 2', categoryId: 'cat-billiards', type: UnitType.billiards),
        unit('car-1', roomId: 'hall-2', roomName: 'صالة 2', type: customType),
      ];

  ShopData data(List<Unit> units) =>
      ShopData(units: units, categories: categories, unitTypes: [...UnitType.defaults, customType]);

  late AppDatabase db;
  late ShopRepository repo;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ShopRepository(db, venueId: 'v1');
  });
  tearDown(() => db.close());

  test('an empty database loads as empty', () async {
    final loaded = await repo.load();
    expect(loaded.isEmpty, isTrue);
    expect(loaded.unitTypes, UnitType.defaults);
  });

  test('what is saved comes back: devices in order, rooms, prices, types and the running session', () async {
    final original = runningUnit();
    await repo.save(data(shop(first: original)), staffId: 'staff-1', now: at(9));

    final loaded = await repo.load();

    expect(loaded.units.map((u) => u.id), ['ps5-1', 'ps5-2', 'bil-1', 'car-1']);
    expect(loaded.units.map((u) => u.roomName), ['صالة 1', 'صالة 1', 'صالة 2', 'صالة 2']);
    expect(loaded.units.last.type, customType);
    expect(loaded.categories.map((c) => c.id), ['cat-ps5', 'cat-billiards']);
    expect(loaded.unitTypes, [...UnitType.defaults, customType]);
    final back = loaded.units.first;
    expect(back.status, UnitStatus.running);
    expect(back.sessionId, 's1');
    expect(back.parts, original.parts);
    expect(back.costAt(at(10)), original.costAt(at(10)));
  });

  test('a room exists once however many devices it has', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));

    final rooms = await db.select(db.rooms).get();

    expect(rooms.map((r) => (r.id, r.sortOrder)), [('hall-1', 0), ('hall-2', 1)]);
  });

  test('saving the same state again writes nothing', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));
    await repo.save(data(shop()), staffId: 'staff-2', now: at(10));

    for (final row in await db.select(db.units).get()) {
      expect(row.updatedAt, at(9));
      expect(row.updatedByStaffId, 'staff-1');
    }
    expect((await db.select(db.sessionsUnits).get()).every((r) => r.updatedAt == at(9)), isTrue);
  });

  test('only a changed device is rewritten', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));
    final changed = shop()..[1] = unit('ps5-2', name: 'PS5 الجديد');

    await repo.save(data(changed), staffId: 'staff-2', now: at(10));

    final rows = {for (final r in await db.select(db.units).get()) r.id: r};
    expect(rows['ps5-2']!.updatedAt, at(10));
    expect(rows['ps5-2']!.updatedByStaffId, 'staff-2');
    expect(rows['ps5-2']!.name, 'PS5 الجديد');
    expect(rows['bil-1']!.updatedAt, at(9));
  });

  test('a removed device is marked deleted, not removed, and is not loaded', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));

    await repo.save(data(shop()..removeAt(1)), staffId: 'staff-1', now: at(10));

    final rows = {for (final r in await db.select(db.units).get()) r.id: r};
    expect(rows.length, 4);
    expect(rows['ps5-2']!.deletedAt, at(10));
    expect((await repo.load()).units.map((u) => u.id), ['ps5-1', 'bil-1', 'car-1']);
  });

  test('a session that ends without a bill is cancelled and its open stretch ends', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));

    await repo.save(data(shop(first: unit('ps5-1'))), staffId: 'staff-1', now: at(10)); // free again, no bill

    final session = (await db.select(db.sessions).get()).single;
    expect(session.status, 'Cancelled');
    final stretches = await db.select(db.sessionsUnits).get();
    expect(stretches.every((s) => s.endedAt != null), isTrue);
    expect(stretches.map((s) => s.endedAt).contains(at(10)), isTrue); // the open one ended at the payment
    expect((await repo.load()).units.first.status, UnitStatus.free);
  });

  final tea = OrderLine(productId: 'p1', name: 'شاي', unitPrice: 1000, quantity: 2, orderedAt: at(8, 10));
  final catalog = Catalog(
    products: const [Product(id: 'p1', name: 'شاي', price: 1000, stockItemId: 'st1')],
    stockItems: const [StockItem(id: 'st1', name: 'شاي', deductsOnSale: false, onHand: 40, lowStockAt: 5)],
    movements: [
      StockMovement(id: 'm1', stockItemId: 'st1', kind: StockMovementKind.purchase, quantity: 50, at: at(7), purchaseId: 'pu1', cost: 20000),
      StockMovement(id: 'm2', stockItemId: 'st1', kind: StockMovementKind.count, quantity: 40, at: at(8), expected: 42, note: 'كوباية اتكسرت'),
    ],
    purchases: [Purchase(id: 'pu1', total: 20000, at: at(7))],
  );
  ShopData withOrders({Catalog? withCatalog, Map<String, List<OrderLine>> orders = const {}, Unit? first}) => ShopData(
        units: shop(first: first),
        categories: categories,
        unitTypes: [...UnitType.defaults, customType],
        catalog: withCatalog ?? catalog,
        orders: orders,
      );

  test('the menu, the stock, the purchases and an order come back as they were', () async {
    await repo.save(withOrders(orders: {'ps5-1': [tea]}), staffId: 'staff-1', now: at(9));

    final loaded = await repo.load();

    expect(loaded.catalog.products.single.stockItemId, 'st1');
    expect(loaded.catalog.stockItems.single.onHand, 40);
    expect(loaded.catalog.stockItems.single.lowStockAt, 5);
    expect(loaded.catalog.stockItems.single.deductsOnSale, isFalse);
    expect(loaded.catalog.movements.map((m) => (m.id, m.kind, m.quantity)), [('m1', StockMovementKind.purchase, 50), ('m2', StockMovementKind.count, 40)]);
    expect(loaded.catalog.movements.first.cost, 20000);
    expect(loaded.catalog.movements.first.purchaseId, 'pu1');
    expect(loaded.catalog.movements.last.expected, 42);
    expect(loaded.catalog.movements.last.note, 'كوباية اتكسرت');
    expect(loaded.catalog.purchases.single.total, 20000);
    final line = loaded.orders['ps5-1']!.single;
    expect((line.productId, line.name, line.unitPrice, line.quantity, line.orderedAt), ('p1', 'شاي', 1000, 2, at(8, 10)));
  });

  test('an order line taken off a running session is marked deleted', () async {
    await repo.save(withOrders(orders: {'ps5-1': [tea]}), staffId: 'staff-1', now: at(9));

    await repo.save(withOrders(), staffId: 'staff-1', now: at(10)); // the session still runs, the line is gone

    expect((await db.select(db.sessionsProducts).get()).single.deletedAt, at(10));
    expect((await repo.load()).orders, isEmpty);
  });

  test('the lines of a session that was paid stay as what was sold', () async {
    await repo.save(withOrders(orders: {'ps5-1': [tea]}), staffId: 'staff-1', now: at(9));

    await repo.save(withOrders(first: unit('ps5-1')), staffId: 'staff-1', now: at(10)); // paid: free again, no lines

    final row = (await db.select(db.sessionsProducts).get()).single;
    expect(row.deletedAt, isNull);
    expect(row.quantity, 2);
  });

  test('a stock movement keeps the staff member who recorded it', () async {
    await repo.save(withOrders(), staffId: 'staff-1', now: at(9));

    await repo.save(withOrders(), staffId: 'staff-2', now: at(10));

    expect((await db.select(db.stockMovements).get()).every((m) => m.staffId == 'staff-1'), isTrue);
    expect((await db.select(db.purchases).get()).single.staffId, 'staff-1');
  });

  Bill paidBill({String? cashier = 'staff-1', String id = 'b1'}) => Bill(
        id: id,
        sessionId: 's1',
        paidAt: at(10),
        unitId: 'ps5-1',
        unitName: 'PS5-1',
        startedAt: at(8),
        endedAt: at(10),
        isMulti: true,
        hourlyPrice: 7000,
        playCost: 14000,
        lines: [tea],
        discount: 0,
        method: PaymentMethod.cash,
        cashBoxId: 'box1',
        takenById: cashier,
      );

  test('a paid bill is saved with its session, and a restart finds it', () async {
    await repo.save(withOrders(orders: {'ps5-1': [tea]}), staffId: 'staff-1', now: at(9));
    final paid = ShopData(
      units: shop(first: unit('ps5-1')), // paid: free again
      categories: categories,
      unitTypes: [...UnitType.defaults, customType],
      catalog: catalog,
      bills: [paidBill()],
    );

    await repo.save(paid, staffId: 'staff-1', now: at(10));

    expect((await db.select(db.sessions).get()).single.status, 'Completed'); // it has a bill: it was paid
    final restarted = ShopRepository(db, venueId: 'v1'); // a new run of the app: it knows nothing yet
    final bill = (await restarted.load()).bills.single;
    expect(bill.unitId, 'ps5-1');
    expect(bill.startedAt, at(8)); // the session's start
    expect(bill.endedAt, at(10)); // the last stretch ended when it was paid
    expect(bill.isMulti, isTrue);
    expect(bill.playCost, 14000);
    expect(bill.lines.single.name, 'شاي');
    expect(bill.total, 14000 + 2000);
    expect(bill.method, PaymentMethod.cash);
  });

  test('a corrected bill changes its discount and total in the database, and nothing else', () async {
    ShopData withBill(Bill bill) => ShopData(
          units: shop(first: unit('ps5-1')),
          categories: categories,
          unitTypes: [...UnitType.defaults, customType],
          catalog: catalog,
          bills: [bill],
        );
    await repo.save(withOrders(orders: {'ps5-1': [tea]}), staffId: 'staff-1', now: at(9));
    await repo.save(withBill(paidBill()), staffId: 'staff-1', now: at(10));

    await repo.save(withBill(paidBill().withDiscount(3000)), staffId: 'staff-2', now: at(11));

    final row = (await db.select(db.bills).get()).single;
    expect((row.discount, row.total, row.subtotal), (3000, 13000, 16000));
    expect((row.updatedAt, row.updatedByStaffId), (at(11), 'staff-2'));
    expect((await ShopRepository(db, venueId: 'v1').load()).bills.single.total, 13000);
    expect((await db.select(db.billItems).get()).length, 2); // the lines were not touched

    await repo.save(withBill(paidBill().withDiscount(3000)), staffId: 'staff-3', now: at(12)); // the same again
    expect((await db.select(db.bills).get()).single.updatedAt, at(11));
  });

  test('a bill is written once: saving again does not touch it', () async {
    final data = ShopData(
      units: shop(),
      categories: categories,
      unitTypes: [...UnitType.defaults, customType],
      bills: [Bill.quickSale(id: 'q1', at: at(9), lines: [tea], method: PaymentMethod.cash, cashBoxId: 'box1', takenById: 'staff-1')],
    );
    await repo.save(data, staffId: 'staff-1', now: at(9));

    await repo.save(data, staffId: 'staff-2', now: at(10));

    final row = (await db.select(db.bills).get()).single;
    expect(row.updatedAt, at(9));
    expect(row.updatedByStaffId, 'staff-1');
    expect((await db.select(db.billItems).get()).length, 1);
  });

  test('a bill that cannot be saved is skipped and everything else is still saved', () async {
    final data = ShopData(
      units: shop(),
      categories: categories,
      unitTypes: [...UnitType.defaults, customType],
      bills: [paidBill(cashier: null, id: 'bad'), paidBill(id: 'good')],
    );

    await repo.save(data, staffId: 'staff-1', now: at(9));

    expect((await repo.load()).bills.map((b) => b.id), ['good']);
    expect((await repo.load()).units, isNotEmpty);
  });

  test('cash boxes, cash movements and expense types come back, and paying someone back is saved', () async {
    final owed = CashMovement(
      id: 'c1',
      cashBoxId: 'box1',
      type: CashMovementType.expense,
      amount: 2000,
      staffId: 'staff-2',
      at: at(9),
      note: 'مياه',
      paidFrom: PaidFrom.pocket,
      owed: true,
      categoryId: ExpenseCategoryIds.utilities,
    );
    final box = CashBox(
      id: 'box1',
      openedAt: at(7),
      openedById: 'staff-1',
      openingCash: 50000,
      closedAt: at(15),
      closedById: 'staff-1',
      expectedCash: 90000,
      countedCash: 89000,
      note: 'ناقص',
    );
    ShopData cashData(CashMovement movement) => ShopData(
          units: shop(),
          categories: categories,
          unitTypes: [...UnitType.defaults, customType],
          cashBox: CashBoxState(boxes: [box], movements: [movement]),
          expenseCategories: [...defaultExpenseCategories.take(2), defaultExpenseCategories[2].copyWith(active: false)],
        );
    await repo.save(cashData(owed), staffId: 'staff-1', now: at(9));

    final loaded = await repo.load();

    final b = loaded.cashBox.boxes.single;
    expect((b.openingCash, b.expectedCash, b.countedCash, b.difference, b.note), (50000, 90000, 89000, -1000, 'ناقص'));
    final m = loaded.cashBox.movements.single;
    expect((m.type, m.amount, m.paidFrom, m.owed, m.categoryId, m.staffId), (CashMovementType.expense, 2000, PaidFrom.pocket, true, ExpenseCategoryIds.utilities, 'staff-2'));
    expect(loaded.cashBox.owed, {'staff-2': 2000});
    expect(loaded.expenseCategories.map((c) => (c.name, c.kind, c.active)), [
      ('مخزون', ExpenseCategoryKind.stock, true),
      ('مرتبات', ExpenseCategoryKind.normal, true),
      ('إيجار', ExpenseCategoryKind.normal, false),
    ]);

    await repo.save(cashData(owed.reimbursed(at(16))), staffId: 'staff-1', now: at(16));

    final after = (await repo.load()).cashBox;
    expect(after.movements.single.reimbursedAt, at(16));
    expect(after.owed, isEmpty);
  });

  test('a session keeps the staff member who started it', () async {
    await repo.save(data(shop()), staffId: 'staff-1', now: at(9));

    await repo.save(data(shop(first: runningUnit().withModeSwitched(at(9, 20)))), staffId: 'staff-2', now: at(10));

    expect((await db.select(db.sessions).get()).single.staffId, 'staff-1');
  });

  test('staff are saved with a PIN hash and never the PIN itself', () async {
    const hasher = PinHasher(iterations: 5);
    final staff = [
      StaffMember(id: 'staff-1', name: 'مازن', pinHash: hasher.hash('4821'), isAdmin: true, isOwner: true),
      StaffMember(id: 'staff-2', name: 'أحمد', pinHash: hasher.hash('1111')),
    ];
    await repo.save(ShopData(units: shop(), categories: categories, unitTypes: [...UnitType.defaults, customType], staff: staff),
        staffId: 'staff-1', now: at(9));

    final loaded = (await repo.load()).staff;

    expect(loaded.map((s) => (s.id, s.name, s.isAdmin, s.isOwner)), [
      ('staff-1', 'مازن', true, true),
      ('staff-2', 'أحمد', false, false),
    ]);
    expect(PinHasher.verify('4821', loaded.first.pinHash), isTrue);
    expect(PinHasher.verify('1111', loaded.first.pinHash), isFalse);
    final stored = (await db.select(db.staff).get()).map((r) => r.pinHash).join();
    expect(stored, isNot(contains('4821')));

    // Taking someone off the list marks the row deleted; it does not remove it, and they load back as stopped.
    await repo.save(ShopData(units: shop(), categories: categories, unitTypes: [...UnitType.defaults, customType], staff: [staff.first]),
        staffId: 'staff-1', now: at(10));
    expect((await repo.load()).staff.map((s) => (s.id, s.active)), [('staff-1', true), ('staff-2', false)]);
    expect((await db.select(db.staff).get()).length, 2);
  });

  test('a wrong-PIN count is saved, updated and loaded back', () async {
    expect(await repo.loadPinAttempts(), isEmpty);

    await repo.savePinAttempts('staff-2', PinAttempts(wrong: 5, lockedUntil: at(9, 1)));
    await repo.savePinAttempts('staff-3', const PinAttempts(wrong: 2));
    await repo.savePinAttempts('staff-3', const PinAttempts()); // a right PIN resets it

    final loaded = await repo.loadPinAttempts();
    expect(loaded['staff-2'], PinAttempts(wrong: 5, lockedUntil: at(9, 1)));
    expect(loaded['staff-3'], const PinAttempts());
  });

  test('a stopped person stays in the list as inactive, and the stop time does not change on later saves', () async {
    const hasher = PinHasher(iterations: 5);
    final stopped = StaffMember(id: 'staff-2', name: 'أحمد', pinHash: hasher.hash('1111'), active: false);
    final staff = [StaffMember(id: 'staff-1', name: 'مازن', pinHash: hasher.hash('1234'), isAdmin: true, isOwner: true), stopped];
    ShopData withStaff() => ShopData(units: shop(), categories: categories, unitTypes: [...UnitType.defaults, customType], staff: staff);

    await repo.save(withStaff(), staffId: 'staff-1', now: at(9));
    final loaded = (await repo.load()).staff;
    expect(loaded.map((s) => (s.id, s.active)), [('staff-1', true), ('staff-2', false)]);

    await repo.save(withStaff(), staffId: 'staff-1', now: at(12));
    expect((await db.select(db.staff).get()).firstWhere((r) => r.id == 'staff-2').deletedAt, at(9));
  });

  test('the activity log keeps its lines with their details, and a later save adds only the new ones', () async {
    final first = ActivityEntry(id: 'e1', at: at(9), staffId: 'staff-1', kind: 'cash_withdrawal', suspicious: true, details: const {'amount': 5000, 'note': null});
    ShopData withLog(List<ActivityEntry> log) =>
        ShopData(units: shop(), categories: categories, unitTypes: [...UnitType.defaults, customType], activity: log);

    await repo.save(withLog([first]), staffId: 'staff-1', now: at(9));
    final second = ActivityEntry(id: 'e2', at: at(10), staffId: 'staff-2', kind: 'staff_added', details: const {'name': 'منى'});
    await repo.save(withLog([first, second]), staffId: 'staff-1', now: at(10));
    await repo.save(withLog([first, second]), staffId: 'staff-1', now: at(11));

    final loaded = (await repo.load()).activity;
    expect(loaded.map((e) => e.id), ['e1', 'e2']);
    expect((loaded.first.suspicious, loaded.first.number('amount'), loaded.first.details['note']), (true, 5000, null));
    expect(loaded.last.text('name'), 'منى');
    expect((await db.select(db.activityLog).get()).length, 2);
  });
}
