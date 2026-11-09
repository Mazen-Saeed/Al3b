import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/cash_box.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';
import '../shell/pill.dart';

/// "Paid back": the shop pays [name] the [total] it owes. Asks where that money comes from (the cash
/// box, or from outside it) and returns the answer, or null if closed. [boxOpen] picks the default.
Future<PaidFrom?> showSettleForm(BuildContext context, {required String name, required int total, required bool boxOpen}) =>
    showFormSurface<PaidFrom>(context, _SettleForm(name: name, total: total, boxOpen: boxOpen));

class _SettleForm extends StatefulWidget {
  const _SettleForm({required this.name, required this.total, required this.boxOpen});

  final String name;
  final int total;
  final bool boxOpen;

  @override
  State<_SettleForm> createState() => _SettleFormState();
}

class _SettleFormState extends State<_SettleForm> {
  late PaidFrom _from = widget.boxOpen ? PaidFrom.cashBox : PaidFrom.pocket; // pocket = outside the box here

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.owedTitle, heading: '${l10n.settleNote} ${widget.name}'),
          const SizedBox(height: 14),
          Text(
            l10n.amountEgp(formatMoney(widget.total)),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),
          Text(l10n.paidFromQuestion, style: AppText.label),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Pill(
                key: const Key('settle-from-cash-box'),
                label: l10n.paidFromCashBox,
                selected: _from == PaidFrom.cashBox,
                onTap: () => setState(() => _from = PaidFrom.cashBox),
              ),
              Pill(
                key: const Key('settle-outside'),
                label: l10n.settleOutside,
                selected: _from == PaidFrom.pocket,
                onTap: () => setState(() => _from = PaidFrom.pocket),
              ),
            ],
          ),
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('settle-confirm'),
            onPressed: () => Navigator.pop(context, _from),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.settleOwed, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
