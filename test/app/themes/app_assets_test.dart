import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/app/themes/app_assets.dart';

void main() {
  group('AppAssets.getMascotForSector', () {
    test(
      'getMascotForSector_sanitizedUnderscoreInput_returnsCorrectMascot',
      () {
        // arrange
        final sectors = {
          'information_technology': AppAssets.bizzieMascotIT,
          'financials': AppAssets.bizzieMascotFinancials,
          'communication_services': AppAssets.bizzieMascotCommunicationServices,
          'consumer_discretionary': AppAssets.bizzieMascotConsumerDiscretionary,
          'consumer_staples': AppAssets.bizzieMascotConsumerStaples,
          'energy': AppAssets.bizzieMascotEnergy,
          'healthcare': AppAssets.bizzieMascotHealthcare,
          'industrials': AppAssets.bizzieMascotIndustrials,
          'materials': AppAssets.bizzieMascotMaterials,
          'real_estate': AppAssets.bizzieMascotRealEstate,
          'utilities': AppAssets.bizzieMascotUtilities,
        };

        sectors.forEach((input, expected) {
          // act
          final result = AppAssets.getMascotForSector(input);

          // assert
          expect(result, equals(expected), reason: 'Failed for sector: $input');
        });
      },
    );

    test('getMascotForSector_inputWithSpaces_returnsCorrectMascot', () {
      // arrange
      const input1 = 'Information Technology';
      const input2 = 'Consumer Discretionary';

      // act
      final result1 = AppAssets.getMascotForSector(input1);
      final result2 = AppAssets.getMascotForSector(input2);

      // assert
      expect(result1, equals(AppAssets.bizzieMascotIT));
      expect(result2, equals(AppAssets.bizzieMascotConsumerDiscretionary));
    });

    test('getMascotForSector_caseInsensitiveInput_returnsCorrectMascot', () {
      // arrange
      const input1 = 'HEALTHCARE';
      const input2 = 'information_technology';

      // act
      final result1 = AppAssets.getMascotForSector(input1);
      final result2 = AppAssets.getMascotForSector(input2);

      // assert
      expect(result1, equals(AppAssets.bizzieMascotHealthcare));
      expect(result2, equals(AppAssets.bizzieMascotIT));
    });

    test(
      'getMascotForSector_shorthandOrPartialInput_returnsSpecificMascot',
      () {
        // arrange
        const input1 = 'tech';
        const input2 = 'finance';
        const input3 = 'health';

        // act
        final result1 = AppAssets.getMascotForSector(input1);
        final result2 = AppAssets.getMascotForSector(input2);
        final result3 = AppAssets.getMascotForSector(input3);

        // assert
        expect(result1, equals(AppAssets.bizzieMascotIT));
        expect(result2, equals(AppAssets.bizzieMascotFinancials));
        expect(result3, equals(AppAssets.bizzieMascotHealthcare));
      },
    );

    test('getMascotForSector_unknownOrInvalidInput_returnsDefaultMascot', () {
      // arrange
      const input = 'Unknown Sector';

      // act
      final result = AppAssets.getMascotForSector(input);

      // assert
      expect(result, equals(AppAssets.defaultMascot));
    });
  });
}
