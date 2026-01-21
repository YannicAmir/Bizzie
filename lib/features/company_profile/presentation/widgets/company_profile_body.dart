import 'package:bizzie/features/company_profile/presentation/views/tabs/business_tab.dart';

import 'package:bizzie/features/company_profile/presentation/views/tabs/dividends_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/eps_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/fcps_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/financial_statements_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/free_cash_flow_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/more_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/net_income_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/news_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/revenue_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/security_tab.dart';
import 'package:bizzie/features/company_profile/presentation/views/tabs/shares_tab.dart';
import 'package:flutter/material.dart';

import 'package:bizzie/features/company_profile/presentation/enums/company_profile_tab.dart';

class CompanyProfileBody extends StatelessWidget {
  final String ticker;
  final TabController tabController;
  final List<CompanyProfileTab> tabs;

  const CompanyProfileBody({
    super.key,
    required this.ticker,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: tabs.map((tab) {
        switch (tab) {
          case CompanyProfileTab.security:
            return SecurityTab(ticker: ticker);
          case CompanyProfileTab.business:
            return BusinessTab(ticker: ticker);
          case CompanyProfileTab.news:
            return NewsTab(ticker: ticker);
          case CompanyProfileTab.dividends:
            return DividendsTab(ticker: ticker);
          case CompanyProfileTab.revenue:
            return RevenueTab(ticker: ticker);
          case CompanyProfileTab.netIncome:
            return NetIncomeTab(ticker: ticker);
          case CompanyProfileTab.eps:
            return EpsTab(ticker: ticker);
          case CompanyProfileTab.freeCash:
            return FreeCashFlowTab(ticker: ticker);
          case CompanyProfileTab.fcps:
            return FcpsTab(ticker: ticker);
          case CompanyProfileTab.shares:
            return SharesTab(ticker: ticker);
          case CompanyProfileTab.financialStatements:
            return FinancialStatementsTab(ticker: ticker);
          case CompanyProfileTab.more:
            return MoreTab(ticker: ticker);
        }
      }).toList(),
    );
  }
}
