import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyFormatter', () {
    group('format', () {
      test('format_usdWithLocale_returnsFullCurrencyString', () {
        // arrange
        const value = 1234.56;

        // act
        final formatted = CurrencyFormatter.format(
          value,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$1,234.56');
      });

      test('format_nullCurrency_usesLocaleDefaultCurrency', () {
        // arrange
        const value = 5.0;

        // act
        final formatted = CurrencyFormatter.format(
          value,
          null,
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$5.00');
      });

      test('format_negativeValue_returnsSignedCurrencyString', () {
        // arrange
        const tValue = -1234.56;

        // act
        final formatted = CurrencyFormatter.format(
          tValue,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'-$1,234.56');
      });
    });

    group('formatCompact', () {
      test('formatCompact_usdMillions_returnsCompactString', () {
        // arrange
        const value = 1200000.0;

        // act
        final formatted = CurrencyFormatter.formatCompact(
          value,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$1.2M');
      });

      test('formatCompact_subThousandValue_returnsUncompactedString', () {
        // arrange
        const tValue = 999.0;

        // act
        final formatted = CurrencyFormatter.formatCompact(
          tValue,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$999');
      });

      test('formatCompact_billions_returnsCompactBillionString', () {
        // arrange
        const tValue = 2.5e9;

        // act
        final formatted = CurrencyFormatter.formatCompact(
          tValue,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$2.5B');
      });
    });

    group('formatCompactFixed', () {
      test('formatCompactFixed_usdMillions_returnsTwoFractionDigits', () {
        // arrange
        const value = 1234567.0;

        // act
        final formatted = CurrencyFormatter.formatCompactFixed(
          value,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$1.23M');
      });

      test('formatCompactFixed_smallValue_padsToTwoFractionDigits', () {
        // arrange
        const value = 12.3;

        // act
        final formatted = CurrencyFormatter.formatCompactFixed(
          value,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$12.30');
      });

      test('formatCompactFixed_nullCurrency_usesLocaleDefaultCurrency', () {
        // arrange
        const tValue = 1234567.0;

        // act
        final formatted = CurrencyFormatter.formatCompactFixed(
          tValue,
          null,
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'$1.23M');
      });

      test('formatCompactFixed_negativeBillions_returnsSignedFixedString', () {
        // arrange
        const tValue = -1.5e9;

        // act
        final formatted = CurrencyFormatter.formatCompactFixed(
          tValue,
          'USD',
          locale: 'en_US',
        );

        // assert
        expect(formatted, r'-$1.50B');
      });
    });
  });
}
