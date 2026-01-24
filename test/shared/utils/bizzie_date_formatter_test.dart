import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BizzieDateFormatter', () {
    test('formatLastUpdated_handlesToday', () {
      final now = DateTime.now();
      final dateStr = now.toIso8601String();
      final formatted = BizzieDateFormatter.formatLastUpdated(dateStr);
      expect(formatted.contains('Today at'), true);
    });

    test('formatLastUpdated_handlesHistoricalDate', () {
      const dateStr = '2023-01-15T12:00:00Z';
      final formatted = BizzieDateFormatter.formatLastUpdated(dateStr);
      expect(formatted.contains('Jan 15, 2023'), true);
    });

    test('formatYearOnly', () {
      expect(BizzieDateFormatter.formatYearOnly('2023-09-30'), '2023');
      expect(BizzieDateFormatter.formatYearOnly('invalid'), 'invalid');
    });

    test('formatMonthYearShort', () {
      expect(
        BizzieDateFormatter.formatMonthYearShort('2023-09-30'),
        "Sep 30, '23",
      );
    });

    test('formatMonthYearFull', () {
      expect(
        BizzieDateFormatter.formatMonthYearFull('2023-09-30'),
        'Sep 30, 2023',
      );
    });

    test('formatChartLabel', () {
      expect(
        BizzieDateFormatter.formatChartLabel('2023-09-30', isAnnual: true),
        '2023',
      );
      expect(
        BizzieDateFormatter.formatChartLabel('2023-09-30', isAnnual: false),
        "Sep 30, '23",
      );
    });
  });
}
