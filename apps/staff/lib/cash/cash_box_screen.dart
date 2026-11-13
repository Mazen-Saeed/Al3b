import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/bills_provider.dart';
import '../data/cash_box.dart';
import '../data/cash_box_provider.dart';
import '../data/cash_settings_provider.dart';
import '../data/money.dart';
import '../data/staff_provider.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import 'cash_box_detail.dart';
import 'cash_rows.dart';
import 'close_cash_box_form.dart';
import 'movement_form.dart';
import 'ensure_open.dart';
import 'open_cash_box_form.dart';
import 'settle_form.dart';
import 'shift_activity.dart';
import 'shift_numbers.dart';

/// The cash box page (الخزينة). Closed: open it. Open: record expenses, cash in and owner
/// withdrawals, see the payments, and close it with a count. The amount that should be in the
/// box is shown only to Admins, or to everyone when the shop setting says so; otherwise the count
/// is blind (the cashier types the number first). Below: the cash boxes that were closed before.
class CashBoxScreen extends ConsumerStatefulWidget {
  const CashBoxScreen({super.key});

  @override
  ConsumerState<CashBoxScreen> createState() => _CashBoxScreenState();
}

class _CashBoxScreenState extends ConsumerState<CashBoxScreen> {
  bool _showPast = false; // the second tab: shifts that were closed before (Admin only)

  Future<void> _open(BuildContext context) async {
    final cash = ref.read(cashBoxProvider.notifier); // read before the await
    final amount = await showOpenCashBoxForm(context, suggested: ref.read(cashBoxProvider).lastClosed?.countedCash);
    if (amount != null) cash.open(amount);
  }

  Future<void> _record(BuildContext context, CashMovementType type) async {
    final cash = ref.read(cashBoxProvider.notifier);
    final result = await showMovementForm(context, type);
    if (result != null) cash.addMovement(type, result.amount, note: result.note, paidFrom: result.paidFrom, categoryId: result.categoryId);
  }

  Future<void> _settle(BuildContext context, String staffId, String name, int total) async {
    final cash = ref.read(cashBoxProvider.notifier);
    final note = '${context.l10n.settleNote} $name';
    final from = await showSettleForm(context, name: name, total: total, boxOpen: ref.read(cashBoxProvider).open != null);
    if (from == null) return;
    if (from == PaidFrom.cashBox) {
      if (!context.mounted) return;
      if (!await ensureCashBoxOpen(context, ref)) return;
    }
    cash.settleOwed(staffId, from, note: note);
  }

  Future<void> _close(BuildContext context) async {
    final cash = ref.read(cashBoxProvider.notifier);
    final counted = await showCloseCashBoxForm(context);
    if (counted == null) return;
    final closed = cash.close(counted);
    if (!context.mounted) return;
    await showCashBoxResult(context, closed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(cashBoxProvider);
    ref.watch(billsProvider); // redraws the expected amount when a payment comes in
    final canHandle = ref.read(cashBoxProvider.notifier).canHandle;
    final staff = ref.watch(staffProvider);
    final isAdmin = ref.watch(currentStaffProvider)?.isAdmin ?? false;
    final showExpected = isAdmin || ref.watch(showExpectedCashProvider);
    String nameOf(String id) => staff.where((s) => s.id == id).map((s) => s.name).firstOrNull ?? '';

    final open = state.open;
    final past = state.boxes.where((b) => !b.isOpen).toList().reversed.toList();
    final showPast = isAdmin && _showPast; // staff only work on the open shift

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.navShift, style: AppText.formTitle),
        const SizedBox(height: 14),
        // Two places, so old shifts never look like the current one. Staff only have the current one.
        if (isAdmin) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(l10n.currentShiftTab, key: const Key('tab-current'))),
                ButtonSegment(value: true, label: Text(l10n.pastCashBoxesTitle, key: const Key('tab-past'))),
              ],
              selected: {_showPast},
              showSelectedIcon: false,
              onSelectionChanged: (v) => setState(() => _showPast = v.first),
            ),
          ),
          const SizedBox(height: 14),
        ],
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showPast)
                  _Section(
                    title: '',
                    rows: [for (final b in past) _PastRow(box: b, cashierName: nameOf(b.openedById))],
                  )
                else ...[
                  if (open == null)
                    _ClosedCard(last: isAdmin ? state.lastClosed : null, onOpen: () => _open(context))
                  else
                    _OpenCard(
                      box: open,
                      cashierName: nameOf(open.openedById),
                      expected: showExpected ? ref.read(cashBoxProvider.notifier).expectedCash(open) : null,
                      canHandle: canHandle,
                      onRecord: (type) => _record(context, type),
                      onClose: () => _close(context),
                    ),
                  // What the shop owes people who paid from their own pocket. Only an Admin pays it back.
                  _Section(
                    title: l10n.owedTitle,
                    rows: [
                      for (final e in state.owed.entries)
                        _OwedRow(
                          name: nameOf(e.key),
                          total: e.value,
                          onSettle: isAdmin ? () => _settle(context, e.key, nameOf(e.key), e.value) : null,
                        ),
                    ],
                  ),
                  // Everyone sees what happened in the shift (so nobody wonders "did I record that?"); only the
                  // expected amount and how it adds up (above) follow the Admin / shop-setting rule.
                  if (open != null)
                    Padding(padding: const EdgeInsetsDirectional.only(top: 22), child: ShiftActivity(box: open)),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A heading and its rows. Nothing is drawn when there are no rows.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsDirectional.only(top: title.isEmpty ? 0 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty) ...[Text(title, style: AppText.sectionTitle), const SizedBox(height: 10)],
          for (final row in rows) Padding(padding: const EdgeInsetsDirectional.only(bottom: 8), child: row),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(22),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(28)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}

