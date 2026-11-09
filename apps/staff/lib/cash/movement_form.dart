import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/cash_box.dart';
import '../data/expense_categories_provider.dart';
import '../data/expense_category.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';
import '../shell/pill.dart';
import 'paid_from_pills.dart';

/// What the movement form returns.
class MovementResult {
  const MovementResult({required this.amount, this.note, this.paidFrom = PaidFrom.cashBox, this.categoryId});

  final int amount; // piasters, above 0
  final String? note;
  final PaidFrom paidFrom; // only an expense can be paid from a pocket
  final String? categoryId; // what an expense was for; null for the other two types
}

String movementTitle(AppLocalizations l10n, CashMovementType type) => switch (type) {
      CashMovementType.expense => l10n.expenseAction,
      CashMovementType.cashIn => l10n.cashInAction,
      CashMovementType.ownerWithdrawal => l10n.ownerWithdrawalAction,
    };

/// Records one expense, cash in or owner withdrawal. An expense picks what it was for (one tap) and
/// where the money came from; the note is needed only when the category is "أخرى". An owner
/// withdrawal needs a reason; cash in does not.
Future<MovementResult?> showMovementForm(BuildContext context, CashMovementType type) =>
    showFormSurface<MovementResult>(context, _MovementForm(type: type));

class _MovementForm extends ConsumerStatefulWidget {
  const _MovementForm({required this.type});

  final CashMovementType type;

  @override
  ConsumerState<_MovementForm> createState() => _MovementFormState();
}

class _MovementFormState extends ConsumerState<_MovementForm> {
  final _amount = TextEditingController();
  final _reason = TextEditingController();
  late PaidFrom _paidFrom = defaultPaidFrom(ref);
  String? _categoryId; // an expense must pick one

  @override
  void dispose() {
    _amount.dispose();
    _reason.dispose();
    super.dispose();
  }

  bool get _isExpense => widget.type == CashMovementType.expense;

  int? get _value {
    final v = parseMoney(_amount.text);
    return (v == null || v <= 0) ? null : v;
  }

  bool get _reasonNeeded => switch (widget.type) {
        CashMovementType.expense => _categoryId == ExpenseCategoryIds.other,
        CashMovementType.ownerWithdrawal => true,
        CashMovementType.cashIn => false,
      };

  bool get _canSave =>
      _value != null && (!_isExpense || _categoryId != null) && (!_reasonNeeded || _reason.text.trim().isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categories = pickableCategories(ref.watch(expenseCategoriesProvider));
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.navShift, heading: movementTitle(l10n, widget.type)),
          const SizedBox(height: 18),
          TextField(
            key: const Key('movement-amount'),
            controller: _amount,
            autofocus: true,
            keyboardType: moneyKeyboard,
            inputFormatters: moneyInputFormatters,
            decoration: InputDecoration(hintText: l10n.movementAmountHint),
            onChanged: (_) => setState(() {}),
          ),
          if (_isExpense) ...[
            const SizedBox(height: 16),
            Text(l10n.categoryQuestion, style: AppText.label),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final c in categories)
                  Pill(
                    key: Key('category-${c.id}'),
                    label: c.name,
                    selected: _categoryId == c.id,
                    onTap: () => setState(() => _categoryId = c.id),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          TextField(
            key: const Key('movement-reason'),
            controller: _reason,
            decoration: InputDecoration(hintText: _reasonNeeded ? l10n.movementReasonHint : l10n.movementNoteOptionalHint),
            onChanged: (_) => setState(() {}),
          ),
          if (_isExpense) ...[
            const SizedBox(height: 16),
            PaidFromPills(value: _paidFrom, onChanged: (v) => setState(() => _paidFrom = v)),
            const SizedBox(height: 12),
            Text(l10n.stockHint, key: const Key('stock-hint'), style: AppText.small),
          ],
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('movement-save'),
            onPressed: _canSave
                ? () {
                    final note = _reason.text.trim();
                    // Someone who cannot use the cash box only had the pocket answer on screen.
                    final paidFrom = !_isExpense
                        ? PaidFrom.cashBox
                        : (canPayFromCashBox(ref) ? _paidFrom : PaidFrom.pocket);
                    Navigator.pop(
                      context,
                      MovementResult(
                        amount: _value!,
                        note: note.isEmpty ? null : note,
                        paidFrom: paidFrom,
                        categoryId: _isExpense ? _categoryId : null,
                      ),
                    );
                  }
                : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
