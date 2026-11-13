import 'package:al3b_staff/activity/activity_screen.dart';
import 'package:al3b_staff/data/activity_log.dart';
import 'package:al3b_staff/data/bill.dart';
import 'package:al3b_staff/data/bills_provider.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/cancel_session.dart';
import 'package:al3b_staff/cash/shift_activity.dart';
import 'package:al3b_staff/cash/shift_numbers.dart';
import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/correct_reason.dart';
import 'package:al3b_staff/data/catalog_provider.dart';
import 'package:al3b_staff/data/orders_provider.dart';
import 'package:al3b_staff/data/product.dart';
import 'package:al3b_staff/data/stock.dart';
import 'package:al3b_staff/data/units_provider.dart';
import 'package:al3b_staff/data/pin_hasher.dart';
import 'package:al3b_staff/data/staff_member.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/data/unit.dart';
import 'package:al3b_staff/l10n/arb/app_localizations.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  const hasher = PinHasher(iterations: 5);

  List<ActivityEntry> logOf(ProviderContainer c) => c.read(activityLogProvider);

  group('what gets written down', () {
    test('closing the cash box is written, and flagged when it is 20 EGP or more off', () {
      final off = makeContainer();
      off.read(cashBoxProvider.notifier).close(10000 - 2500);
      expect(logOf(off).single.kind, ActivityKind.cashBoxClosed);
      expect(logOf(off).single.suspicious, isTrue);
      expect((logOf(off).single.number('counted'), logOf(off).single.number('expected')), (7500, 10000));

      final close = makeContainer();
      close.read(cashBoxProvider.notifier).close(10000 - 500);
      expect(logOf(close).single.suspicious, isFalse);
    });

    test('taking money out is written; it is flagged when the owner is not the one who took it', () {
      final owner = makeContainer(); // staff-1 is the owner
      owner.read(cashBoxProvider.notifier).addMovement(CashMovementType.ownerWithdrawal, 1000, note: 'x');
      expect(logOf(owner).single.kind, ActivityKind.cashWithdrawal);
      expect(logOf(owner).single.suspicious, isFalse);

      final other = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => 'staff-2'),
        initialCashBoxProvider.overrideWith((ref) => openCashBoxState(openedBy: 'staff-2')),
      ]);
      addTearDown(other.dispose);
      other.read(cashBoxProvider.notifier).addMovement(CashMovementType.ownerWithdrawal, 1000, note: 'x');
      expect(logOf(other).single.suspicious, isTrue);
    });

    test('a session closed at zero cost is flagged; a big discount is flagged, a small one is only written', () {
      final start = DateTime(2026, 1, 1, 10);
      ProviderContainer running() => makeContainer(units: [testUnit(status: UnitStatus.running, startedAt: start)]);

      final free = running();
      free.read(billsProvider.notifier).endAndPay('u1', endedAt: start, method: PaymentMethod.cash);
      expect(logOf(free).single.kind, ActivityKind.sessionZeroCost);
      expect(logOf(free).single.suspicious, isTrue);

      final big = running();
      big.read(billsProvider.notifier).endAndPay('u1',
          endedAt: start.add(const Duration(hours: 2)), discount: largeDiscountLimit, method: PaymentMethod.cash);
      expect((logOf(big).single.kind, logOf(big).single.suspicious), (ActivityKind.discountGiven, true));

      final small = running();
      small.read(billsProvider.notifier).endAndPay('u1',
          endedAt: start.add(const Duration(hours: 2)), discount: 500, method: PaymentMethod.cash);
      expect((logOf(small).single.kind, logOf(small).single.suspicious), (ActivityKind.discountGiven, false));

      final plain = running();
      plain.read(billsProvider.notifier).endAndPay('u1', endedAt: start.add(const Duration(hours: 1)), method: PaymentMethod.cash);
      expect(logOf(plain), isEmpty); // an ordinary payment is not written here
    });

    test('staff changes are written, and a PIN lockout is flagged against the person whose PIN was tried', () {
      final owner = StaffMember(id: 'owner', name: 'مازن', pinHash: hasher.hash('1234'), phone: '01012345678', isAdmin: true, isOwner: true);
      final worker = StaffMember(id: 'worker', name: 'أحمد', pinHash: hasher.hash('1111'));
      final c = ProviderContainer(overrides: [
        initialStaffProvider.overrideWith((ref) => [owner, worker]),
        initialSignedInProvider.overrideWith((ref) => 'owner'),
      ]);
      addTearDown(c.dispose);
      final staff = c.read(staffProvider.notifier);

      staff.add(name: 'منى', pin: '2222', hasher: hasher);
      staff.resetPin('worker', '3333', hasher: hasher);
      staff.deactivate('worker');
      expect(logOf(c).map((e) => e.kind), [ActivityKind.staffAdded, ActivityKind.staffPinReset, ActivityKind.staffStopped]);
      expect(logOf(c).every((e) => e.staffId == 'owner' && !e.suspicious), isTrue);

      final login = c.read(currentStaffIdProvider.notifier);
      login.lock();
      for (var i = 0; i < freeTries; i++) {
        login.unlock('owner', '0000');
      }
      final locked = logOf(c).last;
      expect((locked.kind, locked.suspicious, locked.staffId, locked.text('name')), (ActivityKind.pinLockedOut, true, 'owner', 'مازن'));
    });
  });

  group('cancelling a session', () {
    final start = DateTime(2026, 1, 1, 10);
    ProviderContainer running({List<Product> products = const [], List<StockItem> stock = const []}) =>
        makeContainer(units: [testUnit(status: UnitStatus.running, startedAt: start)], products: products, stockItems: stock);
    DateTime after(int minutes) => start.add(Duration(minutes: minutes));

    test('in the first minutes it needs no reason and counts as a mistake', () {
      final c = running();
      final cancel = c.read(sessionCancelProvider);
      expect(cancel.needsReason('u1', now: after(2)), isFalse);

      cancel.cancel('u1', now: after(2));

      expect(c.read(unitsProvider).byId('u1').status, UnitStatus.free);
      final entry = logOf(c).single;
      expect((entry.kind, entry.suspicious, entry.text('reason')), (ActivityKind.sessionCancelled, false, CancelReason.mistake));
    });

    test('later it needs a reason, and writes what was not collected', () {
      final c = running();
      final cancel = c.read(sessionCancelProvider);
      expect(cancel.needsReason('u1', now: after(30)), isTrue);
      expect(() => cancel.cancel('u1', now: after(30)), throwsArgumentError);
      expect(c.read(unitsProvider).byId('u1').status, UnitStatus.running); // nothing happened

      cancel.cancel('u1', reason: CancelReason.deviceProblem, now: after(30));

      final entry = logOf(c).single;
      expect(entry.number('amount'), 2500); // 30 minutes at 50 EGP an hour
      expect((entry.number('minutes'), entry.text('reason'), entry.text('unit')), (30, CancelReason.deviceProblem, 'PS5-1'));
      expect(entry.suspicious, isFalse); // 25 EGP: under the limit
    });

    test('a cancelled session with 50 EGP or more on it is flagged', () {
      final c = running();
      c.read(sessionCancelProvider).cancel('u1', reason: CancelReason.customerLeft, now: after(60));
      expect(logOf(c).single.number('amount'), 5000);
      expect(logOf(c).single.suspicious, isTrue);
    });

    test('products count in the amount; they come back to the shelf only for a mistake', () {
      const tea = Product(id: 'p1', name: 'شاي', price: 1000, stockItemId: 's1');
      const shelf = StockItem(id: 's1', name: 'شاي', deductsOnSale: true, onHand: 10);
      int onHand(ProviderContainer c) => c.read(catalogProvider).stockItems.single.onHand;

      final left = running(products: [tea], stock: [shelf]);
      left.read(ordersProvider.notifier).addOrder('u1', {'p1': 2});
      expect(onHand(left), 8);
      left.read(sessionCancelProvider).cancel('u1', reason: CancelReason.customerLeft, now: after(60));
      expect(onHand(left), 8); // drunk
      expect(logOf(left).single.number('amount'), 5000 + 2000);
      expect(left.read(ordersProvider).forUnit('u1'), isEmpty);

      final slip = running(products: [tea], stock: [shelf]);
      slip.read(ordersProvider.notifier).addOrder('u1', {'p1': 2});
      slip.read(sessionCancelProvider).cancel('u1', now: after(1));
      expect(onHand(slip), 10); // never served
    });
  });

  group('correcting a paid bill', () {
    final start = DateTime(2026, 1, 1, 10);
    // A session paid after 2 hours at 50 EGP an hour: 100 EGP.
    (ProviderContainer, String) paid() {
      final c = makeContainer(units: [testUnit(status: UnitStatus.running, startedAt: start)]);
      final bill = c.read(billsProvider.notifier).endAndPay('u1', endedAt: start.add(const Duration(hours: 2)), method: PaymentMethod.cash);
      return (c, bill.id);
    }

    test('the amount changes, and the log keeps the old and the new one with the reason', () {
      final (c, id) = paid();

      c.read(billsProvider.notifier).correct(id, newTotal: 7000, reason: CorrectReason.agreedDiscount);

      final bill = c.read(billsProvider).single;
      expect((bill.total, bill.discount, bill.subtotal), (7000, 3000, 10000));
      final entry = logOf(c).single;
      expect((entry.kind, entry.number('old'), entry.number('new'), entry.text('reason')), (ActivityKind.billCorrected, 10000, 7000, CorrectReason.agreedDiscount));
      expect(entry.suspicious, isFalse); // 30 EGP less: under the limit
    });

    test('taking 50 EGP or more less is flagged; taking more again is not', () {
      final (c, id) = paid();
      final bills = c.read(billsProvider.notifier);

      bills.correct(id, newTotal: 5000, reason: CorrectReason.wrongTime);
      expect(logOf(c).last.suspicious, isTrue);

      bills.correct(id, newTotal: 8000, reason: CorrectReason.wrongTime);
      expect(logOf(c).last.suspicious, isFalse);
      expect(c.read(billsProvider).single.total, 8000);
    });

    test('it never goes above the calculated price or below nothing, and no change writes nothing', () {
      final (c, id) = paid();
      final bills = c.read(billsProvider.notifier);

      bills.correct(id, newTotal: 99999, reason: CorrectReason.other); // clamped: the same as now
      expect(c.read(billsProvider).single.total, 10000);
      expect(logOf(c), isEmpty);

      bills.correct(id, newTotal: -500, reason: CorrectReason.other);
      expect(c.read(billsProvider).single.total, 0);
    });

    test('a bill of a closed cash box cannot be corrected', () {
      final (c, id) = paid();
      c.read(cashBoxProvider.notifier).close(10000 + 10000);

      expect(() => c.read(billsProvider.notifier).correct(id, newTotal: 5000, reason: CorrectReason.other), throwsStateError);
      expect(c.read(billsProvider).single.total, 10000);
    });
  });

  testWidgets('tapping a bill in the shift list corrects it, with a reason', (tester) async {
    final l10n = AppLocalizationsAr();
    final box = openCashBoxState().boxes.single;
    final bill = Bill(
      id: 'b1',
      paidAt: DateTime(2026, 1, 1, 11),
      unitId: 'u1',
      unitName: 'PS5-1',
      startedAt: DateTime(2026, 1, 1, 10),
      endedAt: DateTime(2026, 1, 1, 11),
      isMulti: false,
      hourlyPrice: 5000,
      playCost: 5000,
      lines: const [],
      discount: 0,
      method: PaymentMethod.cash,
      cashBoxId: box.id,
      takenById: 'staff-1',
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialSignedInProvider.overrideWith((ref) => 'staff-1'),
          initialCashBoxProvider.overrideWith((ref) => openCashBoxState()),
          initialBillsProvider.overrideWith((ref) => [bill]),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(body: SingleChildScrollView(child: ShiftActivity(box: box))),
        ),
      ),
    );
    final container = ProviderScope.containerOf(tester.element(find.byType(ShiftActivity)));

    await tester.tap(find.text('PS5-1'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text(l10n.correctCalculated(l10n.amountEgp('50'))), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byKey(const Key('correct-save'))).onPressed, isNull); // nothing changed yet

    await tester.enterText(find.byKey(const Key('correct-amount')), '60'); // more than the calculated price
    await tester.pump();
    expect(find.text(l10n.correctTooHigh(l10n.amountEgp('50'))), findsOneWidget);

    await tester.enterText(find.byKey(const Key('correct-amount')), '40');
    await tester.tap(find.byKey(const Key('correct-reason-${CorrectReason.wrongOrder}')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('correct-save')));
    await tester.pump(const Duration(milliseconds: 400));

    expect(container.read(billsProvider).single.total, 4000);
    expect(container.read(activityLogProvider).single.text('reason'), CorrectReason.wrongOrder);
  });

  testWidgets('the shift summary counts the cancelled sessions of that shift and what they would have brought', (tester) async {
    final l10n = AppLocalizationsAr();
    final box = openCashBoxState().boxes.single; // opened 2026-01-01 09:00
    ActivityEntry cancelled(String id, DateTime at, int amount) => ActivityEntry(
        id: id, at: at, staffId: 'staff-1', kind: ActivityKind.sessionCancelled, details: {'unit': 'PS5-1', 'amount': amount});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialCashBoxProvider.overrideWith((ref) => openCashBoxState()),
          initialActivityLogProvider.overrideWith((ref) => [
                cancelled('before', DateTime(2026, 1, 1, 8), 9999), // before this shift: not counted
                cancelled('a', DateTime(2026, 1, 1, 10), 2500),
                cancelled('b', DateTime(2026, 1, 1, 11), 5000),
              ]),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(body: SingleChildScrollView(child: ShiftNumbers(box: box))),
        ),
      ),
    );

    expect(find.text(l10n.shiftCancelled(2)), findsOneWidget);
    expect(find.text(l10n.amountEgp('75')), findsOneWidget);
  });

  testWidgets('the Cancel button asks for a reason, then ends the session and writes it', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final l10n = AppLocalizationsAr();

    await pumpApp(tester);
    final container = ProviderScope.containerOf(tester.element(find.byType(Scaffold).first));
    await tester.tap(find.text('PS5-1').first); // a session that has run a while
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const Key('cancel-session')));
    await tester.pump(const Duration(milliseconds: 400));

    // Nothing to confirm with until a reason is picked.
    expect(tester.widget<FilledButton>(find.byKey(const Key('cancel-confirm'))).onPressed, isNull);
    await tester.tap(find.byKey(const Key('cancel-reason-${CancelReason.customerLeft}')));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text(l10n.cancelConfirm));
    await tester.pump(const Duration(milliseconds: 400));

    final entry = container.read(activityLogProvider).single;
    expect((entry.kind, entry.text('reason'), entry.text('unit')), (ActivityKind.sessionCancelled, CancelReason.customerLeft, 'PS5-1'));
    expect(container.read(unitsProvider).byId('ps5-1').status, UnitStatus.free);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('the activity page lists lines newest first and can show only the risky ones', (tester) async {
    final l10n = AppLocalizationsAr();
    final owner = StaffMember(id: 'owner', name: 'مازن', pinHash: '', isAdmin: true, isOwner: true);
    final entries = [
      ActivityEntry(id: 'a', at: DateTime(2026, 1, 1, 9), staffId: 'owner', kind: ActivityKind.staffAdded, details: const {'name': 'منى'}),
      ActivityEntry(
        id: 'b',
        at: DateTime(2026, 1, 1, 10),
        staffId: 'owner',
        kind: ActivityKind.cashWithdrawal,
        suspicious: true,
        details: const {'amount': 5000},
      ),
    ];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialStaffProvider.overrideWith((ref) => [owner]),
          initialActivityLogProvider.overrideWith((ref) => entries),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(body: ActivityScreen(onBack: () {})),
        ),
      ),
    );

    expect(find.text(l10n.activityStaffAdded('منى')), findsOneWidget);
    expect(find.text(l10n.activityCashWithdrawal(l10n.amountEgp('50'))), findsOneWidget);
    // Newest first: the withdrawal (10:00) sits above "added" (9:00).
    expect(tester.getTopLeft(find.byKey(const Key('activity-b'))).dy, lessThan(tester.getTopLeft(find.byKey(const Key('activity-a'))).dy));

    await tester.tap(find.byKey(const Key('activity-only-suspicious')));
    await tester.pump();
    expect(find.byKey(const Key('activity-a')), findsNothing);
    expect(find.byKey(const Key('activity-b')), findsOneWidget);
  });
}
