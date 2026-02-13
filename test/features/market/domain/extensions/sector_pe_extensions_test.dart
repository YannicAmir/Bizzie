import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/extensions/sector_pe_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SectorPeListX', () {
    late List<SectorPe> testList;

    setUp(() {
      testList = [
        const SectorPe(
          date: '2024-01-15',
          sector: 'Technology',
          exchange: 'NYSE',
          pe: 25.5,
        ),
        const SectorPe(
          date: '2024-01-15',
          sector: 'Healthcare',
          exchange: 'NYSE',
          pe: 18.3,
        ),
        const SectorPe(
          date: '2024-01-15',
          sector: 'Financial Services',
          exchange: 'NYSE',
          pe: 12.1,
        ),
      ];
    });

    group('getPeForSector', () {
      test('getPeForSector_exactMatch_returnsPe', () {
        // arrange
        const sectorApiName = 'Technology';

        // act
        final result = testList.getPeForSector(sectorApiName);

        // assert
        expect(result, 25.5);
      });

      test('getPeForSector_caseInsensitiveMatch_returnsPe', () {
        // arrange
        const sectorApiName = 'HEALTHCARE';

        // act
        final result = testList.getPeForSector(sectorApiName);

        // assert
        expect(result, 18.3);
      });

      test('getPeForSector_withSpaces_returnsPe', () {
        // arrange
        const sectorApiName = 'Financial Services';

        // act
        final result = testList.getPeForSector(sectorApiName);

        // assert
        expect(result, 12.1);
      });

      test('getPeForSector_notFound_returnsNull', () {
        // arrange
        const sectorApiName = 'Nonexistent Sector';

        // act
        final result = testList.getPeForSector(sectorApiName);

        // assert
        expect(result, isNull);
      });

      test('getPeForSector_emptyList_returnsNull', () {
        // arrange
        final emptyList = <SectorPe>[];
        const sectorApiName = 'Technology';

        // act
        final result = emptyList.getPeForSector(sectorApiName);

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
