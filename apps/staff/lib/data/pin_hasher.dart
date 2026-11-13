import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Turns a PIN into text that is safe to store, and checks a typed PIN against it.
///
/// What is stored looks like `pbkdf2-sha256$10000$<salt>$<hash>`:
///  - the salt is random per person, so two people with the same PIN have different hashes;
///  - PBKDF2 repeats the hashing [iterations] times, so every guess costs the same many rounds;
///  - the number of rounds is stored too, so it can be raised later and old hashes still check.
///
/// Be honest about what this protects. A PIN has only 10,000 possible values (0000 to 9999), so
/// whoever copies the database file can still try them all offline. The hash only stops a stolen
/// file from showing the PINs at a glance; the real protection is the lockout after wrong tries
/// (see CurrentStaffNotifier) and the file staying on the shop's computer.
class PinHasher {
  const PinHasher({this.iterations = defaultIterations});

  static const defaultIterations = 10000;
  static const _scheme = 'pbkdf2-sha256';

  final int iterations;

  /// The text to store for [pin]. [salt] is only for tests; leave it out to get a random one.
  String hash(String pin, {List<int>? salt}) {
    final s = salt ?? _randomSalt();
    final key = _pbkdf2(utf8.encode(pin), s, iterations);
    return '$_scheme\$$iterations\$${base64.encode(s)}\$${base64.encode(key)}';
  }

  /// True when [pin] is the one [stored] was made from. Anything that is not a hash we made
  /// (an empty or damaged value) is never a match.
  static bool verify(String pin, String stored) {
    final parts = stored.split(r'$');
    if (parts.length != 4 || parts[0] != _scheme) return false;
    final rounds = int.tryParse(parts[1]);
    if (rounds == null || rounds < 1) return false;
    final List<int> salt, expected;
    try {
      salt = base64.decode(parts[2]);
      expected = base64.decode(parts[3]);
    } on FormatException {
      return false;
    }
    final actual = _pbkdf2(utf8.encode(pin), salt, rounds);
    return _sameBytes(actual, expected);
  }

  static List<int> _randomSalt() {
    final random = Random.secure();
    return List<int>.generate(16, (_) => random.nextInt(256));
  }

  /// PBKDF2 with HMAC-SHA256, one 32-byte block (RFC 8018).
  static List<int> _pbkdf2(List<int> password, List<int> salt, int rounds) {
    final hmac = Hmac(sha256, password);
    var u = hmac.convert([...salt, 0, 0, 0, 1]).bytes;
    final result = List<int>.of(u);
    for (var i = 1; i < rounds; i++) {
      u = hmac.convert(u).bytes;
      for (var j = 0; j < result.length; j++) {
        result[j] ^= u[j];
      }
    }
    return result;
  }

  /// Compares every byte even after a difference, so the time taken does not tell how close a guess was.
  static bool _sameBytes(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
