import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

const _showExpectedKey = 'showExpectedCash';

/// Shop setting: may the cashier see how much should be in the cash box while it is open?
/// Off by default (a blind count). Admins always see it. Saved on this device for now; it will
/// become a shop setting that syncs (#38).
class ShowExpectedCashNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_showExpectedKey) ?? false;

  void set(bool value) {
    state = value;
    unawaited(ref.read(sharedPreferencesProvider).setBool(_showExpectedKey, value));
  }
}

final showExpectedCashProvider = NotifierProvider<ShowExpectedCashNotifier, bool>(ShowExpectedCashNotifier.new);
