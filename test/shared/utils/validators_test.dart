import 'package:bizzie/shared/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('validateNotEmpty', () {
      test('validateNotEmpty_nullValue_returnsError', () {
        // arrange
        const String? input = null;
        const error = 'Field is required';

        // act
        final result = Validators.validateNotEmpty(input, error);

        // assert
        expect(result, error);
      });

      test('validateNotEmpty_emptyString_returnsError', () {
        // arrange
        const input = '';
        const error = 'Field is required';

        // act
        final result = Validators.validateNotEmpty(input, error);

        // assert
        expect(result, error);
      });

      test('validateNotEmpty_whitespaceOnly_returnsError', () {
        // arrange
        const input = '   ';
        const error = 'Field is required';

        // act
        final result = Validators.validateNotEmpty(input, error);

        // assert
        expect(result, error);
      });

      test('validateNotEmpty_validValue_returnsNull', () {
        // arrange
        const input = 'Something';
        const error = 'Field is required';

        // act
        final result = Validators.validateNotEmpty(input, error);

        // assert
        expect(result, isNull);
      });
    });

    group('validateName', () {
      test('validateName_nullValue_returnsError', () {
        // arrange
        const String? input = null;

        // act
        final result = Validators.validateName(input);

        // assert
        expect(result, 'Name cannot be empty');
      });

      test('validateName_emptyString_returnsError', () {
        // arrange
        const input = '';

        // act
        final result = Validators.validateName(input);

        // assert
        expect(result, 'Name cannot be empty');
      });

      test('validateName_whitespaceOnly_returnsError', () {
        // arrange
        const input = '   ';

        // act
        final result = Validators.validateName(input);

        // assert
        expect(result, 'Name cannot be empty');
      });

      test('validateName_validName_returnsNull', () {
        // arrange
        const input = 'John';

        // act
        final result = Validators.validateName(input);

        // assert
        expect(result, isNull);
      });
    });

    group('validateEmail', () {
      test('validateEmail_nullValue_returnsError', () {
        // arrange
        const String? input = null;

        // act
        final result = Validators.validateEmail(input);

        // assert
        expect(result, 'Please enter your email');
      });

      test('validateEmail_emptyString_returnsError', () {
        // arrange
        const input = '';

        // act
        final result = Validators.validateEmail(input);

        // assert
        expect(result, 'Please enter your email');
      });

      test('validateEmail_invalidFormat_returnsError', () {
        // arrange
        const input = 'invalid';

        // act
        final result = Validators.validateEmail(input);

        // assert
        expect(result, 'Please enter a valid email');
      });

      test('validateEmail_validEmail_returnsNull', () {
        // arrange
        const input = 'test@example.com';

        // act
        final result = Validators.validateEmail(input);

        // assert
        expect(result, isNull);
      });
    });

    group('validatePassword', () {
      test('validatePassword_nullValue_returnsError', () {
        // arrange
        const String? input = null;

        // act
        final result = Validators.validatePassword(input);

        // assert
        expect(result, 'Please enter a password');
      });

      test('validatePassword_tooShortDefault_returnsError', () {
        // arrange
        const input = '1234567';

        // act
        final result = Validators.validatePassword(input);

        // assert
        expect(result, 'Password must be at least 8 characters');
      });

      test('validatePassword_exactMinLength_returnsNull', () {
        // arrange
        const input = '12345678';

        // act
        final result = Validators.validatePassword(input);

        // assert
        expect(result, isNull);
      });

      test('validatePassword_aboveMinLength_returnsNull', () {
        // arrange
        const input = 'password123';

        // act
        final result = Validators.validatePassword(input);

        // assert
        expect(result, isNull);
      });
    });
  });
}
