import 'dart:async';

import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/app_ratings/presentation/bloc/app_ratings_bloc.dart';
import 'package:bizzie/features/bizzie_chat/presentation/views/bizzie_chat_modal.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/company_profile_tour_request.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_body.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_host.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_target.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_watchlist_button.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_bloc.dart';
import 'package:bizzie/features/company_profile/security/domain/extensions/security_details_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/company_security_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/historical_price_eod_state_extensions.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_bloc.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/coming_soon_placeholder.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfilePage extends StatelessWidget {
  final String ticker;
  final CompanyProfileTourRequest? tourRequest;
  final bool showBackButton;

  const CompanyProfilePage({
    super.key,
    required this.ticker,
    this.tourRequest,
    this.showBackButton = true,
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
        BlocProvider(create: (context) => getIt<CompanySegmentsBloc>()),
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
        BlocProvider(create: (context) => getIt<PriceChartBloc>()),
        BlocProvider(
          create: (context) =>
              getIt<SecurityQuoteBloc>()
                ..add(SecurityQuoteEvent.loadRequested(ticker)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<UpcomingEarningsBloc>()
                ..add(UpcomingEarningsEvent.loadRequested(ticker)),
        ),
        BlocProvider(create: (context) => getIt<FinancialStatementsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyAiReportsBloc>()),
        BlocProvider(create: (context) => getIt<AppRatingsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyProfileBloc>()),
        BlocProvider(
          create: (context) => getIt<CompanyProfileTabsBloc>()
            ..add(
              CompanyProfileTabsEvent.started(
                isSubscribed: context.read<UserBloc>().state.isSubscribed,
              ),
            ),
        ),
        BlocProvider(create: (context) => getIt<CompanyProfileTourBloc>()),
      ],
      child: _CompanyProfileView(
        ticker: ticker,
        tourRequest: tourRequest,
        showBackButton: showBackButton,
      ),
    );
  }
}

class _CompanyProfileView extends StatefulWidget {
  final String ticker;
  final CompanyProfileTourRequest? tourRequest;
  final bool showBackButton;

  const _CompanyProfileView({
    required this.ticker,
    this.tourRequest,
    required this.showBackButton,
  });

  @override
  State<_CompanyProfileView> createState() => _CompanyProfileViewState();
}

