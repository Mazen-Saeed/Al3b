import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/bills_provider.dart';
import '../data/cash_box.dart';
import '../data/cash_box_provider.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';

/// How a shift adds up, as a small table, so nothing has to be guessed:
///
/// الدرج: started with, cash sales, cash in, expenses, owner withdrawals (a closed shift adds the
/// expected, counted and difference), then "اتدفع برة الدرج": InstaPay and wallet.
/// The rows in the drawer part add up to the "should be" number; the outside part never does.
class ShiftNumbers extends ConsumerWidget {
  const ShiftNumbers({super.key, required this.box});

  final CashBox box;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    ref.watch(billsProvider); // redraw when a payment is added
    ref.watch(cashBoxProvider); // ...or a movement
    final s = ref.read(cashBoxProvider.notifier).summaryOf(box);
    String egp(int v) => l10n.amountEgp(formatMoney(v));

    final rows = <(String, int, Color?)>[
      (l10n.startedWithLabel, s.openingCash, null),
      (l10n.payCash, s.cashSales, s.cashSales > 0 ? AppColors.free : null),
      (l10n.cashInAction, s.cashIn, s.cashIn > 0 ? AppColors.free : null),
      (l10n.expenseAction, -s.expenses, s.expenses > 0 ? AppColors.waitingPayment : null),
      (l10n.ownerWithdrawalAction, -s.withdrawals, s.withdrawals > 0 ? AppColors.waitingPayment : null),
    ];
    final diff = box.difference;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (label, value, color) in rows) _Line(label: label, value: value == 0 ? egp(0) : _signed(egp, value), color: color),
        if (!box.isOpen) ...[
          const Divider(height: 20),
          _Line(label: l10n.cashExpected, value: egp(box.expectedCash ?? 0), bold: true),
          _Line(label: l10n.cashCounted, value: egp(box.countedCash ?? 0), bold: true),
          if (diff != null)
            _Line(
              label: diff == 0 ? l10n.cashMatches : (diff > 0 ? l10n.cashOver : l10n.cashShort),
              value: diff == 0 ? '' : egp(diff.abs()),
              color: diff == 0 ? AppColors.free : AppColors.waitingPayment,
              bold: true,
            ),
        ],
        const SizedBox(height: 14),
        Text(l10n.outsideDrawerTitle, style: AppText.label),
        const SizedBox(height: 4),
        _Line(label: l10n.payInstapay, value: egp(s.instapay)),
        _Line(label: l10n.payWallet, value: egp(s.wallet)),
      ],
    );
  }

  static String _signed(String Function(int) egp, int value) => value > 0 ? '+ ${egp(value)}' : '- ${egp(-value)}';
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value, this.color, this.bold = false});

  final String label;
  final String value;
  final Color? color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: bold ? FontWeight.w700 : FontWeight.w500, color: color);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
