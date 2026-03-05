import 'package:bizzie/features/company_profile/security/presentation/utils/upcoming_earnings_presentation_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final kNow = DateTime(2026, 3, 4); // Wednesday, March 4th

  group('UpcomingEarningsDateX', () {
    group('calendarDaysAway', () {
      test('returns 0 for same day', () {
        final date = DateTime(2026, 3, 4);
        expect(date.calendarDaysAway(kNow), 0);
      });

      test('returns 5 for 5 days away', () {
        final date = DateTime(2026, 3, 9);
        expect(date.calendarDaysAway(kNow), 5);
      });

      test('handles DST transition correctly (Mar 8th 2026)', () {
        final today = DateTime(2026, 3, 4);
        final earningsDay = DateTime(2026, 3, 9);

        expect(earningsDay.calendarDaysAway(today), 5);
      });
    });

    group('daysAwayLabel', () {
      test('daysAwayLabel_today_returnsToday', () {
        final today = DateTime(2026, 3, 4);
        expect(today.getDaysAwayLabel(kNow), 'Today');
      });

      test('daysAwayLabel_tomorrow_returnsTomorrow', () {
        final tomorrow = DateTime(2026, 3, 5);
        expect(tomorrow.getDaysAwayLabel(kNow), 'Tomorrow');
      });

      test('daysAwayLabel_multipleDays_returnsXDaysAway', () {
        final fiveDaysAway = DateTime(2026, 3, 9);
        expect(fiveDaysAway.getDaysAwayLabel(kNow), '5 days away');
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
