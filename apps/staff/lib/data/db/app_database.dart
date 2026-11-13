import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// The shop device's SQLite database (decision #51, #65). The tables are copies of the backend's:
// same names, same columns, same ids (uuid text). So sync can send a row as it is.
// Differences, all on purpose:
//  - Money columns hold whole piasters (an int), as the app does everywhere. Sync divides by 100 on the
//    way up and multiplies by 100 on the way down (decision #51, rule 2).
//  - Enums are text with the same words as the backend ("Active", "Multi").
//  - No foreign keys here: the backend enforces them when the rows arrive.
// The generated file app_database.g.dart comes from: dart run build_runner build

/// The sync columns every synced table has (see SyncedEntity in the backend).
mixin SyncColumns on Table {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  DateTimeColumn get updatedAt => dateTime()();

  /// Who made the last change.
  TextColumn get updatedByStaffId => text().nullable()();

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

/// The shop this computer runs: one row. The backend's `venues` has more columns (address, opening hours,
/// payment links...); they are added here as those settings move into the database.
/// The activity log (decision #63): who did what, and when. Only ever added to, never updated or removed
/// (the backend refuses both), so there are no sync columns: sync sends the lines it has not sent yet.
@DataClassName('ActivityRow')
class ActivityLog extends Table {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get staffId => text()(); // who did it; no foreign key, so a stopped person's lines stay
  TextColumn get deviceId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get kind => text()();
  BoolColumn get suspicious => boolean().withDefault(const Constant(false))();
  TextColumn get details => text().nullable()(); // JSON

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VenueRow')
class Venues extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text()();

  // Where customers pay (#20). Null = not set up: checkout shows no QR for it. Same names as the backend's venue.
  TextColumn get instapayLink => text().nullable()();
  TextColumn get instapayHandle => text().nullable()();
  TextColumn get instapayPhone => text().nullable()();
  TextColumn get walletLink => text().nullable()();
  TextColumn get walletPhone => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RoomRow')
class Rooms extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The built-in types are not stored here (they are in the code and the backend). Only the shop's own.
@DataClassName('UnitTypeRow')
class UnitTypes extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text().nullable()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PriceCategoryRow')
class PriceCategories extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  TextColumn get pricingMode => text().withDefault(const Constant('Hourly'))();
  IntColumn get hourlyPrice => integer()(); // piasters
  IntColumn get multiHourlyPrice => integer().nullable()(); // piasters

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UnitRow')
class Units extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get roomId => text()();
  TextColumn get unitTypeId => text()();
  TextColumn get priceCategoryId => text().nullable()(); // null = no category (the backend requires one)
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('Active'))(); // Active, Maintenance, Disabled
  TextColumn get maintenanceNote => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionRow')
class Sessions extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get reservationId => text().nullable()();
  TextColumn get customerId => text().nullable()();
  TextColumn get walkInCustomerId => text().nullable()();
  TextColumn get staffId => text()(); // who started it
  TextColumn get status => text().withDefault(const Constant('Active'))(); // Active, Completed, Cancelled
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One device used during a session. A stop, a move or a single/pair switch closes the current row
/// and (for all but a stop) opens the next one (decision #51).
@DataClassName('SessionUnitRow')
class SessionsUnits extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get sessionId => text()();
  TextColumn get unitId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get mode => text()(); // Single, Multi
  IntColumn get plannedMinutes => integer().nullable()();
  IntColumn get hourlyPrice => integer()(); // piasters, the price at the time

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionProductRow')
class SessionsProducts extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get sessionId => text()();
  TextColumn get productId => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get unitPrice => integer()(); // piasters, the price at the time
  DateTimeColumn get orderedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// What the shop sells. The price is piasters.
@DataClassName('ProductRow')
class Products extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  IntColumn get price => integer()(); // piasters
  TextColumn get stockItemId => text().nullable()(); // null = not counted in stock

  @override
  Set<Column> get primaryKey => {id};
}

/// Something bought and counted. [onHand] may go below 0: an offline sale is never refused.
@DataClassName('StockItemRow')
class StockItems extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  BoolColumn get deductsOnSale => boolean()();
  IntColumn get onHand => integer().withDefault(const Constant(0))();
  IntColumn get lowStockAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// What staff did by hand to a stock item: Purchase, Opened or Count. Never overwritten.
@DataClassName('StockMovementRow')
class StockMovements extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get stockItemId => text()();
  TextColumn get kind => text()(); // Purchase, Opened, Count
  IntColumn get quantity => integer()();
  TextColumn get purchaseId => text().nullable()();
  IntColumn get expectedQuantity => integer().nullable()(); // a Count only
  TextColumn get staffId => text()(); // who recorded it
  IntColumn get cost => integer().nullable()(); // piasters for the whole quantity, a Purchase only
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One shopping trip: what was on the receipt.
@DataClassName('PurchaseRow')
class Purchases extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get staffId => text()(); // who recorded it
  IntColumn get total => integer()(); // piasters
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A paid session or quick sale. Written once when it is paid.
@DataClassName('BillRow')
class Bills extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get sessionId => text().nullable()(); // null = a quick sale
  TextColumn get staffId => text()(); // who took the payment
  TextColumn get shiftId => text()(); // the cash box that was open
  IntColumn get subtotal => integer()(); // piasters, before the discount
  IntColumn get discount => integer()();
  IntColumn get total => integer()(); // after the discount: what was paid
  TextColumn get discountNote => text().nullable()();
  TextColumn get paymentMethod => text()(); // Cash, Instapay, Wallet
  DateTimeColumn get paidAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One line of a bill, copied at payment. The play-time line has no product; its description is the
