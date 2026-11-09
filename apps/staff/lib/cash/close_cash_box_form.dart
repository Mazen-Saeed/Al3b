import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/cash_box.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// Closing: the cashier counts the cash in the box and types it. The amount the app expected is
/// NOT shown here (a blind count, #36); it appears afterwards, in [showCashBoxResult].
/// Returns the counted piasters, or null if closed without counting.
Future<int?> showCloseCashBoxForm(BuildContext context) => showFormSurface<int>(context, const _CloseForm());

class _CloseForm extends StatefulWidget {
  const _CloseForm();

  @override
  State<_CloseForm> createState() => _CloseFormState();
}

class _CloseFormState extends State<_CloseForm> {
  final _counted = TextEditingController();

  @override
  void dispose() {
    _counted.dispose();
    super.dispose();
  }

  int? get _value => parseMoney(_counted.text);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.navShift, heading: l10n.closeCashBox),
          const SizedBox(height: 18),
          Text(l10n.countedHint, style: AppText.label),
          const SizedBox(height: 8),
          TextField(
            key: const Key('counted-cash'),
            controller: _counted,
            autofocus: true,
            keyboardType: moneyKeyboard,
            inputFormatters: moneyInputFormatters,
            decoration: InputDecoration(hintText: l10n.movementAmountHint),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('close-cash-box-confirm'),
            onPressed: _value == null ? null : () => Navigator.pop(context, _value),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.closeCashBox, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

/// What the app expected, what was counted, and the difference. Shown right after closing and
/// again, smaller, on the Cash box page.
Future<void> showCashBoxResult(BuildContext context, CashBox closed) =>
    showFormSurface<void>(context, CashBoxResult(box: closed, title: context.l10n.cashBoxClosedDone));

/// The three lines of a closed cash box.
class CashBoxResult extends StatelessWidget {
  const CashBoxResult({super.key, required this.box, required this.title});

  final CashBox box;
  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final diff = box.difference ?? 0;
    final diffText = diff == 0
        ? l10n.cashMatches
        : '${diff > 0 ? l10n.cashOver : l10n.cashShort} ${l10n.amountEgp(formatMoney(diff.abs()))}';
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.navShift, heading: title),
          const SizedBox(height: 18),
          _Line(label: l10n.cashExpected, value: l10n.amountEgp(formatMoney(box.expectedCash ?? 0))),
          const SizedBox(height: 8),
          _Line(label: l10n.cashCounted, value: l10n.amountEgp(formatMoney(box.countedCash ?? 0))),
          const SizedBox(height: 14),
          Text(
            diffText,
            key: const Key('cash-difference'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: diff == 0 ? AppColors.free : AppColors.waitingPayment,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.doneButton, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppText.label)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
