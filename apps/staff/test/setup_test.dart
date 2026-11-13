import 'package:al3b_staff/data/expense_categories_provider.dart';
import 'package:al3b_staff/data/preferences_provider.dart';
import 'package:al3b_staff/data/shop_info.dart';
import 'package:al3b_staff/data/shop_setup.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/data/units_provider.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:al3b_staff/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final l10n = AppLocalizationsAr();

  test('a mobile number is 11 digits and starts with 010, 011, 012 or 015', () {
    expect(isEgyptianMobile('01012345678'), isTrue);
    expect(isEgyptianMobile('01512345678'), isTrue);
    expect(isEgyptianMobile('01312345678'), isFalse);
    expect(isEgyptianMobile('0101234567'), isFalse); // too short
    expect(isEgyptianMobile('010123456789'), isFalse); // too long
    expect(isEgyptianMobile('+201012345678'), isFalse);
  });

  test('a PIN is exactly four digits', () {
    expect(isValidPin('0000'), isTrue);
    expect(isValidPin('123'), isFalse);
    expect(isValidPin('12345'), isFalse);
    expect(isValidPin('12a4'), isFalse);
  });

  testWidgets('a new shop starts with the setup; finishing it opens the empty Floor as the owner', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => prefs),
          initialShopInfoProvider.overrideWith((ref) => null),
          initialStaffProvider.overrideWith((ref) => []),
          initialExpenseCategoriesProvider.overrideWith((ref) => []),
          initialUnitsProvider.overrideWith((ref) => []),
        ],
        child: const MyApp(),
      ),
    );
    for (var i = 0; i < 20 && find.text(l10n.setupTitle).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text(l10n.setupTitle), findsOneWidget);

    FilledButton button() => tester.widget<FilledButton>(find.byKey(const Key('setup-start')));
    Future<void> type(int field, String text) async {
      await tester.enterText(find.byType(TextField).at(field), text);
      await tester.pump();
    }

    expect(button().onPressed, isNull); // nothing typed yet

    await type(0, 'الأسطورة');
    await type(1, 'مازن');
    await type(2, '01012345678');
    await type(3, '4821');
    await type(4, '4822');
    expect(find.text(l10n.pinMismatch), findsOneWidget);
    expect(button().onPressed, isNull);

    await type(2, '01312345678'); // a number that is not a mobile
    expect(find.text(l10n.phoneInvalid), findsOneWidget);
    expect(button().onPressed, isNull);

    await type(2, '01012345678');
    await type(4, '4821');
    expect(find.text(l10n.pinMismatch), findsNothing);
    expect(find.text(l10n.phoneInvalid), findsNothing);
    expect(button().onPressed, isNotNull);

    await tester.ensureVisible(find.byKey(const Key('setup-start')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('setup-start')));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('الأسطورة'), findsOneWidget); // the Floor header shows the shop's name
    expect(find.text(l10n.emptyFloorTitle), findsOneWidget);
    expect(find.text(l10n.pickYourName), findsNothing); // the owner is already signed in
    expect(tester.takeException(), isNull);
  });
}
