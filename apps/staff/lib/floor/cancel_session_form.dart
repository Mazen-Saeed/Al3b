import 'package:flutter/material.dart';

import '../activity/activity_text.dart';
import '../app_theme.dart';
import '../data/cancel_session.dart';
import '../data/money.dart';
import '../data/unit.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// Asks to cancel a session (nobody pays). [uncollected] is the money that will not be collected.
/// Returns the reason picked ([CancelReason.mistake] when no reason was needed), or null if staff backed out.
Future<String?> showCancelSession(BuildContext context, Unit unit, {required int uncollected, required bool needsReason}) =>
    showFormSurface<String>(context, _CancelSessionForm(unit: unit, uncollected: uncollected, needsReason: needsReason));

class _CancelSessionForm extends StatefulWidget {
  const _CancelSessionForm({required this.unit, required this.uncollected, required this.needsReason});

  final Unit unit;
  final int uncollected;
  final bool needsReason;

  @override
  State<_CancelSessionForm> createState() => _CancelSessionFormState();
}

class _CancelSessionFormState extends State<_CancelSessionForm> {
  String? _reason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canConfirm = !widget.needsReason || _reason != null;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.cancelSession, heading: widget.unit.name),
          const SizedBox(height: 14),
          Text(
            widget.uncollected > 0 ? l10n.cancelBody(l10n.amountEgp(formatMoney(widget.uncollected))) : l10n.cancelBodyNothing,
            style: AppText.small,
          ),
          if (widget.needsReason) ...[
            const SizedBox(height: 18),
            Text(l10n.cancelReasonLabel, style: AppText.label),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final reason in CancelReason.all)
                  ChoiceChip(
                    key: Key('cancel-reason-$reason'),
                    label: Text(cancelReasonText(l10n, reason)),
                    selected: _reason == reason,
                    onSelected: (_) => setState(() => _reason = reason),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('cancel-confirm'),
            onPressed: canConfirm ? () => Navigator.pop(context, _reason ?? CancelReason.mistake) : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.cancelConfirm, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
