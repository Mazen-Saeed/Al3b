import 'package:al3b_staff/data/cash_box_provider.dart';
import 'package:al3b_staff/data/catalog_provider.dart';
import 'package:al3b_staff/data/cash_box.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/floor/session_panel.dart';
import 'package:al3b_staff/data/unit.dart';
import 'package:al3b_staff/data/units_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:al3b_staff/shell/needs_action_provider.dart';
import 'package:al3b_staff/shell/nav_provider.dart';
import 'package:al3b_staff/shell/notice_board.dart';
import 'package:al3b_staff/shell/notification_bell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final l10n = AppLocalizationsAr();

  group('notifications history (rules)', () {
    ProviderContainer board() {
      final c = ProviderContainer(overrides: [noticeSoundProvider.overrideWith((ref) => (_) {})]);
      addTearDown(c.dispose);
      return c;
    }

    test('every notice except a quiet confirmation is kept, newest first', () {
      final c = board();
      final notices = c.read(noticeBoardProvider.notifier);
      notices.show(NoticeKind.endingSoon, 'PS5-1', autoHide: const Duration(hours: 1));
      notices.show(NoticeKind.info, 'تم البيع', autoHide: const Duration(hours: 1));
      notices.show(NoticeKind.timeUp, 'PS5-2');
      expect(c.read(notificationsProvider).map((n) => n.title), ['PS5-2', 'PS5-1']);
    });

    test('clear one and clear all; the banner and the history are separate', () {
      final c = board();
      final notices = c.read(noticeBoardProvider.notifier);
      notices.show(NoticeKind.timeUp, 'a');
      notices.show(NoticeKind.timeUp, 'b');
      notices.dismiss(c.read(noticeBoardProvider).first); // closing the banner keeps the history
      expect(c.read(notificationsProvider).length, 2);
      c.read(notificationsProvider.notifier).remove(c.read(notificationsProvider).first.id);
      expect(c.read(notificationsProvider).map((n) => n.title), ['a']);
      c.read(notificationsProvider.notifier).clear();
      expect(c.read(notificationsProvider), isEmpty);
    });
  });

  group('orange dots on the nav (rules)', () {
    ProviderContainer app({required String staffId, List<Unit>? units}) {
      final c = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => staffId),
        initialCashBoxProvider.overrideWith((ref) => openCashBoxState()),
        initialUnitsProvider.overrideWith((ref) => units ?? [testUnit()]),
        initialCatalogProvider.overrideWith((ref) => const Catalog()), // the sample stock has items running low
      ]);
      addTearDown(c.dispose);
      c.read(navProvider.notifier).open(NavPage.quickSale); // not looking at the page being tested
      return c;
    }

    test('nothing waiting: no dots', () {
      expect(app(staffId: 'staff-1').read(navDotsProvider), isEmpty);
    });

    test('a session waiting for payment puts a dot on the Floor until the Floor is opened', () {
      final c = app(staffId: 'staff-1', units: [testUnit(status: UnitStatus.waitingPayment)]);
      expect(c.read(navDotsProvider), {NavPage.floor});

      // Opening the page marks what is waiting as seen (the shell does this): the dot goes away.
      c.read(seenProvider.notifier).acknowledge(NavPage.floor, c.read(needsActionKeysProvider)[NavPage.floor]!);
      expect(c.read(navDotsProvider), isEmpty);
    });

    test('having seen something older does not hide something new; the open page never has a dot', () {
      final c = app(staffId: 'staff-1', units: [testUnit(status: UnitStatus.waitingPayment)]);
      c.read(seenProvider.notifier).acknowledge(NavPage.floor, {'an-older-session'});
      expect(c.read(navDotsProvider), {NavPage.floor}); // this one was not seen yet

      final other = app(staffId: 'staff-1', units: [testUnit(status: UnitStatus.waitingPayment)]);
      other.read(navProvider.notifier).open(NavPage.floor); // looking at it right now
      expect(other.read(navDotsProvider), isEmpty);
    });

    test('money the shop owes puts a dot on the Shift page, for an Admin only', () {
      final staff = app(staffId: 'staff-2');
      staff.read(cashBoxProvider.notifier).addMovement(CashMovementType.expense, 1000, paidFrom: PaidFrom.pocket);
      expect(staff.read(navDotsProvider), isEmpty); // not an Admin: not their page to act on

      final admin = ProviderContainer(overrides: [
        initialSignedInProvider.overrideWith((ref) => 'staff-1'),
        initialCashBoxProvider.overrideWith((ref) => staff.read(cashBoxProvider)),
        initialUnitsProvider.overrideWith((ref) => [testUnit()]),
        initialCatalogProvider.overrideWith((ref) => const Catalog()),
      ]);
      addTearDown(admin.dispose);
      admin.read(navProvider.notifier).open(NavPage.quickSale);
      expect(admin.read(navDotsProvider), {NavPage.shift});
    });
  });

  testWidgets('the bell drops a list down; clear one or all; tapping one opens its device', (tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await pumpApp(tester);
    final container = ProviderScope.containerOf(tester.element(find.byType(NotificationBell)));
    container.read(notificationsProvider.notifier)
      ..add(NoticeKind.timeUp, 'PS5-1 انتهى وقته', unitId: 'ps5-1')
      ..add(NoticeKind.endingSoon, 'PS5-2 باقي 10 دقايق');
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.descendant(of: find.byType(NotificationBell), matching: find.text('2')), findsOneWidget); // the count

    await tester.tap(find.byKey(const Key('notification-bell')));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('PS5-1 انتهى وقته'), findsOneWidget); // a list under the bell, not a new page
    expect(find.text('PS5-2 باقي 10 دقايق'), findsOneWidget);

    final second = container.read(notificationsProvider).first; // newest first: the 10-minutes one
    await tester.tap(find.byKey(Key('clear-${second.id}'))); // clear one
    await tester.pump(const Duration(milliseconds: 200));
    expect(container.read(notificationsProvider).length, 1);

    // Tapping the one about a device goes to the Floor with that device open.
    await tester.tap(find.text('PS5-1 انتهى وقته'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 400));
    expect(container.read(navProvider), NavPage.floor);
    expect(find.byType(SessionPanel), findsOneWidget);
    expect(container.read(focusUnitProvider), isNull); // the Floor took it

    // Clear all.
    await tester.tap(find.byKey(const Key('notification-bell')));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.byKey(const Key('clear-all-notifications')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text(l10n.noNotifications), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
