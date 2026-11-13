import 'dart:convert';

import 'package:al3b_staff/data/pin_hasher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const hasher = PinHasher(iterations: 5); // few rounds: the maths is the same, the test is fast

  test('the right PIN matches and a wrong one does not', () {
    final stored = hasher.hash('4821');
    expect(PinHasher.verify('4821', stored), isTrue);
    expect(PinHasher.verify('4822', stored), isFalse);
    expect(PinHasher.verify('', stored), isFalse);
  });

  test('the stored text never contains the PIN', () {
    expect(hasher.hash('4821'), isNot(contains('4821')));
  });

  test('two hashes of the same PIN differ (random salt), and both still verify', () {
    final a = hasher.hash('1111');
    final b = hasher.hash('1111');
    expect(a, isNot(b));
    expect(PinHasher.verify('1111', a), isTrue);
    expect(PinHasher.verify('1111', b), isTrue);
  });

  test('PBKDF2-HMAC-SHA256 gives the published test vector (RFC 7914, 1 round)', () {
    // password "passwd", salt "salt", 1 round, first 32 bytes: 55ac046e56e3089fec1691c22544b605f94185216dde0465e68b9d57c20dacbc
    final stored = const PinHasher(iterations: 1).hash('passwd', salt: 'salt'.codeUnits);
    final hashPart = stored.split(r'$').last;
    expect(_hex(hashPart), '55ac046e56e3089fec1691c22544b605f94185216dde0465e68b9d57c20dacbc');
  });

  test('the number of rounds is stored, so a hash made with more rounds still verifies', () {
    final stored = const PinHasher(iterations: 20).hash('0000');
    expect(stored.split(r'$')[1], '20');
    expect(PinHasher.verify('0000', stored), isTrue);
  });

  test('damaged or empty stored values never match', () {
    for (final bad in ['', 'x', 'pbkdf2-sha256\$5\$abc', 'md5\$5\$AAAA\$AAAA', 'pbkdf2-sha256\$0\$AAAA\$AAAA', 'pbkdf2-sha256\$5\$!!!\$!!!']) {
      expect(PinHasher.verify('1234', bad), isFalse, reason: bad);
    }
  });
}

String _hex(String base64Text) => base64Decode(base64Text).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
