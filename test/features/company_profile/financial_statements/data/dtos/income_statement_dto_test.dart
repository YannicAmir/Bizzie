import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IncomeStatementDto', () {
    test('toDomain_targetCurrencyProvided_keepsOriginalCurrency', () {
      // arrange
      final sut = IncomeStatementDto(
        date: '2025-12-31',
        period: 'FY',
        reportedCurrency: 'TWD',
        symbol: 'TSM',
      );

      // act
      final result = sut.toDomain(multiplier: 0.03, targetCurrency: 'USD');

      // assert
      expect(result.reportedCurrency, 'USD');
      expect(result.originalCurrency, 'TWD');
    });
  });
}
