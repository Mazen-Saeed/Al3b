import 'package:al3b_staff/data/db/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('a row goes in and comes back', () async {
    final now = DateTime.utc(2026, 11, 9, 20);
    await db.into(db.rooms).insert(RoomsCompanion.insert(id: 'r1', venueId: 'v1', name: 'صالة 1', updatedAt: now));

    final rows = await db.select(db.rooms).get();

    expect(rows.single.name, 'صالة 1');
    expect(rows.single.sortOrder, 0); // the default
    expect(rows.single.deletedAt, isNull);
  });

  test('the table names are the backend\'s', () async {
    final names = db.allTables.map((t) => t.actualTableName).toSet();
    expect(names, {
      'rooms',
      'unit_types',
      'price_categories',
      'units',
      'sessions',
      'sessions_units',
      'sessions_products',
      'products',
      'stock_items',
      'stock_movements',
      'purchases',
      'bills',
      'bill_items',
      'shifts',
      'cash_movements',
      'expense_categories',
      'staff',
      'staff_pin_attempts',
      'venues',
      'activity_log',
    });
  });
}
