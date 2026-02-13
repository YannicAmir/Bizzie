import 'package:bizzie/core/utils/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringCaseExtension', () {
    group('toTitleCase', () {
      test(
        'lowerCaseUnderScoreString_toTitleCase_returnsProperlyCapitalizedSpaceString',
        () {
          // arrange
          const value = 'hello_world';

          // act
          final result = value.toTitleCase();

          // assert
          expect(result, 'Hello World');
        },
      );

      test('emptyString_toTitleCase_returnsEmptyString', () {
        // arrange
        const value = '';

        // act
        final result = value.toTitleCase();

        // assert
        expect(result, '');
      });
    });

    group('formatAsSector', () {
      test(
        'concatenatedSectorString_formatAsSector_returnsProperlySpacedDisplayName',
        () {
          // arrange
          const value = 'informationtechnology';

          // act
          final result = value.formatAsSector();

          // assert
          expect(result, 'Information Technology');
        },
      );

      test(
        'spacedSectorString_formatAsSector_returnsProperlySpacedDisplayName',
        () {
          // arrange
          const value = 'Information Technology';

          // act
          final result = value.formatAsSector();

          // assert
          expect(result, 'Information Technology');
        },
      );

      test('nonSectorUnderscoreString_formatAsSector_fallsBackToTitleCase', () {
        // arrange
        const value = 'not_a_sector';

        // act
        final result = value.formatAsSector();

        // assert
        expect(result, 'Not A Sector');
      });

      test('emptyString_formatAsSector_returnsEmptyString', () {
        // arrange
        const value = '';

        // act
        final result = value.formatAsSector();

        // assert
        expect(result, '');
      });
    });
  });
}
