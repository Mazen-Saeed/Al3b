import 'package:al3b_staff/data/pin_attempts.dart';
import 'package:al3b_staff/data/preferences_provider.dart';
import 'package:al3b_staff/data/sample_data.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:al3b_staff/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final l10n = AppLocalizationsAr();

  group('who is working (the lock)', () {
    test('the right PIN signs in, a wrong one stays locked', () {
      final container = ProviderContainer(); // not signed in
      addTearDown(container.dispose);
      final notifier = container.read(currentStaffIdProvider.notifier);
      expect(container.read(currentStaffIdProvider), isNull);

      expect(notifier.unlock('staff-2', '0000').outcome, UnlockOutcome.wrongPin);
      expect(container.read(currentStaffIdProvider), isNull);

      expect(notifier.unlock('staff-2', '1111').signedIn, isTrue);
      expect(container.read(currentStaffProvider)?.name, 'أحمد');

      notifier.lock();
      expect(container.read(currentStaffProvider), isNull);
    });
  });

  group('lockout after wrong tries', () {
    late DateTime now;
    late ProviderContainer container;
    late CurrentStaffNotifier notifier;

    setUp(() {
      now = DateTime(2026, 1, 2, 9);
      container = ProviderContainer(overrides: [nowProvider.overrideWith((ref) => () => now)]);
      addTearDown(container.dispose);
      notifier = container.read(currentStaffIdProvider.notifier);
    });

    void wrongTries(int n) {
      for (var i = 0; i < n; i++) {
        notifier.unlock('staff-2', '0000');
      }
    }

    test('the last free wrong PIN locks that person out, even a right PIN is refused', () {
      wrongTries(freeTries - 1);
      final last = notifier.unlock('staff-2', '0000');
      expect(last.outcome, UnlockOutcome.lockedOut);
      expect(last.retryAfter, firstLockout);

      expect(notifier.unlock('staff-2', '1111').outcome, UnlockOutcome.lockedOut);
      expect(container.read(currentStaffIdProvider), isNull);
    });

    test('after the wait the right PIN works, and the count starts again', () {
      wrongTries(freeTries);
      now = now.add(firstLockout);

      expect(notifier.unlock('staff-2', '1111').signedIn, isTrue);
      notifier.lock();
      wrongTries(freeTries - 1); // starts from zero: the tries before the last are still just wrong
      expect(notifier.unlock('staff-2', '0000').outcome, UnlockOutcome.lockedOut);
    });

    test('each further wrong try doubles the wait, up to a limit', () {
      wrongTries(freeTries);
      var wait = firstLockout;
      for (var i = 0; i < 12; i++) {
        now = now.add(wait);
        final result = notifier.unlock('staff-2', '0000');
        wait = Duration(seconds: [wait.inSeconds * 2, longestLockout.inSeconds].reduce((a, b) => a < b ? a : b));
        expect(result.retryAfter, wait);
      }
      expect(wait, longestLockout);
    });

    test('closing and reopening the app does not reset the lockout', () {
      final saved = <String, PinAttempts>{};
      ProviderContainer open() {
        final c = ProviderContainer(overrides: [
          nowProvider.overrideWith((ref) => () => now),
          initialPinAttemptsProvider.overrideWith((ref) => {...saved}),
          pinAttemptsSaverProvider.overrideWith((ref) => (id, attempts) => saved[id] = attempts),
        ]);
        addTearDown(c.dispose);
        return c;
      }

      final first = open().read(currentStaffIdProvider.notifier);
      for (var i = 0; i < freeTries; i++) {
        first.unlock('staff-2', '0000');
      }

      final afterRestart = open().read(currentStaffIdProvider.notifier);
      expect(afterRestart.unlock('staff-2', '1111').outcome, UnlockOutcome.lockedOut);
      now = now.add(firstLockout);
      expect(afterRestart.unlock('staff-2', '1111').signedIn, isTrue);
    });

    test('locking one person out does not lock the others', () {
      wrongTries(freeTries);
      expect(notifier.unlock('staff-3', '2222').signedIn, isTrue);
    });
  });

  testWidgets('the app starts locked: pick a name, a wrong PIN is refused, the right one opens the Floor',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)], // not signed in
        child: const MyApp(),
      ),
    );
    for (var i = 0; i < 20 && find.text(l10n.pickYourName).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text(l10n.pickYourName), findsOneWidget);
    expect(find.text(sampleVenueName), findsNothing);

    Future<void> typePin(String pin) async {
      for (final d in pin.split('')) {
        await tester.tap(find.byKey(Key('pin-key-$d')));
        await tester.pump(const Duration(milliseconds: 50));
      }
    }

    await tester.tap(find.text('أحمد'));
    await tester.pump(const Duration(milliseconds: 100));
    await typePin('9999');
    expect(find.text(l10n.wrongPin), findsOneWidget);
    expect(find.text(sampleVenueName), findsNothing);

    await typePin('1111');
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(sampleVenueName), findsOneWidget);

    // The lock button in the header goes back to the lock screen.
    await tester.tap(find.byKey(const Key('lock-button')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(l10n.pickYourName), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('after too many wrong tries the lock screen says to wait', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
        child: const MyApp(),
      ),
    );
    for (var i = 0; i < 20 && find.text(l10n.pickYourName).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.tap(find.text('أحمد'));
    await tester.pump(const Duration(milliseconds: 100));
    for (var t = 0; t < freeTries; t++) {
      for (final d in '9999'.split('')) {
        await tester.tap(find.byKey(Key('pin-key-$d')));
        await tester.pump(const Duration(milliseconds: 50));
      }
    }
    expect(find.text(l10n.pinLockedOut(l10n.lessThanMinute)), findsOneWidget);
    expect(find.text(l10n.wrongPin), findsNothing);
  });

  testWidgets('the PIN can be typed on the keyboard too', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
        child: const MyApp(),
      ),
    );
    for (var i = 0; i < 20 && find.text(l10n.pickYourName).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.tap(find.text('أحمد'));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.sendKeyEvent(LogicalKeyboardKey.digit9);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit9);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace); // typed so far: 9
    await tester.sendKeyEvent(LogicalKeyboardKey.digit9);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit9);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit9); // 9999
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text(l10n.wrongPin), findsOneWidget); // 9999 is wrong

    for (final key in [
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.numpad1,
      LogicalKeyboardKey.numpad1,
    ]) {
      await tester.sendKeyEvent(key);
    }
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(sampleVenueName), findsOneWidget); // 1111 is right
    expect(tester.takeException(), isNull);
  });
}
