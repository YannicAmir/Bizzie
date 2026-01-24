enum FinancialStatementType {
  income('Income'),
  balance('Balance Sheet'),
  cashFlow('Cash Flow');

  final String label;
  const FinancialStatementType(this.label);
}
