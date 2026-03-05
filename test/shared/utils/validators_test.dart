import 'package:bizzie/shared/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('validateNotEmpty', () {
      test('validateNotEmpty_nullValue_returnsError', () {
        // ARRANGE
        const String? input = null;
        const error = 'Field is required';

        // ACT
        final result = Validators.validateNotEmpty(input, error);

        // ASSERT
        expect(result, error);
      });

      test('validateNotEmpty_emptyString_returnsError', () {
        // ARRANGE
        const input = '';
        const error = 'Field is required';

        // ACT
        final result = Validators.validateNotEmpty(input, error);

        // ASSERT
        expect(result, error);
      });

      test('validateNotEmpty_whitespaceOnly_returnsError', () {
        // ARRANGE
        const input = '   ';
        const error = 'Field is required';

        // ACT
        final result = Validators.validateNotEmpty(input, error);

        // ASSERT
        expect(result, error);
      });

      test('validateNotEmpty_validValue_returnsNull', () {
        // ARRANGE
        const input = 'Something';
        const error = 'Field is required';

        // ACT
        final result = Validators.validateNotEmpty(input, error);

        // ASSERT
        expect(result, isNull);
      });
    });

    group('validateName', () {
      test('validateName_nullValue_returnsError', () {
        // ARRANGE
        const String? input = null;

        // ACT
        final result = Validators.validateName(input);

        // ASSERT
        expect(result, 'Name cannot be empty');
      });

      test('validateName_emptyString_returnsError', () {
        // ARRANGE
        const input = '';

        // ACT
        final result = Validators.validateName(input);

        // ASSERT
        expect(result, 'Name cannot be empty');
      });

      test('validateName_whitespaceOnly_returnsError', () {
        // ARRANGE
        const input = '   ';

        // ACT
        final result = Validators.validateName(input);

        // ASSERT
        expect(result, 'Name cannot be empty');
      });

      test('validateName_validName_returnsNull', () {
        // ARRANGE
        const input = 'John';

        // ACT
        final result = Validators.validateName(input);

        // ASSERT
        expect(result, isNull);
      });
    });

    group('validateEmail', () {
      test('validateEmail_nullValue_returnsError', () {
        // ARRANGE
        const String? input = null;

        // ACT
        final result = Validators.validateEmail(input);

        // ASSERT
        expect(result, 'Please enter your email');
      });

      test('validateEmail_emptyString_returnsError', () {
        // ARRANGE
        const input = '';

        // ACT
        final result = Validators.validateEmail(input);

        // ASSERT
        expect(result, 'Please enter your email');
      });

      test('validateEmail_invalidFormat_returnsError', () {
        // ARRANGE
        const input = 'invalid';

        // ACT
        final result = Validators.validateEmail(input);

        // ASSERT
        expect(result, 'Please enter a valid email');
      });

      test('validateEmail_validEmail_returnsNull', () {
        // ARRANGE
        const input = 'test@example.com';

        // ACT
        final result = Validators.validateEmail(input);

        // ASSERT
        expect(result, isNull);
      });
    });

    group('validatePassword', () {
      test('validatePassword_nullValue_returnsError', () {
        // ARRANGE
        const String? input = null;

        // ACT
        final result = Validators.validatePassword(input);

        // ASSERT
        expect(result, 'Please enter a password');
      });

      test('validatePassword_tooShortDefault_returnsError', () {
        // ARRANGE
        const input = '1234567';

        // ACT
        final result = Validators.validatePassword(input);

        // ASSERT
        expect(result, 'Password must be at least 8 characters');
      });

      test('validatePassword_exactMinLength_returnsNull', () {
        // ARRANGE
        const input = '12345678';

        // ACT
        final result = Validators.validatePassword(input);

        // ASSERT
        expect(result, isNull);
      });

      test('validatePassword_aboveMinLength_returnsNull', () {
        // ARRANGE
        const input = 'password123';

        // ACT
        final result = Validators.validatePassword(input);

        // ASSERT
        expect(result, isNull);
      });
    });
  });
}
