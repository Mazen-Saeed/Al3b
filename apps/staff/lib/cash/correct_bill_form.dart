import 'package:flutter/material.dart';

import '../activity/activity_text.dart';
import '../app_theme.dart';
import '../data/bill.dart';
import '../data/correct_reason.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// What the correction form returns: the amount the customer should have paid, and why.
typedef Correction = ({int total, String reason});

/// Changes the amount a paid bill took. It cannot go above the calculated price (to charge more, the bill
/// itself was wrong and the time or the order must be fixed). A reason is always needed.
Future<Correction?> showCorrectBill(BuildContext context, Bill bill) =>
    showFormSurface<Correction>(context, _CorrectBillForm(bill: bill));

class _CorrectBillForm extends StatefulWidget {
  const _CorrectBillForm({required this.bill});

  final Bill bill;

  @override
  State<_CorrectBillForm> createState() => _CorrectBillFormState();
}

class _CorrectBillFormState extends State<_CorrectBillForm> {
  late final _amount = TextEditingController(text: formatMoney(widget.bill.total));
  String? _reason;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  int? get _value => parseMoney(_amount.text);
  bool get _tooHigh => (_value ?? 0) > widget.bill.subtotal;
  bool get _canSave => _value != null && !_tooHigh && _value != widget.bill.total && _reason != null;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final calculated = l10n.amountEgp(formatMoney(widget.bill.subtotal));
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.correctBill, heading: widget.bill.unitName ?? l10n.navQuickSale),
          const SizedBox(height: 14),
          Text(l10n.correctCalculated(calculated), style: AppText.small),
          const SizedBox(height: 18),
          Text(l10n.correctAmountLabel, style: AppText.label),
          const SizedBox(height: 10),
          TextField(
            key: const Key('correct-amount'),
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(errorText: _tooHigh ? l10n.correctTooHigh(calculated) : null),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 18),
          Text(l10n.cancelReasonLabel, style: AppText.label),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final reason in CorrectReason.all)
                ChoiceChip(
                  key: Key('correct-reason-$reason'),
                  label: Text(correctReasonText(l10n, reason)),
                  selected: _reason == reason,
                  onSelected: (_) => setState(() => _reason = reason),
                ),
            ],
          ),
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('correct-save'),
            onPressed: _canSave ? () => Navigator.pop(context, (total: _value!, reason: _reason!)) : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.correctSave, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
