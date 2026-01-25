import 'package:bizzie/features/company_profile/presentation/utils/upcoming_earnings_presentation_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UpcomingEarningsDateX', () {
    group('daysAwayLabel', () {
      test('daysAwayLabel_today_returnsToday', () {
        // arrange
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        // act
        final result = today.daysAwayLabel;

        // assert
        expect(result, 'Today');
      });

      test('daysAwayLabel_tomorrow_returnsTomorrow', () {
        // arrange
        final now = DateTime.now();
        final tomorrow = DateTime(
          now.year,
          now.month,
          now.day,
        ).add(const Duration(days: 1));

        // act
        final result = tomorrow.daysAwayLabel;

        // assert
        expect(result, 'Tomorrow');
      });

      test('daysAwayLabel_multipleDays_returnsXDaysAway', () {
        // arrange
        final now = DateTime.now();
        final fiveDaysAway = DateTime(
          now.year,
          now.month,
          now.day,
        ).add(const Duration(days: 5));

        // act
        final result = fiveDaysAway.daysAwayLabel;

        // assert
        expect(result, '5 days away');
      });
    });

    group('formattedEarningsDate', () {
      test('formattedEarningsDate_jan30_returnsFormattedString', () {
        // arrange
        final testDate = DateTime(2026, 1, 30);

        // act
        final result = testDate.formattedEarningsDate;

        // assert
        expect(result, 'Fri. Jan. 30, 2026');
      });

      test('formattedEarningsDate_feb02_returnsCorrectFormatting', () {
        // arrange
        final testDate = DateTime(2026, 2, 2);

        // act
        final result = testDate.formattedEarningsDate;

        // assert
        expect(result, 'Mon. Feb. 02, 2026');
      });
    });
  });
}
