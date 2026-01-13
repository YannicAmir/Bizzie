import 'package:bizzie/features/reports/presentation/utils/reports_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReportsUtils', () {
    group('formatReportCurrency', () {
      test('formatReportCurrency_usd_formatsCorrectly', () {
        expect(formatReportCurrency(1000, 'USD'), '\$1K');
        expect(formatReportCurrency(1500000, 'USD'), '\$1.5M');
      });

      test('formatReportCurrency_eur_formatsCorrectly', () {
        final result = formatReportCurrency(1000, 'EUR');
        expect(result, contains('€'));
        expect(result, contains('1K'));
      });
    });

    group('formatReportPercentage', () {
      test('formatReportPercentage_positive_formatsCorrectly', () {
        expect(formatReportPercentage(0.1234), '+0.12%');
      });

      test('formatReportPercentage_negative_formatsCorrectly', () {
        expect(formatReportPercentage(-0.0567), '-0.06%');
      });

      test('formatReportPercentage_zero_formatsCorrectly', () {
        expect(formatReportPercentage(0), '+0.00%');
      });
    });
  });
}
