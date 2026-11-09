import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/bill.dart';
import '../data/cash_box.dart';
import '../data/expense_categories_provider.dart';
import '../data/expense_category.dart';
import '../data/money.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import 'movement_form.dart';

/// "3/10": the day a past cash box was opened. Western digits, day first (#open-questions).
String shortDate(DateTime t) => '${t.day}/${t.month}';

String methodLabel(AppLocalizations l10n, PaymentMethod method) => switch (method) {
      PaymentMethod.cash => l10n.payCash,
      PaymentMethod.instapay => l10n.payInstapay,
      PaymentMethod.wallet => l10n.payWallet,
    };

/// One row of the cash box lists: a card with a title, small lines under it and an amount.
class _Row extends StatelessWidget {
  const _Row({required this.title, required this.lines, required this.amount, this.amountColor, this.tag});

  final String title;
  final List<String> lines;
  final String amount;
  final Color? amountColor;
  final String? tag; // small label under the amount, e.g. "not in the drawer"

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                for (final line in lines) Text(line, style: AppText.small),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: amountColor)),
              if (tag != null) Text(tag!, style: AppText.small),
            ],
          ),
        ],
      ),
    );
  }
}

/// An expense, cash in or owner withdrawal.
class MovementRow extends ConsumerWidget {
  const MovementRow({super.key, required this.movement, required this.who});

  final CashMovement movement;
  final String who; // the person who recorded it (and, when paid from a pocket, whose pocket)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final money = l10n.amountEgp(formatMoney(movement.amount));
    final category = ref.watch(expenseCategoriesProvider).where((c) => c.id == movement.categoryId).firstOrNull;
    final incoming = movement.type == CashMovementType.cashIn;
    final outsideDrawer = movement.paidFrom == PaidFrom.pocket; // never touched the drawer
    return _Row(
      title: movementTitle(l10n, movement.type),
      lines: [
        // "أخرى" says nothing, so the note alone tells what it was.
        if (category != null && category.kind != ExpenseCategoryKind.other) category.name,
        if (movement.note != null) movement.note!,
        if (movement.paidFrom == PaidFrom.pocket) '${l10n.paidFromPocketOf} $who',
        '$who · ${friendlyTime(l10n, movement.at)}',
      ],
      amount: incoming ? '+ $money' : '- $money',
      // Green in, red out of the drawer; grey when it was paid from a pocket.
      amountColor: outsideDrawer ? AppColors.textMuted : (incoming ? AppColors.free : AppColors.waitingPayment),
      tag: outsideDrawer ? l10n.outsideDrawer : null,
    );
  }
}

/// A bill paid while the cash box was open.
class BillRow extends StatelessWidget {
  const BillRow({super.key, required this.bill, required this.who});

  final Bill bill;
  final String who;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Row(
      title: bill.isQuickSale ? l10n.navQuickSale : (bill.unitName ?? ''),
      lines: ['${methodLabel(l10n, bill.method)} · $who · ${friendlyTime(l10n, bill.endedAt)}'],
      // Cash goes into the drawer (green +). InstaPay and wallet do not: grey and tagged.
      amount: bill.method == PaymentMethod.cash
          ? '+ ${l10n.amountEgp(formatMoney(bill.total))}'
          : l10n.amountEgp(formatMoney(bill.total)),
      amountColor: bill.method == PaymentMethod.cash ? AppColors.free : AppColors.textMuted,
      tag: bill.method == PaymentMethod.cash ? null : l10n.outsideDrawer,
    );
  }
}
