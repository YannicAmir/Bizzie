import 'package:bizzie/core/utils/sector_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeSectorKey', () {
    test('normalizeSectorKey_lowercasesInput_returnsLowercase', () {
      // arrange
      const input = 'Information Technology';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, 'informationtechnology');
    });

    test('normalizeSectorKey_removesSpaces_returnsNoSpaces', () {
      // arrange
      const input = 'Consumer Staples';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, 'consumerstaples');
    });

    test('normalizeSectorKey_removesUnderscores_returnsNoUnderscores', () {
      // arrange
      const input = 'real_estate';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, 'realestate');
    });

    test('normalizeSectorKey_trimsWhitespace_returnsTrimmed', () {
      // arrange
      const input = '  Energy  ';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, 'energy');
    });

    test('normalizeSectorKey_emptyString_returnsEmpty', () {
      // arrange
      const input = '';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, '');
    });

    test('normalizeSectorKey_mixedCase_returnsNormalized', () {
      // arrange
      const input = 'CONSUMER_DISCRETIONARY';

      // act
      final result = normalizeSectorKey(input);

      // assert
      expect(result, 'consumerdiscretionary');
    });
  });
}
