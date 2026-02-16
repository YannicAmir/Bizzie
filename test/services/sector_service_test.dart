import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/services/sector_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late SectorService service;
  late MockConfigService mockConfigService;

  setUp(() {
    mockConfigService = MockConfigService();
    service = SectorService(mockConfigService);
  });

  group('SectorService', () {
    const tSectorName = 'Information Technology';
    const tDescription = 'Tech sector description';
    const tSectorDescriptions = {
      'Information Technology': tDescription,
      'Energy': 'Energy description',
    };

    group('getSectorDescription', () {
      test('getSectorDescription_matchFound_returnsDescription', () {
        // arrange
        when(
          () => mockConfigService.sectorDescriptions,
        ).thenReturn(tSectorDescriptions);

        // act
        final result = service.getSectorDescription(tSectorName);

        // assert
        expect(result, tDescription);
      });

      test('getSectorDescription_noDescription_returnsEmptyString', () {
        // arrange
        when(() => mockConfigService.sectorDescriptions).thenReturn({});

        // act
        final result = service.getSectorDescription('Unknown');

        // assert
        expect(result, '');
      });
    });

    group('getSectorDisplayName', () {
      test('getSectorDisplayName_exactMatch_returnsKey', () {
        // arrange
        when(
          () => mockConfigService.sectorDescriptions,
        ).thenReturn(tSectorDescriptions);

        // act
        final result = service.getSectorDisplayName(tSectorName);

        // assert
        expect(result, tSectorName);
      });

      test('getSectorDisplayName_normalizedMatch_returnsCorrectKey', () {
        // arrange
        when(
          () => mockConfigService.sectorDescriptions,
        ).thenReturn(tSectorDescriptions);

        // act
        final result = service.getSectorDisplayName('information technology');

        // assert
        expect(result, 'Information Technology');
      });

      test('getSectorDisplayName_noMatch_returnsFormattedInput', () {
        // arrange
        when(() => mockConfigService.sectorDescriptions).thenReturn({});

        // act
        final result = service.getSectorDisplayName('unknown_sector');

        // assert
        expect(result, 'Unknown Sector');
      });
    });

    group('getSectorApiName', () {
      test('getSectorApiName_hasAlias_returnsAlias', () {
        // act
        final result = service.getSectorApiName('Information Technology');

        // assert
        expect(result, 'Technology');
      });

      test('getSectorApiName_noAlias_returnsOriginal', () {
        // act
        final result = service.getSectorApiName('Custom Sector');

        // assert
        expect(result, 'Custom Sector');
      });
    });

    group('stockMarketSectors', () {
      test('stockMarketSectors_returnsFromConfigService_isCorrect', () {
        // arrange
        final tSectors = ['Tech', 'Health'];
        when(() => mockConfigService.stockMarketSectors).thenReturn(tSectors);

        // act
        final result = service.stockMarketSectors;

        // assert
        expect(result, tSectors);
      });
    });
  });
}
