enum FinancialPeriod {
  annual,
  quarterly;

  bool get isAnnual => this == FinancialPeriod.annual;
}
