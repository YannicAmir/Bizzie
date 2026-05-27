import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeeklyReport.seenKey', () {
    test('seenKey_tickerAndId_returnsCompositeKey', () {
      const report = WeeklyReport(ticker: 'AAPL', id: '2026-05-27');
      expect(report.seenKey, 'AAPL_2026-05-27');
    });

    test('seenKey_nullTicker_includesNullStringForTicker', () {
      const report = WeeklyReport(id: '2026-05-27');
      expect(report.seenKey, 'null_2026-05-27');
    });

    test('seenKey_nullId_includesNullStringForId', () {
      const report = WeeklyReport(ticker: 'AAPL');
      expect(report.seenKey, 'AAPL_null');
    });

    test('seenKey_bothNull_returnsNullUnderscoreNull', () {
      const report = WeeklyReport();
      expect(report.seenKey, 'null_null');
    });

    test('seenKey_differentTickersProduceDifferentKeys', () {
      const aaplReport = WeeklyReport(ticker: 'AAPL', id: '2026-05-27');
      const msftReport = WeeklyReport(ticker: 'MSFT', id: '2026-05-27');
      expect(aaplReport.seenKey, isNot(equals(msftReport.seenKey)));
    });

    test('seenKey_differentIdsProduceDifferentKeys', () {
      const report1 = WeeklyReport(ticker: 'AAPL', id: '2026-05-20');
      const report2 = WeeklyReport(ticker: 'AAPL', id: '2026-05-27');
      expect(report1.seenKey, isNot(equals(report2.seenKey)));
    });
  });
}
