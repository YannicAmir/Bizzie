import 'package:bizzie/features/company_profile/domain/extensions/dividend_event_extensions.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DividendEventListExtensions - toChartData', () {
    final tDividendEvent1 = DividendEvent(
      date: '2023-01-01',
      dividend: 0.25,
      adjDividend: 0.25,
    );
    final tDividendEvent2 = DividendEvent(
      date: '2023-04-01',
      dividend: 0.30,
      adjDividend: 0.30,
    );
    final tEvents = [tDividendEvent1, tDividendEvent2];

    test(
      'toChartData_validDates_returnsReversedChartDataWithFormattedLabels',
      () {
        // arrange
        // act
        final result = tEvents.toChartData();

        // assert
        expect(result, isA<List<BizzieChartData>>());
        expect(result.length, 2);
        // Verify reversal (Last event in input should be first in output)
        expect(result.first.label, "Apr '23");
        expect(result.first.value, 0.30);
        expect(result.last.label, "Jan '23");
        expect(result.last.value, 0.25);
      },
    );

    test('toChartData_invalidDate_fallsBackToOriginalDateString', () {
      // arrange
      final invalidEvent = DividendEvent(
        date: 'INVALID_DATE',
        dividend: 0.50,
        adjDividend: 0.50,
      );
      final list = [invalidEvent];

      // act
      final result = list.toChartData();

      // assert
      expect(result.first.label, 'INVALID_DATE');
      expect(result.first.value, 0.50);
    });

    test('toChartData_emptyList_returnsEmptyList', () {
      // arrange
      final List<DividendEvent> emptyList = [];

      // act
      final result = emptyList.toChartData();

      // assert
      expect(result, isEmpty);
    });
  });
}
