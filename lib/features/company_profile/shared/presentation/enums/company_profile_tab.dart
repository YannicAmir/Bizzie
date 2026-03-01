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
  roe('ROE'),
  peRatio('PE'),
  pfcfRatio('PFCF'),
  more('More');

  final String label;
  const CompanyProfileTab(this.label);

  String get analyticsName => switch (this) {
    security => 'security',
    business => 'business',
    news => 'news',
    dividends => 'dividends',
    revenue => 'revenue',
    netIncome => 'net_income',
    eps => 'eps',
    freeCash => 'free_cash',
    fcps => 'fcps',
    shares => 'share',
    financialStatements => 'financial_statements',
    roe => 'roe',
    peRatio => 'pe',
    pfcfRatio => 'pfcf',
    more => 'more',
  };
}
