import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter', () {
    test('format_handlesUSD', () {
      final formatted = CurrencyFormatter.format(
        1234.56,
        'USD',
        locale: 'en_US',
      );
      expect(formatted, r'$1,234.56');
    });

    test('formatCompact_handlesUSD', () {
      final formatted = CurrencyFormatter.formatCompact(
        1200000,
        'USD',
        locale: 'en_US',
      );
      expect(formatted, r'$1.2M');
    });
  });
}
