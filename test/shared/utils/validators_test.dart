import 'package:bizzie/shared/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('validateEmail_returnsErrorOnInvalid', () {
      expect(Validators.validateEmail(''), 'Please enter your email');
      expect(Validators.validateEmail('invalid'), 'Please enter a valid email');
      expect(Validators.validateEmail('test@'), 'Please enter a valid email');
    });

    test('validateEmail_returnsNullOnValid', () {
      expect(Validators.validateEmail('test@example.com'), null);
      expect(Validators.validateEmail('user.name@domain.co.uk'), null);
    });

    test('validatePassword_returnsErrorOnShort', () {
      expect(Validators.validatePassword(''), 'Please enter a password');
      expect(
        Validators.validatePassword('12345'),
        'Password must be at least 6 characters',
      );
    });

    test('validatePassword_returnsNullOnValid', () {
      expect(Validators.validatePassword('123456'), null);
      expect(Validators.validatePassword('password123'), null);
    });
  });
}
