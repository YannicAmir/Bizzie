enum CompanyProfileTab {
  security('Security'),
  business('Business'),
  news('News'),
  dividends('Dividends'),
  revenue('Revenue'),
  netIncome('Net Income'),
  eps('EPS'),
  freeCash('Free Cash'),
  fcps('FCPS'),
  shares('Shares'),
  financialStatements('Financial Statements'),
  more('More');

  final String label;
  const CompanyProfileTab(this.label);
}
