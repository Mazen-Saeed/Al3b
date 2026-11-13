import 'ids.dart';

/// What kind of category it is. Only [normal] ones can be renamed or removed by the owner.
enum ExpenseCategoryKind {
  normal, // salaries, rent...: the owner's own list
  stock, // set by the "اشتريت" button in Stock, never picked by hand
  other, // "أخرى": always there, and a note is required
  repayment, // the shop paying a person back: not a cost (it was counted when that person paid), hidden
}

/// A kind of expense, so reports can say where the money went. The schema's table is
/// `expense_categories` (additive, #47).
class ExpenseCategory {
  const ExpenseCategory({required this.id, required this.name, this.kind = ExpenseCategoryKind.normal, this.active = true});

  final String id;
  final String name;
  final ExpenseCategoryKind kind;
  final bool active; // false = removed: hidden from the buttons, but old expenses still show its name

  bool get isLocked => kind != ExpenseCategoryKind.normal;

  /// Whether staff can tap it on the expense form.
  bool get isPickable => active && (kind == ExpenseCategoryKind.normal || kind == ExpenseCategoryKind.other);

  /// Whether it counts as money spent in reports (paying someone back does not).
  bool get isCost => kind != ExpenseCategoryKind.repayment;

  ExpenseCategory copyWith({String? name, bool? active}) =>
      ExpenseCategory(id: id, name: name ?? this.name, kind: kind, active: active ?? this.active);
}

/// Fixed ids of the built-in categories. Only the sample shop and tests use them: a real shop gets its own
/// ids from [defaultExpenseCategoriesFor], because ids must be unique across shops in the backend.
class ExpenseCategoryIds {
  const ExpenseCategoryIds._();

  static const stock = '3c6c9e5d-2114-40df-893a-2eeedf76cdda';
  static const salaries = 'd3cb97db-5406-4c0f-ac21-d259e4e5661b';
  static const rent = 'da29018b-3f1d-4ba3-bffa-2041d1175f7b';
  static const utilities = 'f1ecb79a-e0df-4dab-8141-91b2897e0f1f';
  static const maintenance = 'aaf3de15-fb52-4734-9196-6c3fa6968b51';
  static const cleaning = '971657ae-5179-4e34-89f8-25856218d716';
  static const other = '9ffad3e6-f156-4f4a-80f1-b9a762f54da3';
  static const repayment = '69ff2b97-3cf8-4553-aef5-a2674e548ca7';
}

/// What the sample shop starts with, with the fixed ids above. (Names are written in Arabic like the rest of
/// the starting data; the owner can rename the normal ones.)
const defaultExpenseCategories = [
  ExpenseCategory(id: ExpenseCategoryIds.stock, name: 'مخزون', kind: ExpenseCategoryKind.stock),
  ExpenseCategory(id: ExpenseCategoryIds.salaries, name: 'مرتبات'),
  ExpenseCategory(id: ExpenseCategoryIds.rent, name: 'إيجار'),
  ExpenseCategory(id: ExpenseCategoryIds.utilities, name: 'كهرباء ومياه'),
  ExpenseCategory(id: ExpenseCategoryIds.maintenance, name: 'صيانة'),
  ExpenseCategory(id: ExpenseCategoryIds.cleaning, name: 'نظافة'),
  ExpenseCategory(id: ExpenseCategoryIds.other, name: 'أخرى', kind: ExpenseCategoryKind.other),
  ExpenseCategory(id: ExpenseCategoryIds.repayment, name: 'سداد', kind: ExpenseCategoryKind.repayment),
];

/// The starting list for a new shop. Each id is made from the shop's id, so two shops never share one.
List<ExpenseCategory> defaultExpenseCategoriesFor(String venueId) => [
      for (final c in defaultExpenseCategories)
        ExpenseCategory(id: stableId('$venueId/expense-category/${c.id}'), name: c.name, kind: c.kind),
    ];

/// The id of the built-in category of [kind] (stock, other or repayment), or null if the list has none.
/// Code finds these by kind, never by a fixed id, because every shop has its own ids.
String? idOfKind(List<ExpenseCategory> all, ExpenseCategoryKind kind) {
  for (final c in all) {
    if (c.kind == kind) return c.id;
  }
  return null;
}
