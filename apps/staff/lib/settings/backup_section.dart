import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/db/backup.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';

/// Settings > Backup: take a copy now, see the last ones, ask for one to be restored. Hidden where there
/// is no database to back up.
class BackupSection extends ConsumerStatefulWidget {
  const BackupSection({super.key});

  @override
  ConsumerState<BackupSection> createState() => _BackupSectionState();
}

class _BackupSectionState extends ConsumerState<BackupSection> {
  List<BackupFile> _backups = const [];
  bool _restoreRequested = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final backup = ref.read(databaseBackupProvider);
    if (backup == null) return;
    final backups = await backup.list();
    final pending = await backup.restorePending();
    if (mounted) {
      setState(() {
        _backups = backups;
        _restoreRequested = pending;
      });
    }
  }

  Future<void> _backupNow() async {
    final backup = ref.read(databaseBackupProvider)!;
    final messenger = ScaffoldMessenger.of(context);
    final done = context.l10n.backupDone;
    await backup.backupNow();
    messenger.showSnackBar(SnackBar(content: Text(done)));
    await _refresh();
  }

  Future<void> _restore(BackupFile file) async {
    final l10n = context.l10n;
    final backup = ref.read(databaseBackupProvider)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.backupRestoreConfirmTitle(friendlyTime(l10n, file.at))),
        content: Text(l10n.backupRestoreConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.backupRestoreNo)),
          FilledButton(
            key: const Key('backup-restore-yes'),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.backupRestoreYes),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await backup.requestRestore(file);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final backup = ref.watch(databaseBackupProvider);
    if (backup == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.backupTitle, style: AppText.sectionTitle),
        const SizedBox(height: 6),
        Text(l10n.backupHelp, style: AppText.small),
        const SizedBox(height: 4),
        Text(l10n.backupFolder(backup.directory.path), style: AppText.small, textDirection: TextDirection.ltr),
        const SizedBox(height: 12),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton.tonal(key: const Key('backup-now'), onPressed: _backupNow, child: Text(l10n.backupNow)),
        ),
        if (_restoreRequested) ...[
          const SizedBox(height: 12),
          Text(l10n.backupRestoreRestart, key: const Key('backup-restart'), style: const TextStyle(color: AppColors.alert)),
        ],
        const SizedBox(height: 12),
        if (_backups.isEmpty)
          Text(l10n.backupNone, style: AppText.small)
        else
          for (final file in _backups.take(5))
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(child: Text('${file.at.day}/${file.at.month} · ${friendlyTime(l10n, file.at)}')),
                  TextButton(
                    key: Key('backup-restore-${file.name}'),
                    onPressed: () => _restore(file),
                    child: Text(l10n.backupRestore),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
