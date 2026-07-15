import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';

const String _bizzieChatPaywallFeatureName = 'bizzie_chat';

extension CompanyProfileTabX on CompanyProfileTab {
  String? get paywallFeatureName =>
      this == CompanyProfileTab.chat ? _bizzieChatPaywallFeatureName : null;

  String get label => switch (this) {
    CompanyProfileTab.security => 'Security',
    CompanyProfileTab.chat => 'Chat',
    CompanyProfileTab.business => 'Business',
    CompanyProfileTab.news => 'News',
    CompanyProfileTab.dividends => 'Dividends',
    CompanyProfileTab.revenue => 'Revenue',
    CompanyProfileTab.segments => 'Segments',
    CompanyProfileTab.netIncome => 'Net Income',
    CompanyProfileTab.eps => 'EPS',
    CompanyProfileTab.freeCash => 'Free Cash',
    CompanyProfileTab.fcps => 'FCPS',
    CompanyProfileTab.shares => 'Shares',
    CompanyProfileTab.financialStatements => 'Financial Statements',
    CompanyProfileTab.roe => 'ROE',
    CompanyProfileTab.peRatio => 'PE',
    CompanyProfileTab.pfcfRatio => 'PFCF',
    CompanyProfileTab.more => 'More',
  };

  String get analyticsName => switch (this) {
    CompanyProfileTab.security => 'security',
    CompanyProfileTab.chat => 'chat',
    CompanyProfileTab.business => 'business',
    CompanyProfileTab.news => 'news',
    CompanyProfileTab.dividends => 'dividends',
    CompanyProfileTab.revenue => 'revenue',
    CompanyProfileTab.segments => 'segments',
    CompanyProfileTab.netIncome => 'net_income',
    CompanyProfileTab.eps => 'eps',
    CompanyProfileTab.freeCash => 'free_cash',
    CompanyProfileTab.fcps => 'fcps',
    CompanyProfileTab.shares => 'share',
    CompanyProfileTab.financialStatements => 'financial_statements',
    CompanyProfileTab.roe => 'roe',
    CompanyProfileTab.peRatio => 'pe',
    CompanyProfileTab.pfcfRatio => 'pfcf',
    CompanyProfileTab.more => 'more',
  };
}
