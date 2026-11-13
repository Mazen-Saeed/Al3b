import 'package:al3b_staff/data/activity_log.dart';
import 'package:al3b_staff/data/bill.dart';
import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/shop_repository.dart';
import 'package:al3b_staff/data/payment_account.dart';
import 'package:al3b_staff/data/payment_accounts_provider.dart';
import 'package:al3b_staff/data/shop_info.dart';
import 'package:al3b_staff/data/staff_provider.dart';
import 'package:al3b_staff/data/unit_type.dart';
import 'package:al3b_staff/l10n/arb/app_localizations.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:al3b_staff/settings/payment_accounts_section.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  const instapay = PaymentAccount(link: 'https://ipn.eg/S/abc', handle: 'abc@instapay', phone: '01012345678');
  const wallet = PaymentAccount(link: 'https://vf.eg/x', phone: '01112345678');

  ProviderContainer shopWith(ShopInfo? info) {
    final c = ProviderContainer(overrides: [
      initialShopInfoProvider.overrideWith((ref) => info),
      initialSignedInProvider.overrideWith((ref) => 'staff-1'),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  test('a shop with no accounts shows no QR for any method', () {
    final c = shopWith(const ShopInfo(id: 'v1', name: 'x'));
    expect(c.read(paymentAccountsProvider), isEmpty);
  });

  test('the accounts come from the shop, per method', () {
    final c = shopWith(const ShopInfo(id: 'v1', name: 'x', instapay: instapay));
    expect(c.read(paymentAccountsProvider), {PaymentMethod.instapay: instapay});
  });

  test('changing an account is written to the log and flagged, one line per method that changed', () {
    final c = shopWith(const ShopInfo(id: 'v1', name: 'x', instapay: instapay));
    final shop = c.read(shopInfoProvider.notifier);

    shop.setPaymentAccounts(instapay: instapay, wallet: wallet); // only the wallet is new
    final log = c.read(activityLogProvider);
    expect(log.map((e) => (e.kind, e.text('method'), e.suspicious)), [(ActivityKind.paymentAccountChanged, 'wallet', true)]);

    shop.setPaymentAccounts(instapay: instapay, wallet: wallet); // nothing changed: nothing written
    expect(c.read(activityLogProvider).length, 1);

    shop.setPaymentAccounts(wallet: wallet); // InstaPay removed
    expect(c.read(activityLogProvider).last.kind, ActivityKind.paymentAccountRemoved);
    expect(c.read(paymentAccountsProvider).keys, [PaymentMethod.wallet]);
  });

  test('the accounts are saved with the shop and come back after a restart', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = ShopRepository(db, venueId: 'v1');
    ShopData data(ShopInfo info) => ShopData(units: const [], categories: const [], unitTypes: UnitType.defaults, shopInfo: info);

    await repo.save(data(const ShopInfo(id: 'v1', name: 'x', instapay: instapay, wallet: wallet)), staffId: 'staff-1');
    final back = (await ShopRepository(db, venueId: 'v1').load()).shopInfo!;
    expect((back.instapay, back.wallet), (instapay, wallet));

    await repo.save(data(const ShopInfo(id: 'v1', name: 'x')), staffId: 'staff-1'); // both removed
    final empty = (await ShopRepository(db, venueId: 'v1').load()).shopInfo!;
    expect((empty.instapay, empty.wallet), (null, null));
  });

  testWidgets('the Settings form checks the link and the phone, then saves', (tester) async {
    final l10n = AppLocalizationsAr();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialShopInfoProvider.overrideWith((ref) => const ShopInfo(id: 'v1', name: 'x')),
          initialSignedInProvider.overrideWith((ref) => 'staff-1'),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: SingleChildScrollView(child: PaymentAccountsSection())),
        ),
      ),
    );
    final container = ProviderScope.containerOf(tester.element(find.byType(PaymentAccountsSection)));
    Future<void> save() async {
      await tester.ensureVisible(find.byKey(const Key('payment-save')));
      await tester.tap(find.byKey(const Key('payment-save')));
      await tester.pump();
    }

    await tester.enterText(find.byKey(const Key('instapay-link')), 'ipn.eg/abc'); // no https
    await tester.enterText(find.byKey(const Key('wallet-phone')), '0123'); // a phone without a link
    await save();
    expect(find.text(l10n.linkInvalid), findsOneWidget);
    expect(find.text(l10n.linkRequired), findsOneWidget);
    expect(find.text(l10n.phoneInvalid), findsOneWidget);
    expect(container.read(paymentAccountsProvider), isEmpty); // nothing saved

    await tester.enterText(find.byKey(const Key('instapay-link')), 'https://ipn.eg/abc');
    await tester.enterText(find.byKey(const Key('wallet-phone')), '');
    await save();

    expect(container.read(paymentAccountsProvider)[PaymentMethod.instapay]?.link, 'https://ipn.eg/abc');
    expect(container.read(paymentAccountsProvider).containsKey(PaymentMethod.wallet), isFalse);
    expect(container.read(activityLogProvider).single.suspicious, isTrue);
  });
}
