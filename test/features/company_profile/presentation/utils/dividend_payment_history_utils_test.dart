import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/presentation/utils/dividend_payment_history_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DividendPaymentHistoryUtils', () {
    const tEvent = DividendEvent(
      date: '2023-10-01',
      dividend: 0.24,
      adjDividend: 0.24,
    );

    test('calculateChange_returnsNeutralOnFirstEvent', () {
      final (label, color) = DividendPaymentHistoryUtils.calculateChange(
        tEvent,
        null,
      );
      expect(label, '+0.0%');
      expect(color, AppColors.goodText);
    });

    test('calculateChange_calculatesPositiveGrowth', () {
      const prev = DividendEvent(
        date: '2023-07-01',
        dividend: 0.23,
        adjDividend: 0.23,
      );
      final (label, color) = DividendPaymentHistoryUtils.calculateChange(
        tEvent,
        prev,
      );

      expect(label, '+4.3%');
      expect(color, AppColors.goodText);
    });

    test('calculateChange_calculatesNegativeGrowth', () {
      const prev = DividendEvent(
        date: '2023-07-01',
        dividend: 0.25,
        adjDividend: 0.25,
      );
      final (label, color) = DividendPaymentHistoryUtils.calculateChange(
        tEvent,
        prev,
      );

      expect(label, '-4.0%');
      expect(color, AppColors.criticalText);
    });

    test('formatDate_returnsDetailedString', () {
      expect(
        DividendPaymentHistoryUtils.formatDate('2023-10-01'),
        'Oct. 01, 2023',
      );
      expect(DividendPaymentHistoryUtils.formatDate('invalid'), 'invalid');
    });
  });
}
