import 'package:al3b_staff/cash/cash_box_screen.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/expense_category.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final l10n = AppLocalizationsAr();

  ProviderContainer signedInAs(String staffId, {bool boxOpen = true}) {
    final container = ProviderContainer(overrides: [
      initialSignedInProvider.overrideWith((ref) => staffId),
      if (boxOpen) initialCashBoxProvider.overrideWith((ref) => openCashBoxState()), // opened by staff-1 (Admin)
    ]);
    addTearDown(container.dispose);
    return container;
  }

  group('where the money came from (rules)', () {
    test('an expense from the cash box lowers the expected cash', () {
      final container = signedInAs('staff-1');
      final cash = container.read(cashBoxProvider.notifier);
      cash.addMovement(CashMovementType.expense, 3000, note: 'x');
      expect(cash.expectedCash(container.read(cashBoxProvider).open!), 10000 - 3000);
      expect(container.read(cashBoxProvider).owed, isEmpty);
    });

    test('a staff member paying from their pocket: drawer untouched, the shop owes them', () {
      final container = signedInAs('staff-2'); // not an Admin, and not the cashier
      final cash = container.read(cashBoxProvider.notifier);
      expect(cash.canHandle, isFalse);
      cash.addMovement(CashMovementType.expense, 2500, note: 'ice', paidFrom: PaidFrom.pocket);
      expect(cash.expectedCash(container.read(cashBoxProvider).open!), 10000);
      expect(container.read(cashBoxProvider).owed, {'staff-2': 2500});
    });

    test('an Admin paying from their own pocket: nothing is owed', () {
      final container = signedInAs('staff-1');
      container
          .read(cashBoxProvider.notifier)
          .addMovement(CashMovementType.expense, 2500, note: 'ice', paidFrom: PaidFrom.pocket);
      expect(container.read(cashBoxProvider).owed, isEmpty);
    });

    test('a pocket expense works with no cash box open; only expenses can come from a pocket', () {
      final container = signedInAs('staff-2', boxOpen: false);
      final cash = container.read(cashBoxProvider.notifier);
      cash.addMovement(CashMovementType.expense, 1000, note: 'x', paidFrom: PaidFrom.pocket);
      expect(container.read(cashBoxProvider).owed, {'staff-2': 1000});
      expect(() => cash.addMovement(CashMovementType.cashIn, 1000, paidFrom: PaidFrom.pocket), throwsArgumentError);
      expect(() => cash.addMovement(CashMovementType.expense, 1000, note: 'x'), throwsStateError); // box needed
    });

    test('paying back from outside the box clears the debt and leaves the count alone', () {
      final container = signedInAs('staff-2');
      container.read(cashBoxProvider.notifier).addMovement(CashMovementType.expense, 2500, paidFrom: PaidFrom.pocket);
      // An Admin pays staff-2 back.
      final admin = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => 'staff-1'),
        initialCashBoxProvider.overrideWith((ref) => container.read(cashBoxProvider)),
      ]);
      addTearDown(admin.dispose);
      final cash = admin.read(cashBoxProvider.notifier);
      expect(cash.settleOwed('staff-2', PaidFrom.pocket), 2500);
      expect(admin.read(cashBoxProvider).owed, isEmpty);
      expect(cash.expectedCash(admin.read(cashBoxProvider).open!), 10000);
    });

    test('paying back from the cash box records an expense, so the count still matches', () {
      final container = signedInAs('staff-2');
      container.read(cashBoxProvider.notifier).addMovement(CashMovementType.expense, 2500, paidFrom: PaidFrom.pocket);
      final admin = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => 'staff-1'),
        initialCashBoxProvider.overrideWith((ref) => container.read(cashBoxProvider)),
      ]);
      addTearDown(admin.dispose);
      final cash = admin.read(cashBoxProvider.notifier);
      cash.settleOwed('staff-2', PaidFrom.cashBox, note: 'back');
      expect(admin.read(cashBoxProvider).owed, isEmpty);
      expect(cash.expectedCash(admin.read(cashBoxProvider).open!), 10000 - 2500);
    });
  });

  testWidgets('The expense form asks where the money came from and hints at the stock button', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester);
    await tester.tap(find.byIcon(Icons.payments_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const Key('record-expense')));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text(l10n.stockHint), findsOneWidget); // the hint to use the Bought button
    expect(find.byKey(const Key('paid-from-cash-box')), findsOneWidget);
    expect(find.byKey(const Key('paid-from-pocket')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('A non-Admin cashier paying from the pocket sees the owed list; an Admin can pay it back', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester, staffId: 'staff-2'); // the cashier of the open box, not an Admin
    await tester.tap(find.byIcon(Icons.payments_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const Key('record-expense')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byKey(const Key('paid-from-pocket')));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byKey(const Key('owed-hint')), findsOneWidget);
    await tester.enterText(find.byKey(const Key('movement-amount')), '25');
    await tester.tap(find.byKey(const Key('category-${ExpenseCategoryIds.other}'))); // "أخرى": a note is needed
    await tester.enterText(find.byKey(const Key('movement-reason')), 'ثلج');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const Key('movement-save')));
    await tester.pump(const Duration(milliseconds: 400));

    final page = find.byType(CashBoxScreen);
    expect(find.descendant(of: page, matching: find.text(l10n.owedTitle)), findsOneWidget);
    expect(find.descendant(of: page, matching: find.text('أحمد')), findsOneWidget); // owed row (the lists are hidden: blind)
    expect(find.byKey(const Key('settle-أحمد')), findsNothing); // only an Admin pays back
    expect(tester.takeException(), isNull);
  });
}
