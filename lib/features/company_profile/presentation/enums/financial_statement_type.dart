enum FinancialStatementType {
  income('Income Statement'),
  balance('Balance Sheet'),
  cashFlow('Cash Flow Statement');

  final String label;
  const FinancialStatementType(this.label);
}
