import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GuestUsernameGenerator sut;

  setUp(() {
    sut = GuestUsernameGenerator();
  });

  group('GuestUsernameGenerator', () {
    group('generate', () {
      test(
        'generate_called_returnsUserPrefixWithTenLowercaseAlphanumerics',
        () {
          // arrange
          final tPattern = RegExp(r'^user[a-z0-9]{10}$');

          // act
          final result = sut.generate();

          // assert
          expect(result, matches(tPattern));
        },
      );

      test('generate_calledRepeatedly_returnsDistinctValues', () {
        // arrange
        const tSampleSize = 50;

        // act
        final results = List.generate(tSampleSize, (_) => sut.generate());

        // assert
        expect(results.toSet().length, tSampleSize);
      });

      test('generate_calledManyTimes_everyValueMatchesFormat', () {
        // arrange
        final tPattern = RegExp(r'^user[a-z0-9]{10}$');
        const tIterations = 5000;

        // act
        final results = List.generate(tIterations, (_) => sut.generate());

        // assert
        expect(results, everyElement(matches(tPattern)));
      });
    });

    group('resolveName', () {
      test('resolveName_typedName_returnsTypedName', () {
        // arrange
        const tName = 'Jane';

        // act
        final result = sut.resolveName(tName);

        // assert
        expect(result, tName);
      });

      test('resolveName_emptyName_returnsGeneratedUsername', () {
        // arrange
        final tPattern = RegExp(r'^user[a-z0-9]{10}$');

        // act
        final result = sut.resolveName('');

        // assert
        expect(result, matches(tPattern));
      });

      test('resolveName_whitespaceName_returnsGeneratedUsername', () {
        // arrange
        final tPattern = RegExp(r'^user[a-z0-9]{10}$');

        // act
        final result = sut.resolveName('   ');

        // assert
        expect(result, matches(tPattern));
      });
    });
  });
}
