import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'data/activity_log.dart';
import 'data/bills_provider.dart';
import 'data/cash_box_provider.dart';
import 'data/catalog_provider.dart';
import 'data/categories_provider.dart';
import 'data/db/app_database.dart';
import 'data/db/backup.dart';
import 'data/db/persistence.dart';
import 'data/db/shop_repository.dart';
import 'data/expense_categories_provider.dart';
import 'data/ids.dart';
import 'data/orders_provider.dart';
import 'data/pin_attempts.dart';
import 'data/preferences_provider.dart';
import 'data/shop_info.dart';
import 'data/shop_setup.dart';
import 'data/staff_provider.dart';
import 'data/unit_types_provider.dart';
import 'data/units_provider.dart';
import 'l10n/app_language.dart';
import 'l10n/l10n.dart';
import 'shell/app_shell.dart';
import 'shell/notice_overlay.dart';
import 'shell/session_alerts.dart';
import 'shell/setup_gate.dart';
import 'shell/staff_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // a plugin is used before runApp
  final prefs = await SharedPreferences.getInstance(); // the saved settings, read once here
  // The shop's database (decision #65): open it, load the shop, and start the app from what is saved.
  // The very first run has nothing saved yet and starts with the setup screen.
  // A brand new database has no shop yet: it gets a fresh id now, and the first-run setup creates the shop.
  // The database file and its backups live side by side in the app's data folder. A restore the owner asked
  // for is done here, before the database is opened.
  final dataFolder = await getApplicationDocumentsDirectory();
  final databaseFile = File(p.join(dataFolder.path, 'al3b.sqlite'));
  final backupFolder = Directory(p.join(dataFolder.path, 'al3b_backups'));
  await DatabaseBackup.applyPendingRestore(databaseFile: databaseFile, directory: backupFolder);
  final db = AppDatabase.onDisk(databaseFile);
  final backup = DatabaseBackup(database: db, directory: backupFolder);
  // A backup a day. A failed one must never stop the shop from opening.
  await backup.backupIfDue().then((_) {}).catchError((Object error) => debugPrint('The daily backup failed: $error'));
  final venueId = await ShopRepository.existingVenueId(db, legacyId: localVenueId) ?? newId();
  final repository = ShopRepository(db, venueId: venueId);
  final shop = await loadShop(repository);
  final pinAttempts = await repository.loadPinAttempts();
  runApp(
    // ProviderScope holds every provider (units, menu and stock, bills...)
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => prefs),
        shopRepositoryProvider.overrideWith((ref) => repository),
        databaseBackupProvider.overrideWith((ref) => backup),
        initialUnitsProvider.overrideWith((ref) => shop.units),
        initialCategoriesProvider.overrideWith((ref) => shop.categories),
        initialUnitTypesProvider.overrideWith((ref) => shop.unitTypes),
        initialCatalogProvider.overrideWith((ref) => shop.catalog),
        initialOrdersProvider.overrideWith((ref) => shop.orders),
        initialBillsProvider.overrideWith((ref) => shop.bills),
        initialCashBoxProvider.overrideWith((ref) => shop.cashBox),
        initialExpenseCategoriesProvider.overrideWith((ref) => shop.expenseCategories),
        initialStaffProvider.overrideWith((ref) => shop.staff),
        initialShopInfoProvider.overrideWith((ref) => shop.shopInfo),
        initialActivityLogProvider.overrideWith((ref) => shop.activity),
        pendingVenueIdProvider.overrideWith((ref) => venueId),
        initialPinAttemptsProvider.overrideWith((ref) => pinAttempts),
        pinAttemptsSaverProvider.overrideWith((ref) => pinAttemptsSaver(repository)),
      ],
      child: const Persistence(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Rebuilds the whole app when the language changes (Manage > language).
    final locale = ref.watch(appLanguageProvider);
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: appTheme,
      // builder wraps the whole app, so notices float above every page.
      builder: (context, child) => NoticeOverlay(child: child!),
      home: const SetupGate(child: SessionAlerts(child: StaffGate(child: AppShell()))),
    );
  }
}
