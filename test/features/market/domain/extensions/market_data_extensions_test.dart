import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/extensions/market_data_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarketDataExtensions', () {
    group('SectorPeListX', () {
      final tSectorPeList = [
        const SectorPe(
          date: '2023-01-01',
          sector: 'Technology',
          exchange: 'NYSE',
          pe: 25.0,
        ),
        const SectorPe(
          date: '2023-01-01',
          sector: 'Energy',
          exchange: 'NYSE',
          pe: 12.0,
        ),
        const SectorPe(
          date: '2023-01-01',
          sector: 'Consumer Cyclical',
          exchange: 'NYSE',
          pe: 15.0,
        ),
      ];

      test('getPeForSector_exactMatch_returnsCorrectPe', () {
        // arrange
        const tSector = 'Technology';

        // act
        final result = tSectorPeList.getPeForSector(tSector);

        // assert
        expect(result, 25.0);
      });

      test('getPeForSector_caseInsensitiveMatch_returnsCorrectPe', () {
        // arrange
        const tSector = 'technology';

        // act
        final result = tSectorPeList.getPeForSector(tSector);

        // assert
        expect(result, 25.0);
      });

      test('getPeForSector_aliasedSector_returnsCorrectPe', () {
        // arrange
        const tSector = 'information_technology';

        // act
        final result = tSectorPeList.getPeForSector(tSector);

        // assert
        expect(result, 25.0);
      });

      test('getPeForSector_complexNormalization_returnsCorrectPe', () {
        // arrange
        const tSector = '  Information _ Technology  ';

        // act
        final result = tSectorPeList.getPeForSector(tSector);

        // assert
        expect(result, 25.0);
      });

      test('getPeForSector_sectorDoesNotExist_returnsSafeDefault', () {
        // arrange
        const tSector = 'non_existent_sector';

        // act
        final result = tSectorPeList.getPeForSector(tSector);

        // assert
        expect(result, 0.0);
      });

      test('getDateForSector_exactMatch_returnsCorrectDate', () {
        // arrange
        const tSector = 'Energy';

        // act
        final result = tSectorPeList.getDateForSector(tSector);

        // assert
        expect(result, '2023-01-01');
      });

      test('getDateForSector_aliasedSector_returnsCorrectDate', () {
        // arrange
        const tSector = 'healthcare';

        // act
        final result = [
          const SectorPe(
            date: '2023-02-02',
            sector: 'Healthcare',
            exchange: 'NYSE',
            pe: 18.0,
          ),
        ].getDateForSector(tSector);

        // assert
        expect(result, '2023-02-02');
      });

      test('getDateForSector_sectorDoesNotExist_returnsNull', () {
        // arrange
        const tSector = 'Unknown';

        // act
        final result = tSectorPeList.getDateForSector(tSector);

        // assert
        expect(result, isNull);
      });
    });

    group('SectorPerformanceListX', () {
      final tSectorPerformanceList = [
        const SectorPerformance(
          date: '2023-01-01',
          sector: 'Technology',
          exchange: 'NYSE',
          averageChange: 1.5,
        ),
        const SectorPerformance(
          date: '2023-01-01',
          sector: 'Consumer Cyclical',
          exchange: 'NYSE',
          averageChange: -2.3,
        ),
      ];

      test('getAverageChangeForSector_exactMatch_returnsCorrectValue', () {
        // arrange
        const tSector = 'Technology';

        // act
        final result = tSectorPerformanceList.getAverageChangeForSector(
          tSector,
        );

        // assert
        expect(result, 1.5);
      });

      test('getAverageChangeForSector_aliasedSector_returnsCorrectValue', () {
        // arrange
        const tSector = 'consumer_discretionary'; // Alias for Consumer Cyclical

        // act
        final result = tSectorPerformanceList.getAverageChangeForSector(
          tSector,
        );

        // assert
        expect(result, -2.3);
      });

      test('getDateForSector_exactMatch_returnsCorrectDate', () {
        // arrange
        const tSector = 'Technology';

        // act
        final result = tSectorPerformanceList.getDateForSector(tSector);

        // assert
        expect(result, '2023-01-01');
      });

      test('getDateForSector_sectorDoesNotExist_returnsNull', () {
        // arrange
        const tSector = 'invalid';

        // act
        final result = tSectorPerformanceList.getDateForSector(tSector);

        // assert
        expect(result, isNull);
      });
    });

    group('Exhaustive Alias Verification', () {
      final tSectorPeList = [
        const SectorPe(date: 'd', sector: 'Technology', exchange: 'e', pe: 1),
        const SectorPe(
          date: 'd',
          sector: 'Consumer Cyclical',
          exchange: 'e',
          pe: 2,
        ),
        const SectorPe(
          date: 'd',
          sector: 'Consumer Defensive',
          exchange: 'e',
          pe: 3,
        ),
        const SectorPe(
          date: 'd',
          sector: 'Communication Services',
          exchange: 'e',
          pe: 4,
        ),
        const SectorPe(date: 'd', sector: 'Healthcare', exchange: 'e', pe: 5),
        const SectorPe(
          date: 'd',
          sector: 'Financial Services',
          exchange: 'e',
          pe: 6,
        ),
        const SectorPe(
          date: 'd',
          sector: 'Basic Materials',
          exchange: 'e',
          pe: 7,
        ),
        const SectorPe(date: 'd', sector: 'Energy', exchange: 'e', pe: 8),
        const SectorPe(date: 'd', sector: 'Industrials', exchange: 'e', pe: 9),
        const SectorPe(date: 'd', sector: 'Utilities', exchange: 'e', pe: 10),
        const SectorPe(date: 'd', sector: 'Real Estate', exchange: 'e', pe: 11),
      ];

      final aliases = {
        'information_technology': 1.0,
        'CONSUMER_DISCRETIONARY': 2.0,
        'ConsumerStaples': 3.0,
        'telecommunicationservices': 4.0,
        'Healthcare': 5.0,
        'financials': 6.0,
        'materials': 7.0,
        'energy': 8.0,
        'industrials': 9.0,
        'utilities': 10.0,
        'real_estate': 11.0,
      };

      aliases.forEach((alias, expectedPe) {
        test('alias_${alias}_resolvesToCorrectCanonicalSector', () {
          // arrange & act
          final result = tSectorPeList.getPeForSector(alias);

          // assert
          expect(result, expectedPe, reason: 'Failed to resolve alias: $alias');
        });
      });
    });
  });
}
