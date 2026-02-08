import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/extensions/sector_performance_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SectorPerformanceListX', () {
    late List<SectorPerformance> testList;

    setUp(() {
      testList = [
        const SectorPerformance(
          date: '2024-01-15',
          sector: 'Technology',
          exchange: 'NYSE',
          averageChange: 2.5,
        ),
        const SectorPerformance(
          date: '2024-01-15',
          sector: 'Healthcare',
          exchange: 'NYSE',
          averageChange: -1.3,
        ),
        const SectorPerformance(
          date: '2024-01-15',
          sector: 'Financial Services',
          exchange: 'NYSE',
          averageChange: 0.8,
        ),
      ];
    });

    group('getAverageChangeForSector', () {
      test('getAverageChangeForSector_exactMatch_returnsChange', () {
        // arrange
        const sectorApiName = 'Technology';

        // act
        final result = testList.getAverageChangeForSector(sectorApiName);

        // assert
        expect(result, 2.5);
      });

      test('getAverageChangeForSector_caseInsensitiveMatch_returnsChange', () {
        // arrange
        const sectorApiName = 'HEALTHCARE';

        // act
        final result = testList.getAverageChangeForSector(sectorApiName);

        // assert
        expect(result, -1.3);
      });

      test('getAverageChangeForSector_withSpaces_returnsChange', () {
        // arrange
        const sectorApiName = 'Financial Services';

        // act
        final result = testList.getAverageChangeForSector(sectorApiName);

        // assert
        expect(result, 0.8);
      });

      test('getAverageChangeForSector_notFound_returnsNull', () {
        // arrange
        const sectorApiName = 'Nonexistent Sector';

        // act
        final result = testList.getAverageChangeForSector(sectorApiName);

        // assert
        expect(result, isNull);
      });

      test('getAverageChangeForSector_emptyList_returnsNull', () {
        // arrange
        final emptyList = <SectorPerformance>[];
        const sectorApiName = 'Technology';

        // act
        final result = emptyList.getAverageChangeForSector(sectorApiName);

        // assert
        expect(result, isNull);
      });
    });

    group('getDateForSector', () {
      test('getDateForSector_found_returnsDate', () {
        // arrange
        const sectorApiName = 'Technology';

        // act
        final result = testList.getDateForSector(sectorApiName);

        // assert
        expect(result, '2024-01-15');
      });

      test('getDateForSector_notFound_returnsNull', () {
        // arrange
        const sectorApiName = 'Nonexistent Sector';

        // act
        final result = testList.getDateForSector(sectorApiName);

        // assert
        expect(result, isNull);
      });
    });
  });
}
