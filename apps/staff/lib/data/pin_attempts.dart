import 'package:flutter_riverpod/flutter_riverpod.dart';

/// How many wrong PINs a person has typed in a row, and until when they are locked out.
/// Kept in the shop PC's database (never synced), so closing the app does not reset it.
class PinAttempts {
  const PinAttempts({this.wrong = 0, this.lockedUntil});

  final int wrong;
  final DateTime? lockedUntil;

  @override
  bool operator ==(Object other) => other is PinAttempts && other.wrong == wrong && other.lockedUntil == lockedUntil;

  @override
  int get hashCode => Object.hash(wrong, lockedUntil);
}

/// The saved counts by staff id, read once at startup. Tests leave it empty.
final initialPinAttemptsProvider = Provider<Map<String, PinAttempts>>((ref) => const {});

/// Saves one person's count. Null in tests (nothing is saved). The app sets it to the database.
final pinAttemptsSaverProvider = Provider<void Function(String staffId, PinAttempts attempts)?>((ref) => null);
