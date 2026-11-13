import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expense_category.dart';
import 'ids.dart';

/// Where the categories start. The built-in list in the app; tests can start with their own.
final initialExpenseCategoriesProvider = Provider<List<ExpenseCategory>>((ref) => defaultExpenseCategories);

/// The buttons staff see on the expense form: the owner's categories in their order, "أخرى" last.
List<ExpenseCategory> pickableCategories(List<ExpenseCategory> all) {
  final pickable = all.where((c) => c.isPickable).toList();
  return [
    ...pickable.where((c) => c.kind == ExpenseCategoryKind.normal),
    ...pickable.where((c) => c.kind == ExpenseCategoryKind.other),
  ];
}

class ExpenseCategoriesNotifier extends Notifier<List<ExpenseCategory>> {
  @override
  List<ExpenseCategory> build() => ref.read(initialExpenseCategoriesProvider);

  /// Replaces the whole list. Used once, by the first-run setup.
  void setAll(List<ExpenseCategory> categories) => state = categories;

  /// Whether [name] is already used by a visible category (other than [exceptId]).
  bool exists(String name, {String? exceptId}) {
    final wanted = name.trim();
    return state.any((c) => c.active && c.id != exceptId && c.name == wanted);
  }

  /// Adds the owner's own category. Returns false when the name is empty or already used.
  bool add(String name) {
    final clean = name.trim();
    if (clean.isEmpty || exists(clean)) return false;
    state = [...state, ExpenseCategory(id: newId(), name: clean)];
    return true;
  }

  /// Renames a normal category. Returns false when the name is empty or already used.
  bool rename(String id, String name) {
    final clean = name.trim();
    if (clean.isEmpty || exists(clean, exceptId: id)) return false;
    state = [for (final c in state) c.id == id && !c.isLocked ? c.copyWith(name: clean) : c];
    return true;
  }

  /// Removes a normal category from the buttons. Old expenses keep it (so past reports stay right).
  void remove(String id) {
    state = [for (final c in state) c.id == id && !c.isLocked ? c.copyWith(active: false) : c];
  }
}

final expenseCategoriesProvider = NotifierProvider<ExpenseCategoriesNotifier, List<ExpenseCategory>>(
  ExpenseCategoriesNotifier.new,
);
