import 'package:bizzie/features/company_profile/domain/extensions/dividend_event_list_extensions.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DividendEventListExtensions - Sorting and Stats', () {
    final tEventOld = DividendEvent(
      date: '2022-01-01',
      dividend: 0.20,
      adjDividend: 0.20,
    );
    final tEventNew = DividendEvent(
      date: '2023-01-01',
      dividend: 0.40,
      adjDividend: 0.40,
    );
    final tEvents = [tEventOld, tEventNew];

    test('sortedByDateDesc_unsortedList_returnsNewSortedList', () {
      // arrange
      // act
      final result = tEvents.sortedByDateDesc;

      // assert
      expect(result.first.date, '2023-01-01');
      expect(result.last.date, '2022-01-01');
      // Ensure original list is unchanged
      expect(tEvents.first.date, '2022-01-01');
    });

    test('totalDividends_populatedList_returnsCorrectSum', () {
      // arrange
      // act
      final result = tEvents.totalDividends;

      // assert
      expect(result, closeTo(0.60, 0.0001));
    });

    test('averageDividend_populatedList_returnsCorrectMean', () {
      // arrange
      // act
      final result = tEvents.averageDividend;

      // assert
      expect(result, closeTo(0.30, 0.0001));
    });

    test('averageDividend_emptyList_returnsZero', () {
      // arrange
      final List<DividendEvent> emptyList = [];

      // act
      final result = emptyList.averageDividend;

      // assert
      expect(result, 0.0);
    });
  });
}
