import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_log.dart';
import 'payment_account.dart';
import 'sample_data.dart';

/// The shop this computer runs: its id, name and phone, and where customers pay. The id is made here, on the
/// computer, at the first-run setup (a UUID, like every id, decision #1). The backend keeps it when the shop is
/// registered.
class ShopInfo {
  const ShopInfo({required this.id, required this.name, this.phone = '', this.instapay, this.wallet});

  final String id;
  final String name;
  final String phone;

  /// Where customers pay by InstaPay or wallet (checkout draws a QR from the link). Null = not set up: checkout
  /// shows no QR for that method.
  final PaymentAccount? instapay;
  final PaymentAccount? wallet;

  ShopInfo withAccounts({PaymentAccount? instapay, PaymentAccount? wallet}) =>
      ShopInfo(id: id, name: name, phone: phone, instapay: instapay, wallet: wallet);

  @override
  bool operator ==(Object other) =>
      other is ShopInfo &&
      other.id == id &&
      other.name == name &&
      other.phone == phone &&
      other.instapay == instapay &&
      other.wallet == wallet;

  @override
  int get hashCode => Object.hash(id, name, phone, instapay, wallet);
}

/// The shop at startup. Null means the first-run setup has not been done yet. Tests start with the sample shop.
final initialShopInfoProvider = Provider<ShopInfo?>(
  (ref) => const ShopInfo(id: 'sample-shop', name: sampleVenueName, instapay: sampleInstapay, wallet: sampleWallet),
);

class ShopInfoNotifier extends Notifier<ShopInfo?> {
  @override
  ShopInfo? build() => ref.read(initialShopInfoProvider);

  void set(ShopInfo info) => state = info;

  /// Changes where customers pay. Whoever controls these controls where the money goes, so every change is
  /// written to the activity log and flagged for the owner (one line per method that changed).
  void setPaymentAccounts({PaymentAccount? instapay, PaymentAccount? wallet}) {
    final shop = state;
    if (shop == null) return;
    final log = ref.read(activityLogProvider.notifier);
    void note(String method, PaymentAccount? before, PaymentAccount? after) {
      if (before == after) return;
      log.record(
        after == null ? ActivityKind.paymentAccountRemoved : ActivityKind.paymentAccountChanged,
        suspicious: true,
        details: {'method': method},
      );
    }

    note('instapay', shop.instapay, instapay);
    note('wallet', shop.wallet, wallet);
    state = shop.withAccounts(instapay: instapay, wallet: wallet);
  }
}

final shopInfoProvider = NotifierProvider<ShopInfoNotifier, ShopInfo?>(ShopInfoNotifier.new);
