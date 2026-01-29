import 'package:bizzie/features/company_profile/dividends/presentation/utils/dividend_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DividendFormatters', () {
    test('formatAmount_formatsWithDollarAndDecimals', () {
      expect(DividendFormatters.formatAmount(1.2), r'$1.20');
      expect(DividendFormatters.formatAmount(0.555), r'$0.56');
    });

    test('formatDate_formatsWithDefaultParameters', () {
      expect(DividendFormatters.formatDate('2023-01-15'), 'Jan. 2023');
      expect(DividendFormatters.formatDate(''), 'TBD');
      expect(DividendFormatters.formatDate('invalid'), 'invalid');
    });

    test('formatGrowthRate_addsSignAndPercent', () {
      expect(DividendFormatters.formatGrowthRate(5.5), '+5.5%');
      expect(DividendFormatters.formatGrowthRate(-2.1), '-2.1%');
      expect(DividendFormatters.formatGrowthRate(0), '+0.0%');
    });

    test('formatDisplayValue_identifiesAndFormatsProperly', () {
      expect(
        DividendFormatters.formatDisplayValue('2023-01-15'),
        'Jan. 15, 2023',
      );
      expect(DividendFormatters.formatDisplayValue(r'$1.20'), r'$1.20');
      expect(DividendFormatters.formatDisplayValue('+5%'), '+5%');
      expect(DividendFormatters.formatDisplayValue('N/A'), 'TBD');
      expect(DividendFormatters.formatDisplayValue(''), 'TBD');
    });

    test('formatOptionalDate_handlesNullAndEmpty', () {
      expect(DividendFormatters.formatOptionalDate(null), 'TBD');
      expect(DividendFormatters.formatOptionalDate(''), 'TBD');
      expect(
        DividendFormatters.formatOptionalDate('2023-01-15'),
        'Jan. 15, 2023',
      );
    });
  });
}
