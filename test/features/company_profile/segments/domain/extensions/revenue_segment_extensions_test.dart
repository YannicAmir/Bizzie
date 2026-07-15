import 'package:bizzie/features/company_profile/segments/domain/extensions/revenue_segment_extensions.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:flutter_test/flutter_test.dart';

const tTopic = 'iPhone';

const tCurrentSegment = RevenueSegment(
  date: '2024-09-28',
  fiscalYear: 2024,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {tTopic: 150.0, 'Mac': 30.0},
);

const tPreviousSegment = RevenueSegment(
  date: '2023-09-30',
  fiscalYear: 2023,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {tTopic: 100.0, 'Services': 20.0},
);

void main() {
  group('RevenueSegmentExtensions', () {
    group('growthPercentFor', () {
      test('growthPercentFor_valueIncreased_returnsPositivePercent', () {
        // arrange
        const sut = tCurrentSegment;

        // act
        final result = sut.growthPercentFor(tTopic, previous: tPreviousSegment);

        // assert
        expect(result, 50.0);
      });

      test('growthPercentFor_valueDecreased_returnsNegativePercent', () {
        // arrange
        const sut = RevenueSegment(
          date: '2024-09-28',
          fiscalYear: 2024,
          period: 'FY',
          reportedCurrency: 'USD',
          data: {tTopic: 80.0},
        );

        // act
        final result = sut.growthPercentFor(tTopic, previous: tPreviousSegment);

        // assert
        expect(result, -20.0);
      });

      test('growthPercentFor_previousSegmentNull_returnsNull', () {
        // arrange
        const sut = tCurrentSegment;

        // act
        final result = sut.growthPercentFor(tTopic, previous: null);

        // assert
        expect(result, isNull);
      });

      test('growthPercentFor_topicMissingInCurrentData_returnsNull', () {
        // arrange
        const sut = tCurrentSegment;

        // act
        final result =
            sut.growthPercentFor('Services', previous: tPreviousSegment);

        // assert
        expect(result, isNull);
      });

      test('growthPercentFor_topicMissingInPreviousData_returnsNull', () {
        // arrange
        const sut = tCurrentSegment;

        // act
        final result = sut.growthPercentFor('Mac', previous: tPreviousSegment);

        // assert
        expect(result, isNull);
      });

      test('growthPercentFor_previousValueZero_returnsNull', () {
        // arrange
        const sut = tCurrentSegment;
        const tZeroPreviousSegment = RevenueSegment(
          date: '2023-09-30',
          fiscalYear: 2023,
          period: 'FY',
          reportedCurrency: 'USD',
          data: {tTopic: 0.0},
        );

        // act
        final result =
            sut.growthPercentFor(tTopic, previous: tZeroPreviousSegment);

        // assert
        expect(result, isNull);
      });

      test(
          'growthPercentFor_previousValueNegative_usesAbsoluteDenominator', () {
        // arrange
        const sut = RevenueSegment(
          date: '2024-09-28',
          fiscalYear: 2024,
          period: 'FY',
          reportedCurrency: 'USD',
          data: {tTopic: -50.0},
        );
        const tNegativePreviousSegment = RevenueSegment(
          date: '2023-09-30',
          fiscalYear: 2023,
          period: 'FY',
          reportedCurrency: 'USD',
          data: {tTopic: -100.0},
        );

        // act
        final result =
            sut.growthPercentFor(tTopic, previous: tNegativePreviousSegment);

        // assert
        expect(result, 50.0);
      });
    });
  });
}
