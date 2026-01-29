import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/utils/dividend_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DividendHistoryPresentationX', () {
    test('totalPaidLabel_belowThreshold_returnsTotal', () {
      // arrange
      final List<DividendEvent> history = List.generate(
        7,
        (index) => const DividendEvent(
          date: '2023-01-01',
          dividend: 0.01,
          adjDividend: 0.01,
          declarationDate: '2023-01-01',
          paymentDate: '2023-01-01',
          recordDate: '2023-01-01',
        ),
      );

      // act
      final result = history.totalPaidLabel;

      // assert
      expect(result, 'Total');
    });

    test('totalPaidLabel_atThreshold_returnsTotalWithQuartersLabel', () {
      // arrange
      final List<DividendEvent> history = List.generate(
        8,
        (index) => const DividendEvent(
          date: '2023-01-01',
          dividend: 0.01,
          adjDividend: 0.01,
          declarationDate: '2023-01-01',
          paymentDate: '2023-01-01',
          recordDate: '2023-01-01',
        ),
      );

      // act
      final result = history.totalPaidLabel;

      // assert
      expect(result, 'Total (Last 8 Quarters)');
    });

    test('totalPaidLabel_aboveThreshold_returnsTotalWithQuartersLabel', () {
      // arrange
      final List<DividendEvent> history = List.generate(
        10,
        (index) => const DividendEvent(
          date: '2023-01-01',
          dividend: 0.01,
          adjDividend: 0.01,
          declarationDate: '2023-01-01',
          paymentDate: '2023-01-01',
          recordDate: '2023-01-01',
        ),
      );

      // act
      final result = history.totalPaidLabel;

      // assert
      expect(result, 'Total (Last 8 Quarters)');
    });
  });
}
