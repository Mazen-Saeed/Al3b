import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// Asks how much cash is in the box now. Returns piasters, or null if closed without opening.
/// [suggested]: what was counted when the last cash box closed (the box usually starts there).
/// [prompt]: a line above the field, for when staff were sent here by a payment.
Future<int?> showOpenCashBoxForm(BuildContext context, {int? suggested, String? prompt}) =>
    showFormSurface<int>(context, _OpenCashBoxForm(suggested: suggested, prompt: prompt));

class _OpenCashBoxForm extends StatefulWidget {
  const _OpenCashBoxForm({this.suggested, this.prompt});

  final int? suggested;
  final String? prompt;

  @override
  State<_OpenCashBoxForm> createState() => _OpenCashBoxFormState();
}

class _OpenCashBoxFormState extends State<_OpenCashBoxForm> {
  late final _amount = TextEditingController(text: widget.suggested == null ? '' : formatMoney(widget.suggested!));

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  int? get _value => parseMoney(_amount.text);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.navShift, heading: l10n.openCashBox),
          if (widget.prompt != null) ...[
            const SizedBox(height: 14),
            Text(widget.prompt!, style: const TextStyle(color: AppColors.waitingPayment, fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 18),
          Text(l10n.openingCashLabel, style: AppText.label),
          const SizedBox(height: 8),
          TextField(
            key: const Key('opening-cash'),
            controller: _amount,
            autofocus: true,
            keyboardType: moneyKeyboard,
            inputFormatters: moneyInputFormatters,
            decoration: InputDecoration(hintText: l10n.movementAmountHint),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('open-cash-box-confirm'),
            onPressed: _value == null ? null : () => Navigator.pop(context, _value),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.openCashBox, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
