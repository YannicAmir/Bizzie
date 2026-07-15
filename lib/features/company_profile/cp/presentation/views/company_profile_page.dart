import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/app_ratings/presentation/bloc/app_ratings_bloc.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_bloc.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_event.dart';
import 'package:bizzie/features/bizzie_chat/presentation/views/bizzie_chat_modal.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_body.dart';
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
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/company_security_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_bloc.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/coming_soon_placeholder.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:flutter/foundation.dart' show listEquals;
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
        BlocProvider(
          create: (context) =>
              getIt<UpcomingEarningsBloc>()
                ..add(UpcomingEarningsEvent.loadRequested(ticker)),
        ),
        BlocProvider(create: (context) => getIt<FinancialStatementsBloc>()),
        BlocProvider(create: (context) => getIt<AppRatingsBloc>()),
        BlocProvider(create: (context) => getIt<CompanyProfileBloc>()),
        BlocProvider(
          create: (context) =>
              getIt<CompanyProfileTabsBloc>()..add(
                CompanyProfileTabsEvent.started(
                  isSubscribed: context.read<UserBloc>().state.isSubscribed,
                ),
              ),
        ),
        BlocProvider(create: (context) => getIt<BizzieChatSessionsBloc>()),
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
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final DateTime _entranceTime;
  late final CompanyProfileBloc _profileBloc;
  late final CompanyProfileTabsBloc _tabsBloc;
  int _previousTabIndex = 0;
  late CompanyProfileTab _selectedTab;

  @override
  void initState() {
    super.initState();
    _entranceTime = DateTime.now();
    _profileBloc = context.read<CompanyProfileBloc>();
    _tabsBloc = context.read<CompanyProfileTabsBloc>();
    _selectedTab = _tabsBloc.state.tabs.first;
    _tabController = _createTabController(length: _tabsBloc.state.tabs.length);
    _startChatSessions();
  }

  void _startChatSessions() {
    final uid = context.read<UserBloc>().state.uidOrNull;
    if (uid == null) return;

    context.read<BizzieChatSessionsBloc>().add(
      BizzieChatSessionsEvent.started(uid: uid, ticker: widget.ticker),
    );
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
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();

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
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging || !mounted) return;
    if (_tabController.index == _previousTabIndex) return;

    final newTabIndex = _tabController.index;
    final currentTab = _tabsBloc.state.tabs[newTabIndex];

    _previousTabIndex = newTabIndex;
    _selectedTab = currentTab;
    if (currentTab != CompanyProfileTab.more) {
      _profileBloc.add(
        CompanyProfileEvent.tabViewed(tabName: currentTab.analyticsName),
      );
    }
    _reportInteraction(currentTab);
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
        currentTab: currentTab.name,
      ),
    );
  }

  void _onSecurityResolution(
    SecurityDetails details, {
    required bool isSupported,
  }) {
    final currentTab = _tabsBloc.state.tabs[_tabController.index];
    _reportInteraction(currentTab);

    context.read<CompanyProfileBloc>().add(
      CompanyProfileEvent.opened(
        ticker: details.ticker,
        companyName: details.name,
        industry: details.industry,
        sector: details.sector,
        initialTabName: currentTab.analyticsName,
        isWatchlisted: context.read<WatchlistBloc>().state.isInWatchlist(
          details.ticker,
        ),
        isCompany: isSupported && !details.isEtf && !details.isFund,
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
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              previous.uidOrNull == null && current.uidOrNull != null,
          listener: (context, state) => _startChatSessions(),
        ),
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              previous.isSubscribed != current.isSubscribed,
          listener: (context, state) => _tabsBloc.add(
            CompanyProfileTabsEvent.started(isSubscribed: state.isSubscribed),
          ),
        ),
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
          listenWhen: (previous, current) =>
              previous.resolvedDetails == null &&
              current.resolvedDetails != null,
          listener: (context, state) {
            final details = state.resolvedDetails;
            if (details == null || details.ticker != widget.ticker) return;

            final isSupported = state.maybeMap(
              loaded: (_) => true,
              orElse: () => false,
            );
            _onSecurityResolution(details, isSupported: isSupported);
          },
        ),
        BlocListener<CompanyProfileTabsBloc, CompanyProfileTabsState>(
          listenWhen: (previous, current) =>
              !listEquals(previous.mainTabs, current.mainTabs),
          listener: (context, state) => _rebuildTabController(state),
        ),
      ],
      child: BlocBuilder<CompanyProfileTabsBloc, CompanyProfileTabsState>(
        builder: (context, tabsState) {
          return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
            builder: (context, securityState) {
              final isUnsupported = securityState.maybeMap(
                unsupported: (_) => true,
                orElse: () => false,
              );

              final isEtf = securityState.maybeMap(
                unsupported: (s) => s.securityDetails.isEtf,
                orElse: () => false,
              );

              return Scaffold(
                appBar: _CompanyProfileAppBar(
                  ticker: widget.ticker,
                  isUnsupported: isUnsupported,
                  tabController: _tabController,
                  tabs: tabsState.tabs,
                  entranceTime: _entranceTime,
                ),
                floatingActionButton:
                    (isUnsupported || !tabsState.isBizzieChatEnabled)
                    ? null
                    : _BizzieChatFab(
                        ticker: widget.ticker,
                        companyName: securityState.maybeMap(
                          loaded: (s) => s.securityDetails.name,
                          orElse: () => widget.ticker,
                        ),
                      ),
                body: isUnsupported
                    ? ComingSoonPlaceholder(
                        type: isEtf ? ComingSoonType.etf : ComingSoonType.fund,
                      )
                    : _HorizontalSwipeHaptics(
                        child: CompanyProfileBody(
                          ticker: widget.ticker,
                          tabController: _tabController,
                          tabs: tabsState.tabs,
                          moreTabs: tabsState.moreTabs,
                        ),
                      ),
              );
            },
          );
        },
      ),
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
          HapticFeedback.lightImpact();
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

  const _CompanyProfileAppBar({
    required this.ticker,
    required this.isUnsupported,
    required this.tabController,
    required this.tabs,
    required this.entranceTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      buildWhen: (previous, current) =>
          previous.resolvedDetails?.name != current.resolvedDetails?.name,
      builder: (context, state) {
        return AppBar(
          leading: const BackButton(),
          centerTitle: false,
          title: Text(ticker),
          actionsPadding: AppConstants.appBarActionsPadding,
          actions: isUnsupported
              ? null
              : [
                  CompanyWatchlistButton(
                    ticker: ticker,
                    companyName: state.resolvedDetails?.name ?? ticker,
                    currentTabName: () => tabs[tabController.index].name,
                    entranceTime: entranceTime,
                  ),
                ],
          bottom: isUnsupported
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(
                    AppConstants.tabBarHeight,
                  ),
                  child: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: AppConstants.appBarBottomTabsPadding,
                    tabs: tabs.map((tab) => Tab(text: tab.label)).toList(),
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

class _BizzieChatFab extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _BizzieChatFab({required this.ticker, required this.companyName});

  @override
  Widget build(BuildContext context) {
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
                tabName: CompanyProfileTab.chat.analyticsName,
                featureName: CompanyProfileTab.chat.paywallFeatureName,
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
