import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/bill.dart';
import '../data/bills_provider.dart';
import '../data/cash_box.dart';
import '../data/cash_box_provider.dart';
import '../data/staff_provider.dart';
import '../l10n/l10n.dart';
import 'cash_rows.dart';
import 'correct_bill_form.dart';

/// Everything that happened in a shift in one list, newest first: sales (device and quick sale) and
/// money in or out together, in the order it happened. Drawer money has a colour (green in, red
/// out); money that did not go into the drawer is grey and tagged.
class ShiftActivity extends ConsumerWidget {
  const ShiftActivity({super.key, required this.box});

  final CashBox box;

  Future<void> _correct(BuildContext context, WidgetRef ref, Bill bill) async {
    final bills = ref.read(billsProvider.notifier);
    final correction = await showCorrectBill(context, bill);
    if (correction != null) bills.correct(bill.id, newTotal: correction.total, reason: correction.reason);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final staff = ref.watch(staffProvider);
    String nameOf(String id) => staff.where((s) => s.id == id).map((s) => s.name).firstOrNull ?? '';
    final entries = <(DateTime, Widget)>[
      for (final b in ref.watch(billsProvider).where((b) => b.cashBoxId == box.id))
        (
          b.endedAt,
          BillRow(
            bill: b,
            who: nameOf(b.takenById ?? ''),
            // A bill of a closed cash box was counted already: it can no longer change.
            onTap: box.isOpen ? () => _correct(context, ref, b) : null,
          ),
        ),
      for (final m in ref.watch(cashBoxProvider).movementsOf(box.id))
        (m.at, MovementRow(movement: m, who: nameOf(m.staffId))),
    ]..sort((a, b) => b.$1.compareTo(a.$1));
    if (entries.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.shiftActivityTitle, style: AppText.sectionTitle),
        const SizedBox(height: 10),
        for (final (_, row) in entries) Padding(padding: const EdgeInsetsDirectional.only(bottom: 8), child: row),
      ],
    );
  }
}
