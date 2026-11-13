import 'package:al3b_staff/data/catalog_provider.dart';
import 'package:al3b_staff/data/categories_provider.dart';
import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/persistence.dart';
import 'package:al3b_staff/data/db/shop_repository.dart';
import 'package:al3b_staff/data/expense_categories_provider.dart';
import 'package:al3b_staff/data/expense_category.dart';
import 'package:al3b_staff/data/orders_provider.dart';
import 'package:al3b_staff/data/pin_hasher.dart';
import 'package:al3b_staff/data/price_category.dart';
import 'package:al3b_staff/data/product.dart';
import 'package:al3b_staff/data/shop_info.dart';
import 'package:al3b_staff/data/shop_setup.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/data/unit.dart';
import 'package:al3b_staff/data/units_provider.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const category = PriceCategory(id: 'cat-ps5', name: 'PS5 عادي', hourlyPrice: 5000, multiHourlyPrice: 7000);
  const free = Unit(
    id: 'u1',
    name: 'PS5-1',
    type: UnitType.playstation,
    roomId: 'hall-1',
    roomName: 'صالة 1',
    categoryId: 'cat-ps5',
    status: UnitStatus.free,
    hourlyPrice: 5000,
    multiHourlyPrice: 7000,
  );

  late AppDatabase db;
  late ShopRepository repo;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ShopRepository(db, venueId: 'v1');
  });
  tearDown(() => db.close());

  ProviderContainer container() {
    final c = ProviderContainer(overrides: [
      shopRepositoryProvider.overrideWith((ref) => repo),
      initialUnitsProvider.overrideWith((ref) => [free]),
      initialCategoriesProvider.overrideWith((ref) => [category]),
      initialCatalogProvider.overrideWith((ref) => const Catalog(products: [Product(id: 'p1', name: 'شاي', price: 1000)])),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  // Saves run in the background: wait until the saved shop satisfies [done].
  Future<ShopData> savedShop(bool Function(ShopData) done) async {
    for (var i = 0; i < 100; i++) {
      final shop = await repo.load().catchError((Object _) => const ShopData(units: [], categories: [], unitTypes: []));
      if (done(shop)) return shop;
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    fail('the change was never saved');
  }

  test('starting a session reaches the database, and a restart finds it running', () async {
    final c = container();
    c.read(persistenceProvider);

    c.read(unitsProvider.notifier).startSession('u1', isMulti: false, plannedMinutes: 60);

    final shop = await savedShop((s) => s.units.isNotEmpty && s.units.first.status == UnitStatus.running);
    expect(shop.units.single.plannedMinutes, 60);
    expect(shop.units.single.sessionId, isNotNull);
  });

  test('paying clears the orders and frees the device in one go: the sold lines are kept', () async {
    final c = container();
    c.read(persistenceProvider);
    c.read(unitsProvider.notifier).startSession('u1', isMulti: false);
    c.read(ordersProvider.notifier).addOrder('u1', {'p1': 2});
    await savedShop((s) => s.orders.isNotEmpty);

    // What a payment does, back to back: if a save ran between the two, it would think the line was
    // taken off by hand and delete it.
    c.read(ordersProvider.notifier).clear('u1');
    c.read(unitsProvider.notifier).free('u1');

    await savedShop((s) => s.units.first.status == UnitStatus.free);
    final row = (await db.select(db.sessionsProducts).get()).single;
    expect(row.deletedAt, isNull);
    expect(row.quantity, 2);
  });

  test('a brand new database loads empty and needs the setup', () async {
    expect(await ShopRepository.existingVenueId(db, legacyId: 'old'), isNull);

    final shop = await loadShop(repo);

    expect(shop.shopInfo, isNull);
    expect(shop.units, isEmpty);
    expect(shop.staff, isEmpty);
    expect(shop.expenseCategories, isEmpty);
  });

  test('a database from before the setup keeps its data and takes the sample shop as its shop', () async {
    final old = ShopRepository(db, venueId: localVenueId);
    await old.save(ShopData(units: [free], categories: [category], unitTypes: UnitType.defaults), staffId: 'staff-1');
    expect(await ShopRepository.existingVenueId(db, legacyId: localVenueId), localVenueId);

    final shop = await loadShop(old);

    expect(shop.units.single.id, 'u1');
    expect(shop.shopInfo?.id, localVenueId);
    expect(shop.staff, isNotEmpty);
    expect(shop.expenseCategories, isNotEmpty);
    // Now the shop row is saved, so the next start finds it.
    expect(await ShopRepository.existingVenueId(db, legacyId: 'other'), localVenueId);
    expect((await loadShop(old)).shopInfo?.name, shop.shopInfo?.name);
  });

  test('the setup creates the shop, the owner and expense types of its own, and saves them', () async {
    final shopRepo = ShopRepository(db, venueId: 'venue-a');
    final c = ProviderContainer(overrides: [
      shopRepositoryProvider.overrideWith((ref) => shopRepo),
      pendingVenueIdProvider.overrideWith((ref) => 'venue-a'),
      initialShopInfoProvider.overrideWith((ref) => null),
      initialStaffProvider.overrideWith((ref) => []),
      initialExpenseCategoriesProvider.overrideWith((ref) => []),
      initialUnitsProvider.overrideWith((ref) => []),
      initialCategoriesProvider.overrideWith((ref) => []),
    ]);
    addTearDown(c.dispose);
    c.read(persistenceProvider);

    c.read(shopSetupProvider).finish(
          shopName: 'الأسطورة',
          ownerName: ' مازن ',
          phone: '01012345678',
          pin: '4821',
          hasher: const PinHasher(iterations: 5),
        );

    var shop = await shopRepo.load();
    for (var i = 0; i < 100 && shop.shopInfo == null; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10)); // the save runs in the background
      shop = await shopRepo.load();
    }
    expect(shop.shopInfo, const ShopInfo(id: 'venue-a', name: 'الأسطورة', phone: '01012345678'));
    final owner = shop.staff.single;
    expect((owner.name, owner.phone, owner.isAdmin, owner.isOwner), ('مازن', '01012345678', true, true));
    expect(PinHasher.verify('4821', owner.pinHash), isTrue);
    expect(c.read(currentStaffIdProvider), owner.id); // the owner is signed in
    expect(shop.expenseCategories.length, defaultExpenseCategories.length);
    expect(idOfKind(shop.expenseCategories, ExpenseCategoryKind.stock), isNotNull);
    // Another shop gets other ids, and none of them is a fixed sample id.
    final ids = shop.expenseCategories.map((e) => e.id).toSet();
    expect(ids.intersection(defaultExpenseCategories.map((e) => e.id).toSet()), isEmpty);
    expect(ids.intersection(defaultExpenseCategoriesFor('venue-b').map((e) => e.id).toSet()), isEmpty);
  });
}
