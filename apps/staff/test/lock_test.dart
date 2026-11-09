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

      expect(notifier.unlock('staff-2', '0000'), isFalse);
      expect(container.read(currentStaffIdProvider), isNull);

      expect(notifier.unlock('staff-2', '1111'), isTrue);
      expect(container.read(currentStaffProvider)?.name, 'أحمد');

      notifier.lock();
      expect(container.read(currentStaffProvider), isNull);
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