class _ClosedCard extends StatelessWidget {
  const _ClosedCard({required this.last, required this.onOpen});

  final CashBox? last;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _Card(
      children: [
        Text(l10n.cashBoxClosedTitle, style: AppText.sectionTitle),
        if (last != null) ...[
          const SizedBox(height: 16),
          Text(l10n.lastCloseTitle, style: AppText.label),
          const SizedBox(height: 6),
          _Summary(box: last!),
        ],
        const SizedBox(height: 20),
        FilledButton(
          key: const Key('open-cash-box'),
          onPressed: onOpen,
          style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
          child: Text(l10n.openCashBox, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

/// Expected, counted and the difference of a closed cash box, on one line each.
class _Summary extends StatelessWidget {
  const _Summary({required this.box});

  final CashBox box;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final diff = box.difference ?? 0;
    final diffText = diff == 0
        ? l10n.cashMatches
        : '${diff > 0 ? l10n.cashOver : l10n.cashShort} ${l10n.amountEgp(formatMoney(diff.abs()))}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${l10n.cashExpected}: ${l10n.amountEgp(formatMoney(box.expectedCash ?? 0))}'),
        Text('${l10n.cashCounted}: ${l10n.amountEgp(formatMoney(box.countedCash ?? 0))}'),
        Text(
          diffText,
          style: TextStyle(fontWeight: FontWeight.w700, color: diff == 0 ? AppColors.free : AppColors.waitingPayment),
        ),
      ],
    );
  }
}

class _OpenCard extends StatelessWidget {
  const _OpenCard({
    required this.box,
    required this.cashierName,
    required this.expected,
    required this.canHandle,
    required this.onRecord,
    required this.onClose,
  });

  final CashBox box;
  final String cashierName;
  final int? expected; // null = hidden (a blind count)
  final bool canHandle;
  final void Function(CashMovementType type) onRecord;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final actions = [
      (CashMovementType.expense, Icons.north_east_rounded),
      (CashMovementType.cashIn, Icons.south_west_rounded),
      (CashMovementType.ownerWithdrawal, Icons.person_outline_rounded),
    ];
    return _Card(
      children: [
        Text('${l10n.cashierLabel}: $cashierName', style: AppText.sectionTitle),
        const SizedBox(height: 4),
        Text('${l10n.openedLabel} ${friendlyTime(l10n, box.openedAt)}', style: AppText.label),
        if (expected != null) ...[
          const SizedBox(height: 12),
          Text(
            '${l10n.expectedNowLabel}: ${l10n.amountEgp(formatMoney(expected!))}',
            key: const Key('expected-now'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ShiftNumbers(box: box), // how that number is made, and what was paid outside the drawer
        ],
        const SizedBox(height: 18),
        if (canHandle) ...[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final (type, icon) in actions)
                FilledButton.tonalIcon(
                  key: Key('record-${type.name}'),
                  onPressed: () => onRecord(type),
                  icon: Icon(icon, size: 20),
                  label: Text(movementTitle(l10n, type)),
                ),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton(
            key: const Key('close-cash-box'),
            onPressed: onClose,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.closeCashBox, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ] else
          Text(l10n.onlyCashierHint, style: AppText.label),
      ],
    );
  }
}

/// A closed cash box in the history: when, who, and how the count came out. Tap for the details.
class _PastRow extends StatelessWidget {
  const _PastRow({required this.box, required this.cashierName});

  final CashBox box;
  final String cashierName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final diff = box.difference ?? 0;
    final diffText = diff == 0
        ? l10n.cashMatches
        : '${diff > 0 ? l10n.cashOver : l10n.cashShort} ${l10n.amountEgp(formatMoney(diff.abs()))}';
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        key: Key('past-${box.id}'),
        borderRadius: BorderRadius.circular(20),
        onTap: () => showCashBoxDetail(context, box),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${shortDate(box.openedAt)} · ${friendlyTime(l10n, box.openedAt)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('${l10n.cashierLabel}: $cashierName', style: AppText.small),
                  ],
                ),
              ),
              Text(
                diffText,
                style: TextStyle(fontWeight: FontWeight.w700, color: diff == 0 ? AppColors.free : AppColors.waitingPayment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One person the shop owes money to, with a "paid back" button for Admins.
class _OwedRow extends StatelessWidget {
  const _OwedRow({required this.name, required this.total, required this.onSettle});

  final String name;
  final int total;
  final VoidCallback? onSettle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(l10n.amountEgp(formatMoney(total)), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          if (onSettle != null) ...[
            const SizedBox(width: 12),
            FilledButton.tonal(key: Key('settle-$name'), onPressed: onSettle, child: Text(l10n.settleOwed)),
          ],
        ],
      ),
    );
  }
}
