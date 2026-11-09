import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/staff_provider.dart';
import 'lock_screen.dart';

/// Shows the app only while someone is signed in; otherwise the "who is working?" screen.
/// The session alerts sit outside this gate, so a timer that ends still rings behind the lock.
class StaffGate extends ConsumerWidget {
  const StaffGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedIn = ref.watch(currentStaffIdProvider) != null;
    return signedIn ? child : const LockScreen();
  }
}
