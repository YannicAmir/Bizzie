import 'dart:math';

import 'package:injectable/injectable.dart';

const _guestUsernamePrefix = 'user';
const _guestUsernameSuffixLength = 10;
const _guestUsernameAlphabet = 'abcdefghijklmnopqrstuvwxyz0123456789';

@lazySingleton
class GuestUsernameGenerator {
  final Random _random = Random.secure();

  String resolveName(String firstName) =>
      firstName.trim().isNotEmpty ? firstName : generate();

  String generate() {
    final buffer = StringBuffer(_guestUsernamePrefix);
    for (var i = 0; i < _guestUsernameSuffixLength; i++) {
      buffer.write(
        _guestUsernameAlphabet[_random.nextInt(_guestUsernameAlphabet.length)],
      );
    }
    return buffer.toString();
  }
}
