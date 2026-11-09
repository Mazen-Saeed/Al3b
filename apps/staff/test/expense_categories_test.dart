import 'package:al3b_staff/cash/cash_box_screen.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/expense_categories_provider.dart';
import 'package:al3b_staff/data/expense_category.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  ProviderContainer container() {
    final c = ProviderContainer(overrides: [
      initialSignedInProvider.overrideWith((ref) => 'staff-1'),
      initialCashBoxProvider.overrideWith((ref) => openCashBoxState()),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  group('expense categories (rules)', () {
    test('the built-in ids are all different', () {
      final ids = defaultExpenseCategories.map((c) => c.id).toSet();
      expect(ids.length, defaultExpenseCategories.length);
    });

    test('the buttons: normal ones in order, "أخرى" last, no stock and no repayment', () {
      final c = container();
      c.read(expenseCategoriesProvider.notifier).add('بنزين');
      final names = pickableCategories(c.read(expenseCategoriesProvider)).map((x) => x.name).toList();
      expect(names, ['مرتبات', 'إيجار', 'كهرباء ومياه', 'صيانة', 'نظافة', 'بنزين', 'أخرى']);
    });

    test('add refuses an empty or a repeated name; rename and remove leave built-in ones alone', () {
      final c = container();
      final cats = c.read(expenseCategoriesProvider.notifier);
      expect(cats.add('  '), isFalse);
      expect(cats.add('إيجار'), isFalse); // already there
      expect(cats.add('بنزين'), isTrue);
      expect(cats.rename(ExpenseCategoryIds.rent, 'إيجار المحل'), isTrue);
      expect(cats.rename(ExpenseCategoryIds.salaries, 'إيجار المحل'), isFalse); // taken now
      cats.rename(ExpenseCategoryIds.other, 'حاجة تانية'); // built in: ignored
      cats.remove(ExpenseCategoryIds.stock); // built in: ignored
      final all = c.read(expenseCategoriesProvider);
      expect(all.firstWhere((x) => x.id == ExpenseCategoryIds.other).name, 'أخرى');
      expect(all.firstWhere((x) => x.id == ExpenseCategoryIds.stock).active, isTrue);
    });

    test('a removed category leaves the buttons but old expenses still find its name', () {
      final c = container();
      c.read(cashBoxProvider.notifier).addMovement(
            CashMovementType.expense,
            1000,
            categoryId: ExpenseCategoryIds.cleaning,
          );
      c.read(expenseCategoriesProvider.notifier).remove(ExpenseCategoryIds.cleaning);
      expect(pickableCategories(c.read(expenseCategoriesProvider)).any((x) => x.id == ExpenseCategoryIds.cleaning), isFalse);
      final moved = c.read(cashBoxProvider).movements.single;
      expect(c.read(expenseCategoriesProvider).firstWhere((x) => x.id == moved.categoryId).name, 'نظافة');
      expect(c.read(expenseCategoriesProvider.notifier).add('نظافة'), isTrue); // the name is free again
    });

    test('an expense with no category is "أخرى"; cash in has none; paying back is not a cost', () {
      final c = container();
      final cash = c.read(cashBoxProvider.notifier);
      expect(cash.addMovement(CashMovementType.expense, 100).categoryId, ExpenseCategoryIds.other);
      expect(cash.addMovement(CashMovementType.cashIn, 100).categoryId, isNull);
      cash.addMovement(CashMovementType.expense, 500, paidFrom: PaidFrom.pocket); // admin: nothing owed
      final repayment = defaultExpenseCategories.firstWhere((x) => x.id == ExpenseCategoryIds.repayment);
      expect(repayment.isCost, isFalse);
    });
  });

  testWidgets('the expense form needs a category; "أخرى" also needs a note, the others do not', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester);
    await tester.tap(find.byIcon(Icons.payments_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const Key('record-expense')));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.enterText(find.byKey(const Key('movement-amount')), '500');
    await tester.pump(const Duration(milliseconds: 100));
    FilledButton save() => tester.widget<FilledButton>(find.byKey(const Key('movement-save')));
    expect(save().onPressed, isNull); // no category yet

    await tester.tap(find.byKey(const Key('category-${ExpenseCategoryIds.other}')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(save().onPressed, isNull); // "أخرى" needs a note

    await tester.tap(find.byKey(const Key('category-${ExpenseCategoryIds.salaries}')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(save().onPressed, isNotNull); // a note is optional for the others

    await tester.tap(find.byKey(const Key('movement-save')));
    await tester.pump(const Duration(milliseconds: 400));
    // The row in the page shows what it was for.
    expect(find.descendant(of: find.byType(CashBoxScreen), matching: find.text('مرتبات')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
