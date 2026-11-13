import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shop_info.dart';
import 'setup_screen.dart';

/// Shows the first-run setup until the shop exists; after that, the app.
class SetupGate extends ConsumerWidget {
  const SetupGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopExists = ref.watch(shopInfoProvider) != null;
    return shopExists ? child : const SetupScreen();
  }
}
