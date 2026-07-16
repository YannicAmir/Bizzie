enum CompanyProfileTab {
  security,
  chat,
  business,
  news,
  dividends,
  revenue,
  segments,
  netIncome,
  eps,
  freeCash,
  fcps,
  shares,
  financialStatements,
  roe,
  peRatio,
  pfcfRatio,
  more;

  static List<CompanyProfileTab> fromNames(Iterable<String> names) {
    final tabByName = values.asNameMap();
    return names.map((name) => tabByName[name]).nonNulls.toList();
  }
}
