enum SearchType {
  stock,
  product;

  String get analyticsValue => name;
}

enum SearchOutcome {
  matchFound,
  noMatch,
  error;

  String get analyticsValue => name;
}

enum SearchSource {
  home,
  reports;

  String get analyticsValue => name;
}
