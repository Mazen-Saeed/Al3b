import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/input_rules.dart';
import '../data/payment_account.dart';
import '../data/shop_info.dart';
import '../l10n/l10n.dart';

/// Settings > Payment accounts (Admins): where customers pay by InstaPay and wallet. Checkout draws a QR from
/// each link. Empty = no QR for that method.
class PaymentAccountsSection extends ConsumerStatefulWidget {
  const PaymentAccountsSection({super.key});

  @override
  ConsumerState<PaymentAccountsSection> createState() => _PaymentAccountsSectionState();
}

class _PaymentAccountsSectionState extends ConsumerState<PaymentAccountsSection> {
  late final _instapayLink = TextEditingController(text: _shop?.instapay?.link);
  late final _instapayHandle = TextEditingController(text: _shop?.instapay?.handle);
  late final _instapayPhone = TextEditingController(text: _shop?.instapay?.phone);
  late final _walletLink = TextEditingController(text: _shop?.wallet?.link);
  late final _walletPhone = TextEditingController(text: _shop?.wallet?.phone);
  bool _tried = false; // errors only show after the first press of Save

  ShopInfo? get _shop => ref.read(shopInfoProvider);

  @override
  void dispose() {
    for (final c in [_instapayLink, _instapayHandle, _instapayPhone, _walletLink, _walletPhone]) {
      c.dispose();
    }
    super.dispose();
  }

  static String? _clean(TextEditingController c) {
    final text = c.text.trim();
    return text.isEmpty ? null : text;
  }

  bool _linkOk(String? link) => link == null || link.startsWith('https://') || link.startsWith('http://');
  bool _phoneOk(String? phone) => phone == null || isEgyptianMobile(phone);

  /// What the form says, or null for an account that is left empty. Never both a half-filled one.
  PaymentAccount? _account(TextEditingController link, TextEditingController? handle, TextEditingController phone) {
    final l = _clean(link);
    if (l == null) return null;
    return PaymentAccount(link: l, handle: handle == null ? null : _clean(handle), phone: _clean(phone));
  }

  /// A link is required as soon as anything else of that account is filled in.
  bool _missingLink(TextEditingController link, List<TextEditingController> others) =>
      _clean(link) == null && others.any((c) => _clean(c) != null);

  bool get _valid =>
      _linkOk(_clean(_instapayLink)) &&
      _linkOk(_clean(_walletLink)) &&
      _phoneOk(_clean(_instapayPhone)) &&
      _phoneOk(_clean(_walletPhone)) &&
      !_missingLink(_instapayLink, [_instapayHandle, _instapayPhone]) &&
      !_missingLink(_walletLink, [_walletPhone]);

  void _save() {
    setState(() => _tried = true);
    if (!_valid) return;
    ref.read(shopInfoProvider.notifier).setPaymentAccounts(
          instapay: _account(_instapayLink, _instapayHandle, _instapayPhone),
          wallet: _account(_walletLink, null, _walletPhone),
        );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.paymentSaved)));
  }

  String? _linkError(TextEditingController link, List<TextEditingController> others) {
    if (!_tried) return null;
    final l10n = context.l10n;
    if (_missingLink(link, others)) return l10n.linkRequired;
    return _linkOk(_clean(link)) ? null : l10n.linkInvalid;
  }

  String? _phoneError(TextEditingController phone) => _tried && !_phoneOk(_clean(phone)) ? context.l10n.phoneInvalid : null;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget field(String key, TextEditingController c, String label, {String? error, bool ltr = false}) => Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 10),
          child: TextField(
            key: Key(key),
            controller: c,
            textDirection: ltr ? TextDirection.ltr : null,
            decoration: InputDecoration(labelText: label, errorText: error),
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.paymentAccountsTitle, style: AppText.sectionTitle),
        const SizedBox(height: 6),
        Text(l10n.paymentAccountsHelp, style: AppText.small),
        const SizedBox(height: 14),
        Text(l10n.payInstapay, style: AppText.label),
        const SizedBox(height: 8),
        field('instapay-link', _instapayLink, l10n.paymentLinkLabel,
            ltr: true, error: _linkError(_instapayLink, [_instapayHandle, _instapayPhone])),
        field('instapay-handle', _instapayHandle, l10n.instapayHandleLabel, ltr: true),
        field('instapay-phone', _instapayPhone, l10n.paymentPhoneLabel, ltr: true, error: _phoneError(_instapayPhone)),
        const SizedBox(height: 6),
        Text(l10n.payWallet, style: AppText.label),
        const SizedBox(height: 8),
        field('wallet-link', _walletLink, l10n.paymentLinkLabel, ltr: true, error: _linkError(_walletLink, [_walletPhone])),
        field('wallet-phone', _walletPhone, l10n.paymentPhoneLabel, ltr: true, error: _phoneError(_walletPhone)),
        const SizedBox(height: 6),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton(key: const Key('payment-save'), onPressed: _save, child: Text(l10n.save)),
        ),
      ],
    );
  }
}