class _CompanyProfileViewState extends State<_CompanyProfileView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final DateTime _entranceTime;
  late final CompanyProfileBloc _profileBloc;
  late final CompanyProfileTabsBloc _tabsBloc;
  late final CompanyProfileTourBloc _tourBloc;
  late final CompanyProfileTourRequest? _tourRequest;
  int _previousTabIndex = 0;
  late CompanyProfileTab _selectedTab;

  @override
  void initState() {
    super.initState();
    _entranceTime = DateTime.now();
    _profileBloc = context.read<CompanyProfileBloc>();
    _tabsBloc = context.read<CompanyProfileTabsBloc>();
    _tourBloc = context.read<CompanyProfileTourBloc>();
    _tourRequest = widget.tourRequest;
    _selectedTab = _tabsBloc.state.tabs.first;
    _tabController = _createTabController(length: _tabsBloc.state.tabs.length);
  }

  TabController _createTabController({
    required int length,
    int initialIndex = 0,
  }) {
    return TabController(
      length: length,
      initialIndex: initialIndex,
      vsync: this,
    )..addListener(_handleTabSelection);
  }

  void _rebuildTabController(CompanyProfileTabsState tabsState) {
    final previousController = _tabController
      ..removeListener(_handleTabSelection);

    final tabs = tabsState.tabs;
    final selectedIndex = tabs.indexOf(_selectedTab);
    final moreIndex = tabs.indexOf(CompanyProfileTab.more);
    final initialIndex = selectedIndex >= 0
        ? selectedIndex
        : (moreIndex < 0 ? 0 : moreIndex);
    _previousTabIndex = initialIndex;
    _selectedTab = tabs[initialIndex];

    setState(() {
      _tabController = _createTabController(
        length: tabs.length,
        initialIndex: initialIndex,
      );
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => previousController.dispose(),
    );
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging || !mounted) return;
    if (_tabController.index == _previousTabIndex) return;

    final newTabIndex = _tabController.index;
    final tabs = _tabsBloc.state.tabs;
    if (newTabIndex >= tabs.length) return;

    final currentTab = tabs[newTabIndex];

    _previousTabIndex = newTabIndex;
    _selectedTab = currentTab;
    if (currentTab != CompanyProfileTab.more) {
      _profileBloc.add(
        CompanyProfileEvent.tabViewed(tabName: currentTab.analyticsName),
      );
    }
    _reportInteraction(currentTab);
    if (currentTab == CompanyProfileTab.revenue) {
      _tourBloc.add(const CompanyProfileTourEvent.revenueTabSelected());
    }
    _tabsBloc.add(
      CompanyProfileTabsEvent.tabActivated(
        tab: currentTab,
        ticker: widget.ticker,
      ),
    );
  }

  void _reportInteraction(CompanyProfileTab currentTab) {
    final details = context.read<CompanySecurityBloc>().state.resolvedDetails;
    if (details == null) return;

    context.read<AppRatingsBloc>().add(
      AppRatingsEvent.interactionDetected(
        company: details.toCompanyProfile(),
        currentTab: currentTab.analyticsName,
      ),
    );
  }

  void _onSubscriptionChanged(BuildContext _, UserState state) {
    _tabsBloc.add(
      CompanyProfileTabsEvent.started(isSubscribed: state.isSubscribed),
    );
  }

  void _onWatchlistStatusChanged(BuildContext _, WatchlistState state) {
    _profileBloc.add(
      CompanyProfileEvent.watchlistStatusChanged(
        isWatchlisted: state.isInWatchlist(widget.ticker),
      ),
    );
  }

  void _onSecurityResolved(BuildContext _, CompanySecurityState state) {
    final details = state.resolvedDetails;
    if (details == null || details.ticker != widget.ticker) return;

    final tabs = _tabsBloc.state.tabs;
    final currentTab = tabs[_tabController.index.clamp(0, tabs.length - 1)];
    _reportInteraction(currentTab);

    _profileBloc.add(
      CompanyProfileEvent.opened(
        ticker: details.ticker,
        companyName: details.name,
        industry: details.industry,
        sector: details.sector,
        initialTabName: currentTab.analyticsName,
        isWatchlisted: context.read<WatchlistBloc>().state.isInWatchlist(
          details.ticker,
        ),
        isCompany: state.isCompany,
        isEtf: details.isEtf,
        isFund: details.isFund,
      ),
    );
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
    final view = MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              previous.isSubscribed != current.isSubscribed,
          listener: _onSubscriptionChanged,
        ),
        BlocListener<WatchlistBloc, WatchlistState>(
          listenWhen: (previous, current) =>
              previous.isInWatchlist(widget.ticker) !=
              current.isInWatchlist(widget.ticker),
          listener: _onWatchlistStatusChanged,
        ),
        BlocListener<CompanySecurityBloc, CompanySecurityState>(
          listenWhen: (previous, current) =>
              previous.resolvedDetails == null &&
              current.resolvedDetails != null,
          listener: _onSecurityResolved,
        ),
        BlocListener<HistoricalPriceEodBloc, HistoricalPriceEodState>(
          listenWhen: (_, current) => !current.isLoading,
          listener: (context, state) => context.read<PriceChartBloc>().add(
            PriceChartEvent.historyUpdated(state.prices),
          ),
        ),
        BlocListener<CompanyProfileTabsBloc, CompanyProfileTabsState>(
          listenWhen: (previous, current) =>
              !listEquals(previous.mainTabs, current.mainTabs),
          listener: (_, state) => _rebuildTabController(state),
        ),
      ],
      child: _CompanyProfileScaffold(
        ticker: widget.ticker,
        tabController: _tabController,
        entranceTime: _entranceTime,
        showBackButton: widget.showBackButton,
      ),
    );

    final tourRequest = _tourRequest;
    if (tourRequest == null) return view;

    return CompanyProfileTourHost(
      ticker: widget.ticker,
      request: tourRequest,
      child: view,
    );
  }
}

class _CompanyProfileScaffold extends StatelessWidget {
  final String ticker;
  final TabController tabController;
  final DateTime entranceTime;
  final bool showBackButton;

  const _CompanyProfileScaffold({
    required this.ticker,
    required this.tabController,
    required this.entranceTime,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    final isUnsupported = context.select<CompanySecurityBloc, bool>(
      (bloc) => bloc.state.isUnsupported,
    );

    return BlocBuilder<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.mainTabs, current.mainTabs) ||
          !listEquals(previous.moreTabs, current.moreTabs) ||
          previous.isBizzieChatEnabled != current.isBizzieChatEnabled,
      builder: (context, tabsState) {
        return Scaffold(
          appBar: _CompanyProfileAppBar(
            ticker: ticker,
            isUnsupported: isUnsupported,
            tabController: tabController,
            tabs: tabsState.tabs,
            entranceTime: entranceTime,
            showBackButton: showBackButton,
          ),
          floatingActionButton:
              (isUnsupported || !tabsState.isBizzieChatEnabled)
              ? null
              : _BizzieChatFab(ticker: ticker),
          body: isUnsupported
              ? const _UnsupportedSecurityPlaceholder()
              : _HorizontalSwipeHaptics(
                  child: CompanyProfileBody(
                    ticker: ticker,
                    tabController: tabController,
                    tabs: tabsState.tabs,
                    moreTabs: tabsState.moreTabs,
                  ),
                ),
        );
      },
    );
  }
}

