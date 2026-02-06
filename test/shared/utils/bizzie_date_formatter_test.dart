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
  });
}