/// device's name.
@DataClassName('BillItemRow')
class BillItems extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get billId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get description => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get unitPrice => integer()(); // piasters
  IntColumn get total => integer()(); // quantity x unitPrice

  @override
  Set<Column> get primaryKey => {id};
}

/// A cash box: opening cash, then closing count. The app calls it a cash box, the backend a shift.
@DataClassName('ShiftRow')
class Shifts extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get openedByStaffId => text()();
  DateTimeColumn get openedAt => dateTime()();
  IntColumn get openingCash => integer()(); // piasters
  TextColumn get closedByStaffId => text().nullable()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  IntColumn get expectedCash => integer().nullable()(); // a snapshot made at closing
  IntColumn get countedCash => integer().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Money in or out of the cash box that is not a bill.
@DataClassName('CashMovementRow')
class CashMovements extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get shiftId => text().nullable()(); // null: paid from a pocket with no cash box open
  TextColumn get staffId => text()(); // who recorded it
  TextColumn get type => text()(); // Expense, CashIn, OwnerWithdrawal
  IntColumn get amount => integer()(); // piasters, above 0
  TextColumn get note => text().nullable()();
  TextColumn get paidFrom => text().withDefault(const Constant('CashBox'))(); // CashBox, Pocket
  BoolColumn get owed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get reimbursedAt => dateTime().nullable()();
  TextColumn get purchaseId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// What an expense was for. Removing one sets [isActive] to false (old expenses keep its name).
@DataClassName('ExpenseCategoryRow')
class ExpenseCategories extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()(); // Normal, Stock, Other, Repayment
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The people who work at the shop. The backend keeps this in two tables (staff and staff_venues);
/// on the shop PC both are one row, because the PC only knows its own shop. Sync splits it again.
/// There is no password here: a PIN is only for switching people on the shop computer (decision #36).
@DataClassName('StaffRow')
class Staff extends Table with SyncColumns {
  TextColumn get id => text()();
  TextColumn get venueId => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()(); // the backend needs one; the owner adds it with the real staff
  TextColumn get pinHash => text().nullable()(); // from PinHasher; null = no PIN set yet
  TextColumn get role => text()(); // Admin, Staff
  BoolColumn get isOwner => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Wrong-PIN counts. Local to this computer: not a backend table and never synced (no sync columns),
/// because a lockout only means something on the computer where the PIN is typed.
@DataClassName('PinAttemptRow')
class StaffPinAttempts extends Table {
  TextColumn get staffId => text()();
  IntColumn get wrongCount => integer()();
  DateTimeColumn get lockedUntil => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {staffId};
}

@DriftDatabase(tables: [
  Rooms,
  UnitTypes,
  PriceCategories,
  Units,
  Sessions,
  SessionsUnits,
  SessionsProducts,
  Products,
  StockItems,
  StockMovements,
  Purchases,
  Bills,
  BillItems,
  Shifts,
  CashMovements,
  ExpenseCategories,
  Staff,
  StaffPinAttempts,
  Venues,
  ActivityLog,
])
class AppDatabase extends _$AppDatabase {
  /// Tests pass an in-memory database here.
  AppDatabase(super.executor);

  /// The real one: [file] in the app's data folder (main.dart picks it, because the backups need the same path).
  AppDatabase.onDisk(File file) : super(driftDatabase(name: 'al3b', native: DriftNativeOptions(databasePath: () async => file.path)));

  // 1: devices, sessions. 2: products, stock, purchases. 3: bills, cash boxes, cash movements, expense types. 4: staff. 5: wrong-PIN counts. 6: the shop (venues). 7: the activity log. 8: the shop's payment accounts.
  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(products);
            await m.createTable(stockItems);
            await m.createTable(stockMovements);
            await m.createTable(purchases);
          }
          if (from < 3) {
            await m.createTable(bills);
            await m.createTable(billItems);
            await m.createTable(shifts);
            await m.createTable(cashMovements);
            await m.createTable(expenseCategories);
          }
          if (from < 4) {
            await m.createTable(staff);
          }
          if (from < 5) {
            await m.createTable(staffPinAttempts);
          }
          if (from < 6) {
            await m.createTable(venues);
          }
          if (from < 7) {
            await m.createTable(activityLog);
          }
          if (from < 8) {
            await m.addColumn(venues, venues.instapayLink);
            await m.addColumn(venues, venues.instapayHandle);
            await m.addColumn(venues, venues.instapayPhone);
            await m.addColumn(venues, venues.walletLink);
            await m.addColumn(venues, venues.walletPhone);
          }
        },
      );
}