class _UnsupportedSecurityPlaceholder extends StatelessWidget {
  const _UnsupportedSecurityPlaceholder();

  @override
  Widget build(BuildContext context) {
    final isEtf = context.select<CompanySecurityBloc, bool>(
      (bloc) => bloc.state.resolvedDetails?.isEtf ?? false,
    );

    return ComingSoonPlaceholder(
      type: isEtf ? ComingSoonType.etf : ComingSoonType.fund,
    );
  }
}

class _HorizontalSwipeHaptics extends StatelessWidget {
  final Widget child;

  const _HorizontalSwipeHaptics({required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification &&
            notification.dragDetails != null &&
            notification.metrics.axis == Axis.horizontal) {
          unawaited(HapticFeedback.lightImpact());
        }
        return false;
      },
      child: child,
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
  final bool showBackButton;

  const _CompanyProfileAppBar({
    required this.ticker,
    required this.isUnsupported,
    required this.tabController,
    required this.tabs,
    required this.entranceTime,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      buildWhen: (previous, current) =>
          previous.resolvedDetails?.name != current.resolvedDetails?.name ||
          previous.resolvedDetails?.image != current.resolvedDetails?.image,
      builder: (context, state) {
        return CompanyProfileTourTarget(
          step: CompanyProfileTourStep.companyOverview,
          child: AppBar(
            leading: showBackButton ? const BackButton() : null,
            automaticallyImplyLeading: showBackButton,
            centerTitle: false,
            title: Text(ticker),
            actionsPadding: AppConstants.appBarActionsPadding,
            actions: isUnsupported
                ? null
                : [
                    CompanyProfileTourTarget(
                      step: CompanyProfileTourStep.stayUpdated,
                      child: CompanyWatchlistButton(
                        ticker: ticker,
                        companyName: state.resolvedDetails?.name ?? ticker,
                        logoUrl: state.resolvedDetails?.image,
                        currentTabName: () =>
                            tabs[tabController.index].analyticsName,
                        entranceTime: entranceTime,
                      ),
                    ),
                  ],
            bottom: isUnsupported
                ? null
                : _CompanyProfileTabBar(
                    tabController: tabController,
                    tabs: tabs,
                  ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (isUnsupported ? 0 : AppConstants.tabBarHeight),
  );
}

class _CompanyProfileTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TabController tabController;
  final List<CompanyProfileTab> tabs;

  const _CompanyProfileTabBar({
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return CompanyProfileTourTarget(
      step: CompanyProfileTourStep.tabs,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: AppConstants.appBarBottomTabsPadding,
        tabs: [
          for (final (index, tab) in tabs.indexed)
            tab == CompanyProfileTab.revenue
                ? CompanyProfileTourTarget(
                    step: CompanyProfileTourStep.revenueTab,
                    onTargetTap: () => tabController.animateTo(index),
                    child: Tab(text: tab.label),
                  )
                : Tab(text: tab.label),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.tabBarHeight);
}

const String _chatAnalyticsName = 'chat';
const String _chatPaywallFeatureName = 'bizzie_chat';

class _BizzieChatFab extends StatelessWidget {
  final String ticker;

  const _BizzieChatFab({required this.ticker});

  @override
  Widget build(BuildContext context) {
    final companyName = context.select<CompanySecurityBloc, String>(
      (bloc) => bloc.state.resolvedDetails?.name ?? ticker,
    );

    return BlocSelector<UserBloc, UserState, bool>(
      selector: (state) => state.isSubscribed,
      builder: (context, isSubscribed) {
        return FloatingActionButton(
          heroTag: null,
          onPressed: () {
            if (isSubscribed) {
              BizzieChatModal.show(
                context,
                ticker: ticker,
                companyName: companyName,
              );
            } else {
              PaywallHelper.showLockedTabPaywall(
                context,
                tabName: _chatAnalyticsName,
                featureName: _chatPaywallFeatureName,
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppConstants.companyProfileButtonBorderRadius,
            ),
            child: Image.asset(
              AppAssets.appIcon,
              width: AppConstants.bizzieChatFabImageSize,
              height: AppConstants.bizzieChatFabImageSize,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
