import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/money.dart';
import '../data/shop_setup.dart';
import '../l10n/l10n.dart';

/// The very first screen of a new shop: the owner names the shop, gives their name and phone, and chooses
/// their PIN. Nothing is saved until "ابدأ الشغل"; then the shop, the owner and the expense types are created.
class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _shop = TextEditingController();
  final _owner = TextEditingController();
  final _phone = TextEditingController();
  final _pin = TextEditingController();
  final _pinAgain = TextEditingController();

  @override
  void dispose() {
    for (final c in [_shop, _owner, _phone, _pin, _pinAgain]) {
      c.dispose();
    }
    super.dispose();
  }

  // Arabic digits are accepted too and read as 0-9.
  String get _phoneText => westernDigits(_phone.text).trim();
  String get _pinText => westernDigits(_pin.text).trim();
  String get _pinAgainText => westernDigits(_pinAgain.text).trim();

  bool get _phoneBad => _phoneText.length >= 11 && !isEgyptianMobile(_phoneText);
  bool get _pinsDiffer => isValidPin(_pinText) && _pinAgainText.length >= 4 && _pinText != _pinAgainText;

  bool get _canStart =>
      _shop.text.trim().isNotEmpty &&
      _owner.text.trim().isNotEmpty &&
      isEgyptianMobile(_phoneText) &&
      isValidPin(_pinText) &&
      _pinText == _pinAgainText;

  void _start() {
    if (!_canStart) return;
    ref.read(shopSetupProvider).finish(
          shopName: _shop.text,
          ownerName: _owner.text,
          phone: _phoneText,
          pin: _pinText,
        );
  }

  Widget _field(String label, TextEditingController controller, {bool pin = false, bool phone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: pin,
          keyboardType: pin || phone ? TextInputType.number : TextInputType.text,
          maxLength: pin ? 4 : (phone ? 11 : null),
          inputFormatters: pin || phone ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]'))] : null,
          decoration: const InputDecoration(counterText: ''),
          onChanged: (_) => setState(() {}), // redraw so the button and the hints follow
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.setupTitle, style: AppText.formTitle),
                  const SizedBox(height: 8),
                  Text(l10n.setupIntro, style: AppText.label),
                  const SizedBox(height: 28),
                  _field(l10n.shopNameLabel, _shop),
                  _field(l10n.ownerNameLabel, _owner),
                  _field(l10n.ownerPhoneLabel, _phone, phone: true),
                  if (_phoneBad) ...[
                    Text(l10n.phoneInvalid, style: const TextStyle(color: AppColors.waitingPayment)),
                    const SizedBox(height: 16),
                  ],
                  _field(l10n.pinChooseLabel, _pin, pin: true),
                  _field(l10n.pinRepeatLabel, _pinAgain, pin: true),
                  if (_pinsDiffer) ...[
                    Text(l10n.pinMismatch, style: const TextStyle(color: AppColors.waitingPayment)),
                    const SizedBox(height: 16),
                  ],
                  Text(l10n.pinSetupHint, style: AppText.small),
                  const SizedBox(height: 24),
                  FilledButton(
                    key: const Key('setup-start'),
                    onPressed: _canStart ? _start : null,
                    style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
                    child: Text(l10n.setupStart),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
