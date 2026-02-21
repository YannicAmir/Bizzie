import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart'; // Added
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
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/coming_soon_placeholder.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_body.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_watchlist_button.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/app_ratings/presentation/bloc/app_ratings_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfilePage extends StatelessWidget {
  final String ticker;
  final Company? initialCompany;

  const CompanyProfilePage({
    super.key,
    required this.ticker,
    this.initialCompany,
  });

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
        BlocProvider(create: (context) => getIt<CompanyNewsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyDividendsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyRevenueBloc>()),
        BlocProvider(create: (context) => getIt<CompanyNetIncomeBloc>()),
        BlocProvider(create: (context) => getIt<CompanyEpsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyFreeCashFlowBloc>()),
        BlocProvider(create: (context) => getIt<CompanyFcpsBloc>()),
        BlocProvider(create: (context) => getIt<CompanySharesBloc>()),
        BlocProvider(create: (context) => getIt<CompanyPeRatioBloc>()),
        BlocProvider(create: (context) => getIt<CompanyPfcfRatioBloc>()),
        BlocProvider(create: (context) => getIt<CompanyRoeBloc>()),
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
        BlocProvider(
          create: (context) =>
              getIt<FinancialStatementsBloc>()
                ..add(FinancialStatementsEvent.loadIncomeStatements(ticker)),
        ),
        BlocProvider(create: (context) => getIt<AppRatingsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyProfileBloc>()),
      ],
      child: _CompanyProfileView(
        ticker: ticker,
        initialCompany: initialCompany,
      ),
    );
  }
}

class _CompanyProfileView extends StatefulWidget {
  final String ticker;
  final Company? initialCompany;

  const _CompanyProfileView({required this.ticker, this.initialCompany});

  @override
  State<_CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<_CompanyProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final DateTime _entranceTime;
  late final CompanyProfileBloc _profileBloc;
  int _previousTabIndex = 0;

  final List<CompanyProfileTab> _tabs = CompanyProfileTab.values;

  @override
  void initState() {
    super.initState();
    _entranceTime = DateTime.now();
    _profileBloc = context.read<CompanyProfileBloc>();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging || !mounted) return;
    if (_tabController.index == _previousTabIndex) return;

    _previousTabIndex = _tabController.index;

    final currentTab = _tabs[_tabController.index];
    if (currentTab != CompanyProfileTab.more) {
      _profileBloc.add(
        CompanyProfileEvent.tabViewed(tabName: currentTab.analyticsName),
      );
    }

    final state = context.read<CompanySecurityBloc>().state;
    final securityDetails = state.mapOrNull(
      loaded: (s) => s.securityDetails,
      unsupported: (s) => s.securityDetails,
    );

    if (securityDetails != null) {
      context.read<AppRatingsBloc>().add(
        AppRatingsEvent.interactionDetected(
          company: CompanyProfile(
            symbol: securityDetails.ticker,
            companyName: securityDetails.name,
            sector: securityDetails.sector,
            industry: securityDetails.industry,
          ),
          currentTab: currentTab.name,
        ),
      );
    }

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
    _profileBloc.add(const CompanyProfileEvent.closed());
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WatchlistBloc, WatchlistState>(
          listenWhen: (prev, curr) =>
              prev.isInWatchlist(widget.ticker) !=
              curr.isInWatchlist(widget.ticker),
          listener: (context, state) {
            context.read<CompanyProfileBloc>().add(
              CompanyProfileEvent.watchlistStatusChanged(
                isWatchlisted: state.isInWatchlist(widget.ticker),
              ),
            );
          },
        ),
        BlocListener<CompanySecurityBloc, CompanySecurityState>(
          listenWhen: (previous, current) {
            final wasResolved = previous.maybeMap(
              loaded: (_) => true,
              unsupported: (_) => true,
              orElse: () => false,
            );
            final isResolved = current.maybeMap(
              loaded: (_) => true,
              unsupported: (_) => true,
              orElse: () => false,
            );
            return !wasResolved && isResolved;
          },
          listener: (context, state) {
            state.maybeMap(
              loaded: (s) =>
                  _onSecurityResolution(s.securityDetails, isSupported: true),
              unsupported: (s) =>
                  _onSecurityResolution(s.securityDetails, isSupported: false),
              orElse: () {},
            );
          },
        ),
      ],
      child: BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
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
            appBar: _CompanyProfileAppBar(
              ticker: widget.ticker,
              isUnsupported: isUnsupported,
              tabController: _tabController,
              tabs: _tabs,
              entranceTime: _entranceTime,
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
      ),
    );
  }

  void _onSecurityResolution(
    SecurityDetails details, {
    required bool isSupported,
  }) {
    context.read<AppRatingsBloc>().add(
      AppRatingsEvent.interactionDetected(
        company: CompanyProfile(
          symbol: details.ticker,
          companyName: details.name,
          sector: details.sector,
          industry: details.industry,
        ),
        currentTab: _tabs[_tabController.index].name,
      ),
    );

    context.read<CompanyProfileBloc>().add(
      CompanyProfileEvent.opened(
        ticker: details.ticker,
        companyName: details.name,
        industry: details.industry,
        sector: details.sector,
        initialTabName: _tabs[_tabController.index].analyticsName,
        isWatchlisted: context.read<WatchlistBloc>().state.isInWatchlist(
          details.ticker,
        ),
        isCompany: isSupported && !details.isEtf && !details.isFund,
        isEtf: details.isEtf,
        isFund: details.isFund,
      ),
    );
  }
}

class _CompanyProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String ticker;
  final bool isUnsupported;
  final TabController tabController;
  final List<CompanyProfileTab> tabs;
  final DateTime entranceTime;

  const _CompanyProfileAppBar({
    required this.ticker,
    required this.isUnsupported,
    required this.tabController,
    required this.tabs,
    required this.entranceTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      builder: (context, state) {
        return AppBar(
          leading: BackButton(color: theme.colorScheme.onSurface),
          centerTitle: false,
          title: Text(ticker),
          actionsPadding: AppConstants.appBarActionsPadding,
          actions: isUnsupported
              ? null
              : [
                  CompanyWatchlistButton(
                    ticker: ticker,
                    companyName: state.maybeMap(
                      loaded: (s) => s.securityDetails.name,
                      unsupported: (s) => s.securityDetails.name,
                      orElse: () => ticker,
                    ),
                    tabName: tabs[tabController.index].name,
                    entranceTime: entranceTime,
                  ),
                ],
          bottom: isUnsupported
              ? null
              : TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: AppConstants.appBarBottomTabsPadding,
                  tabs: tabs.map((tab) => Tab(text: tab.label)).toList(),
                ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isUnsupported ? 0 : 48.0));
}
