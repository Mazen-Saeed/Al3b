import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/expense_categories_provider.dart';
import '../data/expense_category.dart';
import '../l10n/l10n.dart';
import '../shell/add_card.dart';
import 'expense_category_form.dart';

/// Manage > Expense categories: the kinds of expense the cashier picks from (salaries, rent...).
/// Add your own, rename or delete them. "مخزون" (set by the Bought button) and "أخرى" are built
/// in and cannot be changed. Deleting hides a category from the buttons; old expenses keep it.
class ExpenseCategoriesScreen extends ConsumerWidget {
  const ExpenseCategoriesScreen({super.key, required this.onBack});

  final VoidCallback onBack; // back to the Manage list

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final categories = ref.read(expenseCategoriesProvider.notifier); // before the await
    final result = await showExpenseCategoryForm(context);
    if (result == null || result.delete) return;
    categories.add(result.name);
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, ExpenseCategory category) async {
    final categories = ref.read(expenseCategoriesProvider.notifier);
    final result = await showExpenseCategoryForm(context, category: category);
    if (result == null) return;
    if (result.delete) {
      categories.remove(category.id);
    } else {
      categories.rename(category.id, result.name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final visible = ref
        .watch(expenseCategoriesProvider)
        .where((c) => c.active && c.kind != ExpenseCategoryKind.repayment) // paying back is internal
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton.filledTonal(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 14),
            Text(l10n.expenseCategoriesTitle, style: AppText.sectionTitle),
          ],
        ),
        const SizedBox(height: 18),
        Expanded(
          child: SingleChildScrollView(
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AddCard(label: l10n.newExpenseCategory, onTap: () => _add(context, ref)),
                    const SizedBox(height: 14),
                    for (final c in visible) ...[
                      _CategoryRow(category: c, onTap: c.isLocked ? null : () => _edit(context, ref, c)),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.category, required this.onTap});

  final ExpenseCategory category;
  final VoidCallback? onTap; // null = built in

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        key: Key('category-row-${category.id}'),
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Expanded(child: Text(category.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
              if (onTap == null)
                Text(l10n.categoryBuiltIn, style: AppText.small)
              else
                const Icon(Icons.edit_outlined, size: 20, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
