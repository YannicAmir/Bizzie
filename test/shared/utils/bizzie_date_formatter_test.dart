import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BizzieDateFormatter', () {
    group('formatLastUpdated', () {
      test('formatLastUpdated_today_returnsTodayWithCorrectLabel', () {
        // arrange
        final now = DateTime.now();
        final nowUtc = now.toUtc();
        final etTime = nowUtc.subtract(const Duration(hours: 5));
        final isAfterMarketClose =
            etTime.hour > 16 || (etTime.hour == 16 && etTime.minute >= 15);
        final dateStr = now.toIso8601String();

        // act
        final result = BizzieDateFormatter.formatLastUpdated(dateStr);

        // assert
        expect(result, contains('Today at'));
        if (isAfterMarketClose) {
          expect(result, isNot(contains('(15 min delay)')));
        } else {
          expect(result, contains('(15 min delay)'));
        }
      });

      test('formatLastUpdated_historicalDate_returnsFormattedDate', () {
        // arrange
        const historicalDate = "2023-01-01T21:00:00Z";

        // act
        final result = BizzieDateFormatter.formatLastUpdated(historicalDate);

        // assert
        expect(result, contains('Jan. 01, 2023 at'));
      });

      test('formatLastUpdated_invalidString_returnsOriginalString', () {
        // arrange
        const input = "invalid";

        // act
        final result = BizzieDateFormatter.formatLastUpdated(input);

        // assert
        expect(result, equals("Unknown"));
      });
    });

    group('formatYearOnly', () {
      test('formatYearOnly_validDate_returnsYear', () {
        // arrange
        const input = "2024-05-20";

        // act
        final result = BizzieDateFormatter.formatYearOnly(input);

        // assert
        expect(result, equals('2024'));
      });

      test('formatYearOnly_invalidDate_returnsOriginal', () {
        // arrange
        const input = "invalid";

        // act
        final result = BizzieDateFormatter.formatYearOnly(input);

        // assert
        expect(result, equals(input));
      });
    });

    group('formatQuarterYearShort', () {
      test('formatQuarterYearShort_q1_returnsQ1', () {
        // arrange
        const input = "2024-01-15";

        // act
        final result = BizzieDateFormatter.formatQuarterYearShort(input);

        // assert
        expect(result, equals("Q1 '24"));
      });

      test('formatQuarterYearShort_q4_returnsQ4', () {
        // arrange
        const input = "2023-12-31";

        // act
        final result = BizzieDateFormatter.formatQuarterYearShort(input);

        // assert
        expect(result, equals("Q4 '23"));
      });
    });

    group('formatHumanFriendlyDate', () {
      test('formatHumanFriendlyDate_today_returnsToday', () {
        // arrange
        final date = DateTime.now();

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, equals('Today'));
      });

      test('formatHumanFriendlyDate_yesterday_returnsYesterday', () {
        // arrange
        final date = DateTime.now().subtract(const Duration(days: 1));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, equals('Yesterday'));
      });

      test('formatHumanFriendlyDate_tomorrow_returnsTomorrow', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 1));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, equals('Tomorrow'));
      });

      test('formatHumanFriendlyDate_future_returnsInXDays', () {
        // arrange
        final date = DateTime.now().add(const Duration(days: 3));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, equals('In 3 days'));
      });

      test('formatHumanFriendlyDate_past_returnsXDaysAgo', () {
        // arrange
        final date = DateTime.now().subtract(const Duration(days: 5));

        // act
        final result = BizzieDateFormatter.formatHumanFriendlyDate(date);

        // assert
        expect(result, equals('5 days ago'));
      });
    });

    group('isStale', () {
      test('isStale_withinInterval_returnsFalse', () {
        // arrange
        final lastUpdated = DateTime.now().subtract(
          const Duration(minutes: 30),
        );

        // act
        final result = BizzieDateFormatter.isStale(
          lastUpdated,
          refreshIntervalMinutes: 60,
        );

        // assert
        expect(result, isFalse);
      });

      test('isStale_exceedsInterval_returnsTrue', () {
        // arrange
        final lastUpdated = DateTime.now().subtract(
          const Duration(minutes: 90),
        );

        // act
        final result = BizzieDateFormatter.isStale(
          lastUpdated,
          refreshIntervalMinutes: 60,
        );

        // assert
        expect(result, isTrue);
      });
    });
  });
}
