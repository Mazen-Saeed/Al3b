import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../activity_log.dart';
import '../bills_provider.dart';
import '../cash_box_provider.dart';
import '../catalog_provider.dart';
import '../categories_provider.dart';
import '../expense_categories_provider.dart';
import '../expense_category.dart';
import '../orders_provider.dart';
import '../pin_attempts.dart';
import '../sample_data.dart';
import '../shop_info.dart';
import '../staff_provider.dart';
import '../unit.dart';
import '../unit_types_provider.dart';
import '../units_provider.dart';
import 'backup.dart';
import 'shop_repository.dart';

// Connects the repository to the app (decision #65). main.dart opens the database and loads the
// shop; after that, every change to the devices, price categories or device types is saved.

/// The shop id of a database from before the first-run setup existed (it started with the sample shop).
/// A new shop gets its own id at setup.
const localVenueId = '01990000-0000-7000-8000-0000000000aa';

/// Who is recorded as the author of a save made while nobody is signed in (a database upgrade).
const _seedStaffId = 'staff-1';

/// The repository the app saves to. Null in tests: they run without a database.
final shopRepositoryProvider = Provider<ShopRepository?>((ref) => null);

/// Loads the shop from [repository]. A brand new database comes back empty with no [ShopData.shopInfo]: the
/// app then shows the first-run setup, and the owner creates everything.
///
/// A database made by an earlier version (it started with the sample shop and has no shop row) keeps its data:
/// it is given the sample shop's name and id and whatever the sample shop had that is still missing.
Future<ShopData> loadShop(ShopRepository repository) async {
  final loaded = await repository.load();
  final earlierVersion = loaded.shopInfo == null && (!loaded.isEmpty || loaded.staff.isNotEmpty);
  if (!earlierVersion) return loaded;
  final shop = ShopData(
    units: loaded.units,
    categories: loaded.categories,
    unitTypes: loaded.unitTypes,
    catalog: loaded.catalog,
    orders: loaded.orders,
    bills: loaded.bills,
    cashBox: loaded.cashBox,
    expenseCategories: loaded.expenseCategories.isEmpty ? defaultExpenseCategories : loaded.expenseCategories,
    staff: loaded.staff.isEmpty ? buildSampleStaff() : loaded.staff,
    shopInfo: const ShopInfo(id: localVenueId, name: sampleVenueName, instapay: sampleInstapay, wallet: sampleWallet),
    activity: loaded.activity,
  );
  await repository.save(shop, staffId: _seedStaffId);
  return shop;
}

/// The sample shop: devices, menu, staff and expense types. For the trial mode and for tests. Never real data.
ShopData sampleShopData() => ShopData(
      units: buildSampleUnits(),
      categories: sampleCategories,
      unitTypes: UnitType.defaults,
      catalog: sampleCatalog,
      expenseCategories: defaultExpenseCategories,
      staff: buildSampleStaff(),
      shopInfo: const ShopInfo(id: localVenueId, name: sampleVenueName, instapay: sampleInstapay, wallet: sampleWallet),
    );

/// Saves a person's wrong-PIN count. One after another with the other saves is not needed: it is one row.
/// A failed save is only logged, so a database problem never blocks signing in.
void Function(String, PinAttempts) pinAttemptsSaver(ShopRepository repository) => (staffId, attempts) {
      repository.savePinAttempts(staffId, attempts).catchError((Object error, StackTrace stack) {
        debugPrint('Saving the PIN count failed: $error\n$stack');
      });
    };

/// Saves every change. An action often changes several things at once (a payment clears the orders and
/// frees the device), so a save waits until the action is over and then sees all of it together. Saves
/// run one after another, and each one writes only what changed, so a burst of changes is cheap.
final persistenceProvider = Provider<void>((ref) {
  final repository = ref.watch(shopRepositoryProvider);
  if (repository == null) return;

  var queue = Future<void>.value();
  void save() {
    final data = ShopData(
      units: ref.read(unitsProvider),
      categories: ref.read(categoriesProvider),
      unitTypes: ref.read(unitTypesProvider),
      catalog: ref.read(catalogProvider),
      orders: ref.read(ordersProvider),
      bills: ref.read(billsProvider),
      cashBox: ref.read(cashBoxProvider),
      expenseCategories: ref.read(expenseCategoriesProvider),
      staff: ref.read(staffProvider),
      shopInfo: ref.read(shopInfoProvider),
      activity: ref.read(activityLogProvider),
    );
    final staffId = ref.read(currentStaffIdProvider) ?? _seedStaffId;
    queue = queue.then((_) => repository.save(data, staffId: staffId)).catchError((Object error, StackTrace stack) {
      // A failed save must not stop the next ones. (A real error report comes with crash reporting.)
      debugPrint('Saving the shop failed: $error\n$stack');
    });
  }

  var waiting = false;
  void requestSave() {
    if (waiting) return;
    waiting = true;
    scheduleMicrotask(() {
      waiting = false;
      save();
    });
  }

  ref.listen(unitsProvider, (_, _) => requestSave());
  ref.listen(categoriesProvider, (_, _) => requestSave());
  ref.listen(unitTypesProvider, (_, _) => requestSave());
  ref.listen(catalogProvider, (_, _) => requestSave());
  ref.listen(ordersProvider, (_, _) => requestSave());
  ref.listen(billsProvider, (_, _) => requestSave());
  final backup = ref.watch(databaseBackupProvider);
  int closedBoxes(CashBoxState state) => state.boxes.where((b) => !b.isOpen).length;
  ref.listen(cashBoxProvider, (previous, next) {
    requestSave();
    // The end of a shift is the best moment for a backup: everything is counted. It waits for the save
    // above (microtasks run in order), so the backup has the closing in it.
    if (backup != null && previous != null && closedBoxes(next) > closedBoxes(previous)) {
      scheduleMicrotask(() {
        queue = queue.then((_) => backup.backupNow()).then((_) {}).catchError((Object error, StackTrace stack) {
          debugPrint('The backup failed: $error\n$stack');
        });
      });
    }
  });
  ref.listen(expenseCategoriesProvider, (_, _) => requestSave());
  ref.listen(staffProvider, (_, _) => requestSave());
  ref.listen(shopInfoProvider, (_, _) => requestSave());
  ref.listen(activityLogProvider, (_, _) => requestSave());
});

/// Keeps [persistenceProvider] alive for as long as the app runs.
class Persistence extends ConsumerWidget {
  const Persistence({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(persistenceProvider);
    return child;
  }
}
