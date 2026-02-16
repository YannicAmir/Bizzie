import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BizzieDateFormatter', () {
    test('formatLastUpdated_today_returnsTodayString', () {
      // arrange
      final now = DateTime.now();
      final dateStr = now.toIso8601String();

      // act
      final formatted = BizzieDateFormatter.formatLastUpdated(dateStr);

      // assert
      expect(formatted.contains('Today at'), true);
    });

    test('formatLastUpdated_historicalDate_returnsFormattedString', () {
      // arrange
      const dateStr = '2023-01-15T12:00:00Z';

      // act
      final formatted = BizzieDateFormatter.formatLastUpdated(dateStr);

      // assert
      expect(formatted.contains('Jan. 15, 2023'), true);
    });

    test('formatYearOnly_validDate_returnsYear', () {
      // arrange
      const dateStr = '2023-09-30';

      // act
      final result = BizzieDateFormatter.formatYearOnly(dateStr);

      // assert
      expect(result, '2023');
    });

    test('formatYearOnly_invalidDate_returnsOriginalString', () {
      // arrange
      const dateStr = 'invalid';

      // act
      final result = BizzieDateFormatter.formatYearOnly(dateStr);

      // assert
      expect(result, 'invalid');
    });

    test('formatMonthYearShort_validDate_returnsFormattedString', () {
      // arrange
      const dateStr = '2023-09-30';

      // act
      final result = BizzieDateFormatter.formatMonthYearShort(dateStr);

      // assert
      expect(result, "Sep. 30, '23");
    });

    test('formatMonthYearFull_validDate_returnsFormattedString', () {
      // arrange
      const dateStr = '2023-09-30';

      // act
      final result = BizzieDateFormatter.formatMonthYearFull(dateStr);

      // assert
      expect(result, 'Sep. 30, 2023');
    });

    test('formatChartLabel_annual_returnsYear', () {
      // arrange
      const dateStr = '2023-09-30';

      // act
      final result = BizzieDateFormatter.formatChartLabel(
        dateStr,
        isAnnual: true,
      );

      // assert
      expect(result, '2023');
    });

    test('formatChartLabel_quarterly_returnsMonthYearShort', () {
      // arrange
      const dateStr = '2023-09-30';

      // act
      final result = BizzieDateFormatter.formatChartLabel(
        dateStr,
        isAnnual: false,
      );

      // assert
      expect(result, "Sep. 30, '23");
    });

    test('formatApiDate_validDate_returnsYYYYMMDD', () {
      // arrange
      final date = DateTime(2023, 10, 25);

      // act
      final result = BizzieDateFormatter.formatApiDate(date);

      // assert
      expect(result, '2023-10-25');
    });

    test('formatApiDateFromStr_validDateString_returnsYYYYMMDD', () {
      // arrange
      const dateStr = '2023-10-25T14:30:00';

      // act
      final result = BizzieDateFormatter.formatApiDateFromStr(dateStr);

      // assert
      expect(result, '2023-10-25');
    });

    test('formatApiDateFromStr_invalidDateString_returnsOriginalString', () {
      // arrange
      const dateStr = 'not-a-date';

      // act
      final result = BizzieDateFormatter.formatApiDateFromStr(dateStr);

      // assert
      expect(result, 'not-a-date');
    });

    group('formatHumanFriendlyDate', () {
      test('returnsTodayForCurrentDate', () {
        // arrange
        final date = DateTime.now();

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, 'Today');
      });

      test('returnsTomorrowForNextDay', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 1));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, 'Tomorrow');
      });

      test('returnsYesterdayForPreviousDay', () {
        // arrange
        final date = DateTime.now().subtract(const Duration(days: 1));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, 'Yesterday');
      });

      test('returnsInXDaysForFutureDatesWithinTargetRange', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 3));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, 'In 3 days');
      });

      test('returnsIn7DaysForTargetUpperBoundary', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 7));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, 'In 7 days');
      });

      test('returnsStandardFormatFor8DaysFuture', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 8));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result.contains('In'), false);
        expect(result.length, greaterThan(3));
      });

      test('returnsXDaysAgoForPastDates', () {
        // arrange
        final date = DateTime.now().subtract(const Duration(days: 5));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, '5 days ago');
      });

      test('returnsStandardFormatForDistantDates', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 30));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result.contains('In'), false);
        expect(result.contains('Today'), false);
        expect(result.contains('Tomorrow'), false);
        expect(result.contains('Yesterday'), false);
        expect(result.length, greaterThan(3)); // e.g. "Mar 15"
      });
    });
  });
}
