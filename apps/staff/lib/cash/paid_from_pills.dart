import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/cash_box.dart';
import '../data/cash_box_provider.dart';
import '../data/staff_provider.dart';
import '../l10n/l10n.dart';
import '../shell/pill.dart';

/// Whether the person using the app may take money out of the cash box: there is none open yet
/// (they will be asked to open one), or they are its cashier or an Admin.
bool canPayFromCashBox(WidgetRef ref) {
  final open = ref.read(cashBoxProvider).open;
  return open == null || ref.read(cashBoxProvider.notifier).canHandle;
}

/// What is pre-selected: the cash box when it can be used (the usual case), otherwise the pocket.
PaidFrom defaultPaidFrom(WidgetRef ref) => canPayFromCashBox(ref) ? PaidFrom.cashBox : PaidFrom.pocket;

/// "Where did the money come from?" with two answers: the cash box or my pocket. Used by the expense
/// form and the stock purchase form. When someone who is not an Admin picks their pocket, a line
/// says the shop will owe them. If they cannot use the cash box, only the pocket answer shows.
class PaidFromPills extends ConsumerWidget {
  const PaidFromPills({super.key, required this.value, required this.onChanged});

  final PaidFrom value;
  final ValueChanged<PaidFrom> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    ref.watch(cashBoxProvider); // redraws if the box is opened or closed while the form is up
    final canUseBox = canPayFromCashBox(ref);
    final isAdmin = ref.watch(currentStaffProvider)?.isAdmin ?? false;
    final selected = canUseBox ? value : PaidFrom.pocket;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.paidFromQuestion, style: AppText.label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (canUseBox)
              Pill(
                key: const Key('paid-from-cash-box'),
                label: l10n.paidFromCashBox,
                selected: selected == PaidFrom.cashBox,
                onTap: () => onChanged(PaidFrom.cashBox),
              ),
            Pill(
              key: const Key('paid-from-pocket'),
              label: l10n.paidFromPocket,
              selected: selected == PaidFrom.pocket,
              onTap: () => onChanged(PaidFrom.pocket),
            ),
          ],
        ),
        if (selected == PaidFrom.pocket && !isAdmin) ...[
          const SizedBox(height: 8),
          Text(l10n.owedHint, key: const Key('owed-hint'), style: AppText.small),
        ],
      ],
    );
  }
}
