import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

/// One backup file in the backup folder.
class BackupFile {
  const BackupFile({required this.file, required this.at});

  final File file;
  final DateTime at; // when it was taken (read from its name)

  String get name => p.basename(file.path);
}

/// Copies of the shop's database (task #9). The database file is the shop's truth until it syncs, so a
/// lost or broken disk must not lose it. A backup is taken once a day, when a cash box is closed, and
/// whenever staff ask for one; the newest [keep] are kept.
///
/// A restore cannot replace the file under a running database, so it is only requested here: the next
/// start of the app does the swap, before the database is opened ([applyPendingRestore]).
class DatabaseBackup {
  DatabaseBackup({required this.database, required this.directory, this.keep = 14});

  final GeneratedDatabase database;
  final Directory directory;
  final int keep;

  static const _prefix = 'al3b-';
  static const _extension = '.sqlite';
  static const _pendingName = 'restore-pending.txt';

  /// "al3b-2026-11-10-0026.sqlite". The time is in the name so it survives copying the file around.
  static String nameFor(DateTime at) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '$_prefix${at.year}-${two(at.month)}-${two(at.day)}-${two(at.hour)}${two(at.minute)}$_extension';
  }

  static DateTime? _timeOf(String name) {
    final match = RegExp(r'^al3b-(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})\.sqlite$').firstMatch(name);
    if (match == null) return null;
    final v = [for (var i = 1; i <= 5; i++) int.parse(match.group(i)!)];
    return DateTime(v[0], v[1], v[2], v[3], v[4]);
  }

  /// Takes a backup now. SQLite writes a consistent copy of the whole database (VACUUM INTO), even while
  /// the app keeps saving; copying the file itself could catch it halfway through a write.
  Future<BackupFile> backupNow({DateTime? now}) async {
    final at = now ?? DateTime.now();
    await directory.create(recursive: true);
    final file = File(p.join(directory.path, nameFor(at)));
    if (await file.exists()) await file.delete(); // a second one in the same minute replaces the first
    await database.customStatement('VACUUM INTO ?', [file.path]);
    await _prune();
    return BackupFile(file: file, at: DateTime(at.year, at.month, at.day, at.hour, at.minute));
  }

  /// A backup only when the newest one is older than [every] (or there is none). True when one was taken.
  Future<bool> backupIfDue({DateTime? now, Duration every = const Duration(hours: 24)}) async {
    final at = now ?? DateTime.now();
    final newest = (await list()).firstOrNull;
    if (newest != null && at.difference(newest.at) < every) return false;
    await backupNow(now: at);
    return true;
  }

  /// The backups, newest first.
  Future<List<BackupFile>> list() async {
    if (!await directory.exists()) return const [];
    final found = <BackupFile>[];
    await for (final entity in directory.list()) {
      if (entity is! File) continue;
      final at = _timeOf(p.basename(entity.path));
      if (at != null) found.add(BackupFile(file: entity, at: at));
    }
    return found..sort((a, b) => b.at.compareTo(a.at));
  }

  Future<void> _prune() async {
    for (final old in (await list()).skip(keep)) {
      await old.file.delete();
    }
  }

  /// Asks for [backup] to be restored the next time the app starts.
  Future<void> requestRestore(BackupFile backup) async {
    await File(p.join(directory.path, _pendingName)).writeAsString(backup.name);
  }

  /// Is a restore waiting for the next start?
  Future<bool> restorePending() => File(p.join(directory.path, _pendingName)).exists();

  /// Cancels a requested restore.
  Future<void> cancelRestore() async {
    final marker = File(p.join(directory.path, _pendingName));
    if (await marker.exists()) await marker.delete();
  }

  /// Run at startup, BEFORE the database is opened. If a restore was requested, the current database is kept
  /// as "before-restore-..." (so a wrong choice can be undone), then the chosen backup becomes the database.
  /// Returns true when a restore was done.
  static Future<bool> applyPendingRestore({required File databaseFile, required Directory directory, DateTime? now}) async {
    final marker = File(p.join(directory.path, _pendingName));
    if (!await marker.exists()) return false;
    final source = File(p.join(directory.path, (await marker.readAsString()).trim()));
    if (!await source.exists()) {
      await marker.delete(); // the backup is gone: nothing to restore, and no reason to try again
      return false;
    }
    if (await databaseFile.exists()) {
      final at = now ?? DateTime.now();
      await databaseFile.copy(p.join(directory.path, 'before-restore-${nameFor(at).substring(_prefix.length)}'));
    }
    // The write-ahead files belong to the old database: leaving them would mix old changes into the restored one.
    for (final suffix in const ['', '-wal', '-shm', '-journal']) {
      final leftover = File('${databaseFile.path}$suffix');
      if (await leftover.exists()) await leftover.delete();
    }
    await source.copy(databaseFile.path);
    await marker.delete();
    return true;
  }
}

/// The backups of this shop's database. Null where there are none (tests, and before the app has opened its
/// database), and the screens that use it hide themselves.
final databaseBackupProvider = Provider<DatabaseBackup?>((ref) => null);
