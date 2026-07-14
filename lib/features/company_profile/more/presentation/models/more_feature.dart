import 'package:bizzie/features/bizzie_chat/presentation/views/bizzie_chat_tab.dart';
import 'package:bizzie/features/company_profile/business/presentation/views/business_tab.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/views/dividends_tab.dart';
import 'package:bizzie/features/company_profile/eps/presentation/views/eps_tab.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/views/fcps_tab.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/views/financial_statements_tab.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/views/free_cash_flow_tab.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/views/net_income_tab.dart';
import 'package:bizzie/features/company_profile/news/presentation/views/news_tab.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/views/pe_ratio_tab.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/views/pfcf_ratio_tab.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/views/revenue_tab.dart';
import 'package:bizzie/features/company_profile/roe/presentation/views/roe_tab.dart';
import 'package:bizzie/features/company_profile/segments/presentation/views/segments_tab.dart';
import 'package:bizzie/features/company_profile/shares/presentation/views/shares_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'more_feature.freezed.dart';

@freezed
abstract class MoreFeature with _$MoreFeature {
  const factory MoreFeature({
    required String label,
    required String analyticsName,
    required Widget Function(String ticker) builder,
  }) = _MoreFeature;
}

MoreFeature moreFeatureFromTab(CompanyProfileTab tab) {
  return MoreFeature(
    label: tab.label,
    analyticsName: tab.analyticsName,
    builder: (ticker) => _buildViewForTab(tab, ticker),
  );
}

Widget _buildViewForTab(CompanyProfileTab tab, String ticker) {
  return switch (tab) {
    CompanyProfileTab.business => BusinessTab(ticker: ticker),
    CompanyProfileTab.news => NewsTab(ticker: ticker),
    CompanyProfileTab.dividends => DividendsTab(ticker: ticker),
    CompanyProfileTab.revenue => RevenueTab(ticker: ticker),
    CompanyProfileTab.segments => SegmentsTab(ticker: ticker),
    CompanyProfileTab.netIncome => NetIncomeTab(ticker: ticker),
    CompanyProfileTab.eps => EpsTab(ticker: ticker),
    CompanyProfileTab.freeCash => FreeCashFlowTab(ticker: ticker),
    CompanyProfileTab.fcps => FcpsTab(ticker: ticker),
    CompanyProfileTab.shares => SharesTab(ticker: ticker),
    CompanyProfileTab.financialStatements => FinancialStatementsTab(ticker: ticker),
    CompanyProfileTab.roe => RoeTab(ticker: ticker),
    CompanyProfileTab.peRatio => PeRatioTab(ticker: ticker),
    CompanyProfileTab.pfcfRatio => PfcfRatioTab(ticker: ticker),
    CompanyProfileTab.security => throw ArgumentError('security cannot be shown in the More section'),
    CompanyProfileTab.chat => BizzieChatTab(ticker: ticker),
    CompanyProfileTab.more => throw ArgumentError('more cannot be shown in the More section'),
  };
}
