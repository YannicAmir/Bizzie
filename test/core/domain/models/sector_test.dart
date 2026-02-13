import 'package:bizzie/core/domain/models/sector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sector', () {
    group('displayName', () {
      test('energy_getDisplayName_returnsCorrectString', () {
        // arrange
        const sector = Sector.energy;

        // act
        final displayName = sector.displayName;

        // assert
        expect(displayName, 'Energy');
      });

      test('informationTechnology_getDisplayName_returnsCorrectString', () {
        // arrange
        const sector = Sector.informationTechnology;

        // act
        final displayName = sector.displayName;

        // assert
        expect(displayName, 'Information Technology');
      });

      test('industrials_getDisplayName_returnsCorrectString', () {
        // arrange
        const sector = Sector.industrials;

        // act
        final displayName = sector.displayName;

        // assert
        expect(displayName, 'Industrials');
      });
    });

    group('fromString', () {
      test('validConcatenatedString_fromString_returnsCorrectSector', () {
        // arrange
        const value = 'informationtechnology';

        // act
        final result = Sector.fromString(value);

        // assert
        expect(result, Sector.informationTechnology);
      });

      test('validStringWithSpaces_fromString_returnsCorrectSector', () {
        // arrange
        const value = 'Information Technology';

        // act
        final result = Sector.fromString(value);

        // assert
        expect(result, Sector.informationTechnology);
      });

      test('validStringWithUnderscores_fromString_returnsCorrectSector', () {
        // arrange
        const value = 'information_technology';

        // act
        final result = Sector.fromString(value);

        // assert
        expect(result, Sector.informationTechnology);
      });

      test('invalidString_fromString_returnsNull', () {
        // arrange
        const value = 'invalid_sector';

        // act
        final result = Sector.fromString(value);

        // assert
        expect(result, isNull);
      });
    });
  });
}
