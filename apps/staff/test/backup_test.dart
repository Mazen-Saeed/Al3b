import 'dart:io';

import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/backup.dart';
import 'package:al3b_staff/data/db/shop_repository.dart';
import 'package:al3b_staff/data/shop_info.dart';
import 'package:al3b_staff/data/unit_type.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true; // the test opens a backup next to the live database on purpose
  late Directory folder;
  late AppDatabase db;
  late DatabaseBackup backup;

  setUp(() {
    folder = Directory.systemTemp.createTempSync('al3b_backup_test');
    db = AppDatabase(NativeDatabase.memory());
    backup = DatabaseBackup(database: db, directory: Directory(p.join(folder.path, 'backups')), keep: 3);
  });
  tearDown(() async {
    await db.close();
    folder.deleteSync(recursive: true);
  });

  DateTime day(int d, [int hour = 10]) => DateTime(2026, 1, d, hour);

  test('a backup is a database of its own, with everything that was saved', () async {
    await ShopRepository(db, venueId: 'v1').save(
      ShopData(units: const [], categories: const [], unitTypes: UnitType.defaults, shopInfo: const ShopInfo(id: 'v1', name: 'سوبر ماريو')),
      staffId: 'staff-1',
    );

    final file = await backup.backupNow(now: day(1));

    expect(p.basename(file.file.path), 'al3b-2026-01-01-1000.sqlite');
    final copy = AppDatabase(NativeDatabase(file.file));
    addTearDown(copy.close);
    expect((await ShopRepository(copy, venueId: 'v1').load()).shopInfo?.name, 'سوبر ماريو');
  });

  test('only the newest backups are kept, newest first', () async {
    for (var d = 1; d <= 5; d++) {
      await backup.backupNow(now: day(d));
    }

    expect((await backup.list()).map((b) => b.at.day), [5, 4, 3]);
  });

  test('a backup is taken once a day, not on every start', () async {
    expect(await backup.backupIfDue(now: day(1, 9)), isTrue); // none yet
    expect(await backup.backupIfDue(now: day(1, 20)), isFalse); // 11 hours later
    expect(await backup.backupIfDue(now: day(2, 10)), isTrue); // a day later
    expect((await backup.list()).length, 2);
  });

  group('restoring', () {
    late File databaseFile;
    late Directory backups;

    setUp(() async {
      databaseFile = File(p.join(folder.path, 'al3b.sqlite'))..writeAsStringSync('current');
      backups = backup.directory..createSync(recursive: true);
    });

    test('a requested restore swaps the file at the next start and keeps the current one aside', () async {
      File(p.join(backups.path, 'al3b-2026-01-01-1000.sqlite')).writeAsStringSync('old copy');
      File('${databaseFile.path}-wal').writeAsStringSync('leftover');
      final chosen = (await backup.list()).single;

      await backup.requestRestore(chosen);
      expect(await backup.restorePending(), isTrue);
      final done = await DatabaseBackup.applyPendingRestore(databaseFile: databaseFile, directory: backups, now: day(3));

      expect(done, isTrue);
      expect(databaseFile.readAsStringSync(), 'old copy');
      expect(File('${databaseFile.path}-wal').existsSync(), isFalse);
      expect(File(p.join(backups.path, 'before-restore-2026-01-03-1000.sqlite')).readAsStringSync(), 'current');
      expect(await backup.restorePending(), isFalse);
      // The undo copy is not a normal backup: it is never pruned or listed with them.
      expect((await backup.list()).length, 1);
    });

    test('with nothing requested, nothing changes', () async {
      expect(await DatabaseBackup.applyPendingRestore(databaseFile: databaseFile, directory: backups), isFalse);
      expect(databaseFile.readAsStringSync(), 'current');
    });

    test('a request for a backup that is gone is dropped and the database stays', () async {
      File(p.join(backups.path, 'restore-pending.txt')).writeAsStringSync('al3b-2020-01-01-0000.sqlite');

      expect(await DatabaseBackup.applyPendingRestore(databaseFile: databaseFile, directory: backups), isFalse);

      expect(databaseFile.readAsStringSync(), 'current');
      expect(await backup.restorePending(), isFalse);
    });

    test('a request can be cancelled', () async {
      File(p.join(backups.path, 'al3b-2026-01-01-1000.sqlite')).writeAsStringSync('x');
      await backup.requestRestore((await backup.list()).single);
      await backup.cancelRestore();
      expect(await backup.restorePending(), isFalse);
    });
  });
}
