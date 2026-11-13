import 'package:al3b_staff/data/pin_hasher.dart';
import 'package:al3b_staff/data/staff_member.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:al3b_staff/staff/staff_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const hasher = PinHasher(iterations: 5);
  final owner = StaffMember(id: 'owner', name: 'مازن', pinHash: hasher.hash('1234'), phone: '01012345678', isAdmin: true, isOwner: true);
  final admin = StaffMember(id: 'admin', name: 'سامي', pinHash: hasher.hash('2345'), phone: '01112345678', isAdmin: true);
  final worker = StaffMember(id: 'worker', name: 'أحمد', pinHash: hasher.hash('1111'));

  ProviderContainer open(String signedInId) {
    final c = ProviderContainer(overrides: [
      initialStaffProvider.overrideWith((ref) => [owner, admin, worker]),
      initialSignedInProvider.overrideWith((ref) => signedInId),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  group('who may add and change people', () {
    test('the owner adds staff and Admins; the new person can sign in with their PIN', () {
      final c = open('owner');
      final staff = c.read(staffProvider.notifier);

      final added = staff.add(name: ' منى ', pin: '2222', hasher: hasher);
      expect(added?.name, 'منى');
      expect(added?.isAdmin, isFalse);
      expect(staff.add(name: 'هبة', pin: '3333', phone: '01212345678', isAdmin: true, hasher: hasher)?.isAdmin, isTrue);

      c.read(currentStaffIdProvider.notifier).lock();
      expect(c.read(currentStaffIdProvider.notifier).unlock(added!.id, '2222').signedIn, isTrue);
    });

    test('an Admin adds plain staff but not another Admin; plain staff add nobody', () {
      final byAdmin = open('admin').read(staffProvider.notifier);
      expect(byAdmin.add(name: 'منى', pin: '2222', hasher: hasher), isNotNull);
      expect(byAdmin.add(name: 'هبة', pin: '3333', phone: '01212345678', isAdmin: true, hasher: hasher), isNull);

      final byWorker = open('worker').read(staffProvider.notifier);
      expect(byWorker.add(name: 'منى', pin: '2222', hasher: hasher), isNull);
    });

    test('a bad name, PIN or Admin phone is refused', () {
      final staff = open('owner').read(staffProvider.notifier);
      expect(staff.add(name: '', pin: '2222', hasher: hasher), isNull);
      expect(staff.add(name: 'أحمد', pin: '2222', hasher: hasher), isNull); // name taken
      expect(staff.add(name: 'منى', pin: '222', hasher: hasher), isNull); // PIN too short
      expect(staff.add(name: 'منى', pin: '2222', isAdmin: true, hasher: hasher), isNull); // Admin without a phone
      expect(staff.add(name: 'منى', pin: '2222', phone: '123', isAdmin: true, hasher: hasher), isNull);
    });

    test('an Admin changes plain staff, never the owner or another Admin; everyone changes themselves', () {
      final staff = open('admin').read(staffProvider.notifier);
      expect(staff.canManage(worker), isTrue);
      expect(staff.canManage(owner), isFalse);
      expect(staff.canManage(admin), isTrue); // themselves
      expect(open('worker').read(staffProvider.notifier).canManage(worker), isFalse); // plain staff manage nobody
      expect(open('owner').read(staffProvider.notifier).canManage(admin), isTrue);
    });

    test('only the owner changes a role, and the owner stays an Admin', () {
      final c = open('admin');
      expect(c.read(staffProvider.notifier).update('worker', isAdmin: true, phone: '01212345678'), isFalse);

      final byOwner = open('owner').read(staffProvider.notifier);
      expect(byOwner.update('worker', isAdmin: true), isFalse); // an Admin needs a phone
      expect(byOwner.update('worker', isAdmin: true, phone: '01212345678'), isTrue);
      expect(byOwner.update('owner', isAdmin: false), isFalse);
    });

    test('renaming refuses a name another person has', () {
      final staff = open('owner').read(staffProvider.notifier);
      expect(staff.update('worker', name: 'سامي'), isFalse);
      expect(staff.update('worker', name: 'أحمد علي'), isTrue);
    });
  });

  group('resetting a PIN and stopping a person', () {
    test('a reset PIN works, the old one does not, and a lockout is lifted', () {
      final c = open('owner');
      final login = c.read(currentStaffIdProvider.notifier);
      login.lock();
      for (var i = 0; i < freeTries; i++) {
        login.unlock('worker', '0000');
      }
      expect(login.unlock('worker', '1111').outcome, UnlockOutcome.lockedOut);

      login.signInAs('owner');
      expect(c.read(staffProvider.notifier).resetPin('worker', '9876', hasher: hasher), isTrue);
      login.lock();

      expect(login.unlock('worker', '1111').signedIn, isFalse);
      expect(login.unlock('worker', '9876').signedIn, isTrue);
    });

    test('an Admin cannot reset the owner PIN', () {
      expect(open('admin').read(staffProvider.notifier).resetPin('owner', '9876', hasher: hasher), isFalse);
    });

    test('a stopped person cannot sign in but stays in the list for old records', () {
      final c = open('owner');
      expect(c.read(staffProvider.notifier).deactivate('worker'), isTrue);
      expect(c.read(staffProvider).firstWhere((s) => s.id == 'worker').active, isFalse);

      final login = c.read(currentStaffIdProvider.notifier);
      login.lock();
      expect(login.unlock('worker', '1111').signedIn, isFalse); // the right PIN no longer works
    });

    test('nobody can stop the owner or themselves', () {
      final byOwner = open('owner').read(staffProvider.notifier);
      expect(byOwner.deactivate('owner'), isFalse);
      expect(open('admin').read(staffProvider.notifier).deactivate('admin'), isFalse);
      expect(open('admin').read(staffProvider.notifier).deactivate('owner'), isFalse);
    });
  });

  testWidgets('the staff page: add a person with a PIN, and they show in the list', (tester) async {
    final l10n = AppLocalizationsAr();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialStaffProvider.overrideWith((ref) => [owner, worker]),
          initialSignedInProvider.overrideWith((ref) => 'owner'),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(body: StaffScreen(onBack: () {})),
        ),
      ),
    );

    expect(find.text('مازن'), findsOneWidget);
    expect(find.text(l10n.roleOwner), findsOneWidget);

    await tester.tap(find.text(l10n.newStaff));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.widget<FilledButton>(find.byKey(const Key('staff-save'))).onPressed, isNull);

    await tester.enterText(find.byKey(const Key('staff-name')), 'منى');
    await tester.enterText(find.byKey(const Key('staff-pin')), '2222');
    await tester.pump();
    await tester.tap(find.byKey(const Key('staff-save')));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('منى'), findsOneWidget);
    expect(find.text(l10n.roleStaff), findsNWidgets(2)); // أحمد and منى
  });
}
