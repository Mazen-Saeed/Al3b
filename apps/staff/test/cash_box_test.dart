import 'package:al3b_staff/cash/cash_box_screen.dart';
import 'package:al3b_staff/data/bill.dart';
import 'package:al3b_staff/data/bills_provider.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/expense_category.dart';
import 'package:al3b_staff/data/product.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final l10n = AppLocalizationsAr();

  group('the cash box (rules)', () {
    test('opening makes the person the cashier, and only one can be open', () {
      final container = ProviderContainer(overrides: [initialSignedInProvider.overrideWith((ref) => 'staff-2')]);
      addTearDown(container.dispose);
      final cash = container.read(cashBoxProvider.notifier);

      final box = cash.open(5000);
      expect(box.openedById, 'staff-2');
      expect(container.read(cashBoxProvider).open?.openingCash, 5000);
      expect(() => cash.open(100), throwsStateError);
    });

    test('no payment without an open cash box', () {
      final container = ProviderContainer(overrides: [initialSignedInProvider.overrideWith((ref) => 'staff-1')]);
      addTearDown(container.dispose);
      expect(
        () => container.read(billsProvider.notifier).quickSale({'p': 1}, method: PaymentMethod.cash),
        throwsStateError,
      );
    });

    test('expected cash = start + cash bills + cash in - expenses; InstaPay does not count; close keeps the difference',
        () {
      final container = makeContainer(products: const [Product(id: 'p', name: 'بيبسي', price: 1500)]);
      final bills = container.read(billsProvider.notifier);
      final cash = container.read(cashBoxProvider.notifier);

      bills.quickSale({'p': 2}, method: PaymentMethod.cash); // 30 EGP in cash
      bills.quickSale({'p': 1}, method: PaymentMethod.instapay); // 15 EGP, not in the box
      cash.addMovement(CashMovementType.cashIn, 2000, note: 'x'); // +20
      cash.addMovement(CashMovementType.expense, 3000, note: 'ice'); // -30

      final box = container.read(cashBoxProvider).open!;
      expect(box.openingCash, 10000);
      expect(cash.expectedCash(box), 10000 + 3000 + 2000 - 3000); // 120 EGP

      final closed = cash.close(11000); // counted 110
      expect(closed.expectedCash, 12000);
      expect(closed.difference, -1000); // 10 EGP missing
      expect(container.read(cashBoxProvider).open, isNull);
      expect(container.read(cashBoxProvider).lastClosed?.countedCash, 11000);
    });

    test('a bill remembers its cash box and who took the payment', () {
      final container = makeContainer(products: const [Product(id: 'p', name: 'بيبسي', price: 1500)]);
      final bill = container.read(billsProvider.notifier).quickSale({'p': 1}, method: PaymentMethod.cash)!;
      expect(bill.cashBoxId, 'box-1');
      expect(bill.takenById, 'staff-1');
    });

    test('only the cashier or an Admin records and closes', () {
      final container = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => 'staff-3'), // not an Admin
        initialCashBoxProvider.overrideWith((ref) => openCashBoxState()), // opened by staff-1
      ]);
      addTearDown(container.dispose);
      final cash = container.read(cashBoxProvider.notifier);
      expect(cash.canHandle, isFalse);
      expect(() => cash.addMovement(CashMovementType.expense, 100, note: 'x'), throwsStateError);
      expect(() => cash.close(0), throwsStateError);
    });
  });

  testWidgets('paying with no cash box open asks to open one first', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester, cashBoxOpen: false);
    await tester.tap(find.byIcon(Icons.local_drink_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('بيبسي').last);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('${l10n.quickSaleSell} · ${l10n.amountEgp('15')}'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(l10n.openCashBoxFirst), findsOneWidget);
    expect(find.text('${l10n.quickSaleDone} · ${l10n.amountEgp('15')}'), findsNothing);

    await tester.enterText(find.byKey(const Key('opening-cash')), '50');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const Key('open-cash-box-confirm')));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('${l10n.quickSaleDone} · ${l10n.amountEgp('15')}'), findsOneWidget); // the sale went through
    await tester.pump(const Duration(seconds: 4)); // the notice hides itself
    expect(tester.takeException(), isNull);
  });

  testWidgets('Cash box page: open, record an expense, close with a count and see the difference', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester, cashBoxOpen: false);
    await tester.tap(find.byIcon(Icons.payments_outlined).first); // the Cash box tab (first: the nav)
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(l10n.cashBoxClosedTitle), findsOneWidget);

    await tester.tap(find.byKey(const Key('open-cash-box')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key('opening-cash')), '100');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const Key('open-cash-box-confirm')));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('${l10n.cashierLabel}: مازن'), findsOneWidget); // staff-1 is the signed-in person

    await tester.tap(find.byKey(const Key('record-expense')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key('movement-amount')), '30');
    await tester.tap(find.byKey(const Key('category-${ExpenseCategoryIds.other}'))); // "أخرى": a note is needed
    await tester.enterText(find.byKey(const Key('movement-reason')), 'ثلج');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const Key('movement-save')));
    await tester.pump(const Duration(milliseconds: 400));
    // Only inside the page: the closing form may still be fading out, and its field holds the same text.
    expect(find.descendant(of: find.byType(CashBoxScreen), matching: find.text('ثلج')), findsOneWidget);
    // staff-1 is an Admin, so the live amount shows: 100 - 30.
    expect(find.text('${l10n.expectedNowLabel}: ${l10n.amountEgp('70')}'), findsOneWidget);

    await tester.tap(find.byKey(const Key('close-cash-box')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.enterText(find.byKey(const Key('counted-cash')), '60'); // should be 70: 10 missing
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(const Key('close-cash-box-confirm')));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byKey(const Key('cash-difference')), findsOneWidget);
    // The page behind the form also shows the last closing, so look at the form's own line.
    expect(
      tester.widget<Text>(find.byKey(const Key('cash-difference'))).data,
      '${l10n.cashShort} ${l10n.amountEgp('10')}',
    );

    // Dismiss the result: the closed cash box is now in the history, and opens with its details.
    await tester.tap(find.text(l10n.doneButton));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const Key('tab-past')), findsOneWidget); // an Admin has the second tab
    await tester.tap(find.byKey(const Key('tab-past')));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.descendant(
      of: find.byType(CashBoxScreen),
      matching: find.text('${l10n.cashShort} ${l10n.amountEgp('10')}'),
    ).last);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text(l10n.startedWithLabel), findsOneWidget); // the detail shows how the shift adds up
    expect(find.text(l10n.outsideDrawerTitle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a cashier who is not an Admin counts blind: no amount, no lists, no shop setting', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester, staffId: 'staff-2'); // not an Admin; the open cash box is theirs
    await tester.tap(find.byIcon(Icons.payments_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const Key('expected-now')), findsNothing); // blind
    expect(find.text(l10n.outsideDrawerTitle), findsNothing); // the table of how it adds up is hidden too

    await tester.tap(find.byIcon(Icons.settings_outlined).first); // Settings: only the language is theirs
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const Key('show-expected-switch')), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('with the shop setting on, a cashier who is not an Admin sees the amount and the table', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester, staffId: 'staff-2', savedSettings: {'showExpectedCash': true});
    await tester.tap(find.byIcon(Icons.payments_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('${l10n.expectedNowLabel}: ${l10n.amountEgp('100')}'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('an Admin sees the shop setting', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester); // staff-1 is an Admin
    await tester.tap(find.byIcon(Icons.settings_outlined).first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const Key('show-expected-switch')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
