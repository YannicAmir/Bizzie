class FirestoreConstants {
  // Collections
  static const String companies = 'companies';
  static const String financialReports = 'financial_reports';
  static const String secFilings = 'sec_filings';
  static const String upcomingEarnings = 'upcoming_earnings';
  static const String users = 'users';
  static const String activities = 'activities';
  static const String info = 'info';
  static const String market = 'market';
  static const String financials = 'financials';

  // Documents
  static const String userState = 'user_state';
  static const String reportsActivity = 'reports';
  static const String profile = 'profile';
  static const String proxy = 'proxy';
  static const String news = 'news';
  static const String dividends = 'dividends';
  static const String price = 'price';
  static const String pricesHistory = 'prices_history';
  static const String pricesEod = 'prices_eod';
  static const String earningsReports = 'earnings_reports';
  static const String ratiosTtm = 'ratios_ttm';
  static const String ratiosAnnual = 'ratios_annual';
  static const String keyMetricsTtm = 'key_metrics_ttm';
  static const String keyMetricsAnnual = 'key_metrics_annual';

  // Document ID prefixes (suffixed with a period or type at runtime)
  static const String incomeStablePrefix = 'income_stable';
  static const String incomeLegacyPrefix = 'income_legacy';
  static const String balanceSheetPrefix = 'balance_sheet';
  static const String cashFlowPrefix = 'cash_flow';
  static const String productSegmentationPrefix = 'revenue_product_seg';
  static const String geographicSegmentationPrefix = 'revenue_geographic_seg';

  // Weekly recap
  static const String weeklyRecap = 'weekly_recap';
  static const String weeks = 'weeks';

  // Fields
  static const String ticker = 'ticker';
  static const String symbol = 'symbol';
}
