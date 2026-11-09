import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cash_box_provider.dart';
import '../data/catalog_provider.dart';
import '../data/clock_provider.dart';
import '../data/staff_provider.dart';
import '../data/unit.dart';
import '../data/units_provider.dart';
import 'nav_provider.dart';

/// What is waiting on each page, as keys (one per thing), so the app can tell a new thing from one
/// the person already looked at.
/// - Floor: a session waiting for payment, or past its time.
/// - Shift (Admin): money the shop owes someone.
/// - Manage (Admin): an item running low in stock.
final needsActionKeysProvider = Provider<Map<int, Set<String>>>((ref) {
  ref.watch(clockProvider); // a session's time can run out at any second
  final isAdmin = ref.watch(currentStaffProvider)?.isAdmin ?? false;
  final units = ref.watch(unitsProvider);
  return {
    NavPage.floor: {
      for (final u in units)
        if (u.status == UnitStatus.waitingPayment || (u.status == UnitStatus.running && u.isOvertime))
          '${u.id}:${u.status.name}:${(u.originalStart ?? u.startedAt)?.millisecondsSinceEpoch}',
    },
    NavPage.shift: {
      if (isAdmin)
        for (final m in ref.watch(cashBoxProvider).movements)
          if (m.isOwed) m.id,
    },
    NavPage.manage: {
      if (isAdmin)
        for (final s in ref.watch(catalogProvider).stockItems)
          if (s.isLow) s.id,
    },
  };
});

/// What the person has already seen on each page. Opening a page marks everything waiting on it as
/// seen (the dot goes away); something new that needs attention raises the dot again.
class SeenNotifier extends Notifier<Map<int, Set<String>>> {
  @override
  Map<int, Set<String>> build() => const {};

  void acknowledge(int page, Set<String> keys) {
    final seen = state[page] ?? const <String>{};
    if (seen.containsAll(keys)) return; // nothing new: no change, no redraw
    state = {...state, page: {...seen, ...keys}};
  }
}

final seenProvider = NotifierProvider<SeenNotifier, Map<int, Set<String>>>(SeenNotifier.new);

/// Which nav items get the orange dot: pages (other than the one open) with something waiting that
/// the person has not seen yet. It goes away when they open the page.
final navDotsProvider = Provider<Set<int>>((ref) {
  final keys = ref.watch(needsActionKeysProvider);
  final seen = ref.watch(seenProvider);
  final current = ref.watch(navProvider);
  return {
    for (final entry in keys.entries)
      if (entry.key != current && !(seen[entry.key] ?? const <String>{}).containsAll(entry.value)) entry.key,
  };
});
