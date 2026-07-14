import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_period_key.dart';
import 'package:flutter_test/flutter_test.dart';

const tAnnualSegment = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'iPhone': 100.0},
);

const tQuarterlySegment = RevenueSegment(
  date: '2026-03-28',
  fiscalYear: 2026,
  period: 'Q2',
  reportedCurrency: 'USD',
  data: {'iPhone': 100.0},
);

void main() {
  group('SegmentPeriodKey', () {
    group('annual', () {
      test('annual_segment_returnsFiscalYearKey', () {
        // arrange - tAnnualSegment

        // act
        final key = SegmentPeriodKey.annual(tAnnualSegment);

        // assert
        expect(key, '2025');
      });
    });

    group('quarterly', () {
      test('quarterly_segment_returnsPeriodAndFiscalYearKey', () {
        // arrange - tQuarterlySegment

        // act
        final key = SegmentPeriodKey.quarterly(tQuarterlySegment);

        // assert
        expect(key, 'Q2 2026');
      });
    });

    group('of', () {
      test('of_annualTrue_returnsAnnualKey', () {
        // arrange - tAnnualSegment

        // act
        final key = SegmentPeriodKey.of(tAnnualSegment, isAnnual: true);

        // assert
        expect(key, '2025');
      });

      test('of_annualFalse_returnsQuarterlyKey', () {
        // arrange - tQuarterlySegment

        // act
        final key = SegmentPeriodKey.of(tQuarterlySegment, isAnnual: false);

        // assert
        expect(key, 'Q2 2026');
      });
    });

    group('previous', () {
      test('previous_annualKey_returnsPriorYear', () {
        // arrange
        const key = '2025';

        // act
        final previous = SegmentPeriodKey.previous(key, isAnnual: true);

        // assert
        expect(previous, '2024');
      });

      test('previous_quarterlyKey_returnsSameQuarterPriorYear', () {
        // arrange
        const key = 'Q2 2026';

        // act
        final previous = SegmentPeriodKey.previous(key, isAnnual: false);

        // assert
        expect(previous, 'Q2 2025');
      });

      test('previous_malformedAnnualKey_returnsNull', () {
        // arrange
        const key = 'not-a-year';

        // act
        final previous = SegmentPeriodKey.previous(key, isAnnual: true);

        // assert
        expect(previous, isNull);
      });

      test('previous_malformedQuarterlyKey_returnsNull', () {
        // arrange
        const key = 'Q2-2026';

        // act
        final previous = SegmentPeriodKey.previous(key, isAnnual: false);

        // assert
        expect(previous, isNull);
      });

      test('previous_quarterlyKeyWithNonNumericYear_returnsNull', () {
        // arrange
        const key = 'Q2 abcd';

        // act
        final previous = SegmentPeriodKey.previous(key, isAnnual: false);

        // assert
        expect(previous, isNull);
      });
    });
  });
}
