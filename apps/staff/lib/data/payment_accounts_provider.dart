import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bill.dart';
import 'payment_account.dart';
import 'shop_info.dart';

/// Where customers pay, per method: the shop's own accounts (Settings). Checkout shows a QR for these.
/// A method without an entry (cash, or an account not filled in yet) shows nothing extra.
final paymentAccountsProvider = Provider<Map<PaymentMethod, PaymentAccount>>((ref) {
  final shop = ref.watch(shopInfoProvider);
  return {
    if (shop?.instapay != null) PaymentMethod.instapay: shop!.instapay!,
    if (shop?.wallet != null) PaymentMethod.wallet: shop!.wallet!,
  };
});
