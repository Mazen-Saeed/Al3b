import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/activity_log.dart';
import '../data/staff_provider.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import '../shell/pill.dart';
import 'activity_text.dart';

/// Manage > Activity log (سجل النشاط), Admins only: who did what, newest first. Lines can be read, never
/// changed or removed (decision #63). Risky ones are marked and can be shown alone.
class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key, required this.onBack});

  final VoidCallback onBack; // back to the Manage list

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  bool _onlySuspicious = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final names = {for (final s in ref.watch(staffProvider)) s.id: s.name};
    final all = ref.watch(activityLogProvider).reversed.toList();
    final shown = _onlySuspicious ? all.where((e) => e.suspicious).toList() : all;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton.filledTonal(onPressed: widget.onBack, icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 14),
            Expanded(child: Text(l10n.activityTitle, style: AppText.sectionTitle)),
            Pill(
              key: const Key('activity-only-suspicious'),
              label: l10n.activitySuspiciousOnly,
              selected: _onlySuspicious,
              onTap: () => setState(() => _onlySuspicious = !_onlySuspicious),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Expanded(
          child: shown.isEmpty
              ? Center(child: Text(l10n.activityEmpty, style: AppText.label))
              : ListView.separated(
                  itemCount: shown.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => _EntryRow(entry: shown[i], who: names[shown[i].staffId] ?? ''),
                ),
        ),
      ],
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, required this.who});

  final ActivityEntry entry;
  final String who;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final at = entry.at;
    return Container(
      key: Key('activity-${entry.id}'),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          if (entry.suspicious) ...[
            const Icon(Icons.flag_rounded, size: 20, color: AppColors.waitingPayment),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(describeActivity(l10n, entry), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text([if (who.isNotEmpty) who, '${at.day}/${at.month} ${friendlyTime(l10n, at)}'].join(' · '), style: AppText.small),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
