import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter_test/flutter_test.dart';

const tPoint2021 = FinancialDataPoint(
  date: '2021-12-31',
  period: 'FY',
  value: 2.0,
);
const tPoint2022 = FinancialDataPoint(
  date: '2022-12-31',
  period: 'FY',
  value: 4.0,
);
const tPoint2023 = FinancialDataPoint(
  date: '2023-12-31',
  period: 'FY',
  value: 6.0,
);
const tPoint2024 = FinancialDataPoint(
  date: '2024-12-31',
  period: 'FY',
  value: 8.0,
);

void main() {
  group('FinancialDataPointListX', () {
    group('averageValue', () {
      test('averageValue_emptyList_returnsZero', () {
        // arrange
        final sut = <FinancialDataPoint>[];

        // act
        final result = sut.averageValue;

        // assert
        expect(result, 0.0);
      });

      test('averageValue_multipleItems_returnsArithmeticMean', () {
        // arrange
        final sut = [tPoint2021, tPoint2022, tPoint2023];

        // act
        final result = sut.averageValue;

        // assert
        expect(result, 4.0);
      });
    });

    group('sortedByDateDescending', () {
      test('sortedByDateDescending_unsortedList_returnsNewestFirst', () {
        // arrange
        final sut = [tPoint2022, tPoint2024, tPoint2021, tPoint2023];

        // act
        final result = sut.sortedByDateDescending();

        // assert
        expect(result, [tPoint2024, tPoint2023, tPoint2022, tPoint2021]);
      });

      test('sortedByDateDescending_unsortedList_doesNotMutateOriginal', () {
        // arrange
        final sut = [tPoint2022, tPoint2024, tPoint2021];

        // act
        sut.sortedByDateDescending();

        // assert
        expect(sut, [tPoint2022, tPoint2024, tPoint2021]);
      });

      test('sortedByDateDescending_emptyList_returnsEmptyList', () {
        // arrange
        final sut = <FinancialDataPoint>[];

        // act
        final result = sut.sortedByDateDescending();

        // assert
        expect(result, isEmpty);
      });
    });

    group('getAverageOfLatest', () {
      test('getAverageOfLatest_countExceedsLength_returnsNull', () {
        // arrange
        final sut = [tPoint2023, tPoint2024];

        // act
        final result = sut.getAverageOfLatest(3);

        // assert
        expect(result, isNull);
      });

      test(
        'getAverageOfLatest_countWithinLength_returnsAverageOfLatestByDate',
        () {
          // arrange
          final sut = [tPoint2024, tPoint2021, tPoint2023, tPoint2022];

          // act
          final result = sut.getAverageOfLatest(2);

          // assert
          expect(result, 7.0);
        },
      );

      test('getAverageOfLatest_countEqualsLength_returnsAverageOfAll', () {
        // arrange
        final sut = [tPoint2021, tPoint2022, tPoint2023, tPoint2024];

        // act
        final result = sut.getAverageOfLatest(4);

        // assert
        expect(result, 5.0);
      });
    });
  });
}
