import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/cash_box.dart';
import '../data/staff_provider.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';
import 'cash_rows.dart';
import 'shift_activity.dart';
import 'shift_numbers.dart';

/// A closed cash box in full: the numbers, then everything that happened in it.
Future<void> showCashBoxDetail(BuildContext context, CashBox box) =>
    showFormSurface<void>(context, CashBoxDetail(box: box));

class CashBoxDetail extends ConsumerWidget {
  const CashBoxDetail({super.key, required this.box});

  final CashBox box;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final staff = ref.watch(staffProvider);
    String nameOf(String id) => staff.where((s) => s.id == id).map((s) => s.name).firstOrNull ?? '';
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.navShift, heading: '${shortDate(box.openedAt)} · ${friendlyTime(l10n, box.openedAt)}'),
          const SizedBox(height: 14),
          Text('${l10n.cashierLabel}: ${nameOf(box.openedById)}'),
          if (box.closedAt != null) Text('${l10n.closedLabel} ${friendlyTime(l10n, box.closedAt!)}', style: AppText.label),
          const SizedBox(height: 14),
          ShiftNumbers(box: box),
          const SizedBox(height: 18),
          ShiftActivity(box: box),
        ],
      ),
    );
  }
}
