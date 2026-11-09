import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/expense_categories_provider.dart';
import '../data/expense_category.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// What the owner did in the category form: the new name, or "delete this category".
class ExpenseCategoryFormResult {
  const ExpenseCategoryFormResult.save(this.name) : delete = false;

  const ExpenseCategoryFormResult.delete()
      : name = '',
        delete = true;

  final String name;
  final bool delete;
}

/// New category ([category] null) or rename / delete one. Returns null if closed without saving.
Future<ExpenseCategoryFormResult?> showExpenseCategoryForm(BuildContext context, {ExpenseCategory? category}) =>
    showFormSurface<ExpenseCategoryFormResult>(context, _ExpenseCategoryForm(category: category));

class _ExpenseCategoryForm extends ConsumerStatefulWidget {
  const _ExpenseCategoryForm({this.category});

  final ExpenseCategory? category;

  @override
  ConsumerState<_ExpenseCategoryForm> createState() => _ExpenseCategoryFormState();
}

class _ExpenseCategoryFormState extends ConsumerState<_ExpenseCategoryForm> {
  late final _name = TextEditingController(text: widget.category?.name);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  bool get _taken =>
      ref.read(expenseCategoriesProvider.notifier).exists(_name.text, exceptId: widget.category?.id);

  bool get _canSave => _name.text.trim().isNotEmpty && !_taken;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(
            title: l10n.expenseCategoriesTitle,
            heading: widget.category?.name ?? l10n.newExpenseCategory,
          ),
          const SizedBox(height: 18),
          TextField(
            key: const Key('category-name'),
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(hintText: l10n.categoryNameHint),
            onChanged: (_) => setState(() {}), // redraw so the save button can enable
          ),
          if (_taken) ...[
            const SizedBox(height: 8),
            Text(l10n.categoryExists, key: const Key('category-exists'), style: AppText.small),
          ],
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('category-save'),
            onPressed: _canSave ? () => Navigator.pop(context, ExpenseCategoryFormResult.save(_name.text.trim())) : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          if (widget.category != null) ...[
            const SizedBox(height: 8),
            TextButton(
              key: const Key('category-delete'),
              onPressed: () => Navigator.pop(context, const ExpenseCategoryFormResult.delete()),
              style: TextButton.styleFrom(foregroundColor: AppColors.alert),
              child: Text(l10n.deleteCategory),
            ),
          ],
        ],
      ),
    );
  }
}
