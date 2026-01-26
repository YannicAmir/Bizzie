import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_event.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_event.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_bloc.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/coming_soon_placeholder.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/company_profile_body.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/company_watchlist_button.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfilePage extends StatelessWidget {
  final String ticker;

  const CompanyProfilePage({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CompanyBusinessBloc>()),
        BlocProvider(
          create: (context) =>
              getIt<CompanySecurityBloc>()
                ..add(CompanySecurityEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyNewsBloc>()
                ..add(CompanyNewsEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyDividendsBloc>()
                ..add(CompanyDividendsEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyRevenueBloc>()
                ..add(CompanyRevenueEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyNetIncomeBloc>()
                ..add(CompanyNetIncomeEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyEpsBloc>()
                ..add(CompanyEpsEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyFreeCashFlowBloc>()
                ..add(CompanyFreeCashFlowEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyFcpsBloc>()
                ..add(CompanyFcpsEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanySharesBloc>()
                ..add(CompanySharesEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<FinancialStatementsBloc>()
                ..add(FinancialStatementsEvent.loadIncomeStatements(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyRoeBloc>()
                ..add(CompanyRoeEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyPeRatioBloc>()
                ..add(CompanyPeRatioEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CompanyPfcfRatioBloc>()
                ..add(CompanyPfcfRatioEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<HistoricalPriceEodBloc>()
                ..add(HistoricalPriceEodEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<UpcomingEarningsBloc>()
                ..add(UpcomingEarningsEvent.loadRequested(ticker)),
        ),
      ],
      child: _CompanyProfileView(ticker: ticker),
    );
  }
}

class _CompanyProfileView extends StatefulWidget {
  final String ticker;

  const _CompanyProfileView({required this.ticker});

  @override
  State<_CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<_CompanyProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<CompanyProfileTab> _tabs = CompanyProfileTab.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging || !mounted) return;

    final currentTab = _tabs[_tabController.index];

    switch (currentTab) {
      case CompanyProfileTab.news:
        context.read<CompanyNewsBloc>().add(
          CompanyNewsEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.dividends:
        context.read<CompanyDividendsBloc>().add(
          CompanyDividendsEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.revenue:
        context.read<CompanyRevenueBloc>().add(
          CompanyRevenueEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.netIncome:
        context.read<CompanyNetIncomeBloc>().add(
          CompanyNetIncomeEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.eps:
        context.read<CompanyEpsBloc>().add(
          CompanyEpsEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.freeCash:
        context.read<CompanyFreeCashFlowBloc>().add(
          CompanyFreeCashFlowEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.fcps:
        context.read<CompanyFcpsBloc>().add(
          CompanyFcpsEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.shares:
        context.read<CompanySharesBloc>().add(
          CompanySharesEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.more:
        break;
      case CompanyProfileTab.business:
        context.read<CompanyBusinessBloc>().add(
          CompanyBusinessEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.security:
        context.read<CompanySecurityBloc>().add(
          CompanySecurityEvent.stalenessCheckRequested(widget.ticker),
        );
        context.read<UpcomingEarningsBloc>().add(
          UpcomingEarningsEvent.stalenessCheckRequested(widget.ticker),
        );
        break;
      case CompanyProfileTab.financialStatements:
        context.read<FinancialStatementsBloc>().add(
          FinancialStatementsEvent.stalenessCheckRequested(
            widget.ticker,
            type: FinancialStatementType.income,
          ),
        );
        break;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      builder: (context, state) {
        final isUnsupported = state.maybeMap(
          unsupported: (_) => true,
          orElse: () => false,
        );

        final isEtf = state.maybeMap(
          unsupported: (s) => s.securityDetails.isEtf,
          orElse: () => false,
        );

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: theme.colorScheme.onSurface),
            centerTitle: false,
            title: Text(widget.ticker),
            actionsPadding: AppConstants.appBarActionsPadding,
            actions: isUnsupported
                ? null
                : [
                    CompanyWatchlistButton(
                      ticker: widget.ticker,
                      companyName: widget.ticker,
                    ),
                  ],
            bottom: isUnsupported
                ? null
                : TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: AppConstants.appBarBottomTabsPadding,
                    tabs: _tabs.map((tab) => Tab(text: tab.label)).toList(),
                  ),
          ),
          body: isUnsupported
              ? ComingSoonPlaceholder(
                  type: isEtf ? ComingSoonType.etf : ComingSoonType.fund,
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollStartNotification &&
                        notification.dragDetails != null &&
                        notification.metrics.axis == Axis.horizontal) {
                      HapticFeedback.lightImpact();
                    }
                    return false;
                  },
                  child: CompanyProfileBody(
                    ticker: widget.ticker,
                    tabController: _tabController,
                    tabs: _tabs,
                  ),
                ),
        );
      },
    );
  }
}
