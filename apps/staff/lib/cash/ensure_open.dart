import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cash_box_provider.dart';
import '../l10n/l10n.dart';
import 'open_cash_box_form.dart';

/// Called before a payment. Returns true when a cash box is open. If none is, it asks staff to
/// open one (the starting amount is pre-filled with the last count) and returns true once they do,
/// false if they close the form. Whoever opens it becomes the cashier.
Future<bool> ensureCashBoxOpen(BuildContext context, WidgetRef ref) async {
  final state = ref.read(cashBoxProvider);
  if (state.open != null) return true;
  final cashBox = ref.read(cashBoxProvider.notifier); // read before the await: the widget may be gone after it
  final amount = await showOpenCashBoxForm(
    context,
    suggested: state.lastClosed?.countedCash,
    prompt: context.l10n.openCashBoxFirst,
  );
  if (amount == null) return false;
  cashBox.open(amount);
  return true;
}
