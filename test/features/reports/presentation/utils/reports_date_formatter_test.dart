import 'package:bizzie/features/reports/presentation/utils/reports_date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReportsDateFormatter', () {
    group('getRelativeDateLabel', () {
      test('getRelativeDateLabel_nullDate_returnsTBD', () {
        expect(ReportsDateFormatter.getRelativeDateLabel(null), 'TBD');
      });

      test('getRelativeDateLabel_todayDate_returnsToday', () {
        final now = DateTime.now();
        expect(ReportsDateFormatter.getRelativeDateLabel(now), 'Today');
      });

      test('getRelativeDateLabel_tomorrowDate_returnsTomorrow', () {
        final now = DateTime.now();
        final tomorrow = now.add(const Duration(days: 1));
        expect(ReportsDateFormatter.getRelativeDateLabel(tomorrow), 'Tomorrow');
      });

      test('getRelativeDateLabel_futureDate_returnsFormattedString', () {
        final now = DateTime.now();
        final twoDaysLater = DateTime(now.year, now.month, now.day + 2);

        final result = ReportsDateFormatter.getRelativeDateLabel(twoDaysLater);

        expect(result, contains(', in 2 days'));
      });
    });

    group('formatReportDate', () {
      test('formatReportDate_nullDate_returnsDateUnknown', () {
        expect(ReportsDateFormatter.formatReportDate(null), 'Date Unknown');
      });

      test('formatReportDate_validDate_returnsFormattedString', () {
        final date = DateTime(2023, 10, 25);
        expect(ReportsDateFormatter.formatReportDate(date), 'Oct 25, 2023');
      });
    });
  });
}
