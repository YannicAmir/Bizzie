import 'dart:async';

import 'package:bizzie/app/navigation/search_navigation.dart';
import 'package:bizzie/core/enums/search_source.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_badge_formatter.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_load_status.dart';
import 'package:bizzie/features/reports/presentation/widgets/market_tab_body.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_status_views.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_tab_body.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _tabCount = 2;
const int _marketTabIndex = 0;
const int _reportsTabIndex = 1;

const double _reportsBadgeSpacing = 8;

class ReportsPage extends StatefulWidget {
  final ReportsEntrySource entrySource;
  final ReportsNotificationType? notificationType;
  final String? navigationId;

  const ReportsPage({
    super.key,
    this.entrySource = ReportsEntrySource.nav,
    this.notificationType,
    this.navigationId,
  });

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isPageVisible = false;
  bool _isViewedDispatchScheduled = false;
  bool _hasPendingUnconditionalViewed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabCount,
      vsync: this,
      initialIndex: _wantsReportsTab() ? _reportsTabIndex : _marketTabIndex,
    );
    _tabController.addListener(_onTabChanged);
    context.read<MarketNewsBloc>().add(const MarketNewsEvent.loadRequested());
    if (_tabController.index == _reportsTabIndex) {
      _scheduleViewed();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isPageVisible =
        TickerMode.valuesOf(context).enabled &&
        (ModalRoute.of(context)?.isCurrent ?? true);
    if (isPageVisible && !_isPageVisible) {
      _scheduleViewedIfUnread();
    }
    _isPageVisible = isPageVisible;
  }

  @override
  void didUpdateWidget(covariant ReportsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entrySource != widget.entrySource ||
        oldWidget.notificationType != widget.notificationType ||
        oldWidget.navigationId != widget.navigationId) {
      if (_wantsReportsTab()) {
        _tabController.animateTo(_reportsTabIndex);
      }
      if (_tabController.index == _reportsTabIndex) {
        _scheduleViewed();
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  bool _wantsReportsTab() {
    return widget.notificationType != null ||
        widget.entrySource == ReportsEntrySource.notification ||
        widget.entrySource == ReportsEntrySource.badge;
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    if (_tabController.index == _reportsTabIndex) {
      _scheduleViewed();
    }
  }

  bool get _isViewingReportsTab =>
      _isPageVisible && _tabController.index == _reportsTabIndex;

  void _scheduleViewed() {
    _hasPendingUnconditionalViewed = true;
    _scheduleViewedDispatch();
  }

  void _scheduleViewedIfUnread() => _scheduleViewedDispatch();

  void _scheduleViewedDispatch() {
    if (_isViewedDispatchScheduled) return;
    _isViewedDispatchScheduled = true;
    scheduleMicrotask(_dispatchViewed);
  }

  void _dispatchViewed() {
    final isUnconditional = _hasPendingUnconditionalViewed;
    _isViewedDispatchScheduled = false;
    _hasPendingUnconditionalViewed = false;
    if (!mounted || !_isViewingReportsTab) return;
    context.read<ReportsBloc>().add(
      ReportsEvent.viewed(
        entrySource: widget.entrySource,
        notificationType: widget.notificationType,
        onlyIfUnread: !isUnconditional,
      ),
    );
  }

  void _onMarketNewsTapped(MarketNewsArticle article) {
    context.read<ReportsBloc>().add(
      ReportsEvent.marketNewsArticleOpened(
        publisher: article.publisher,
        site: article.site,
      ),
    );
  }

  void _onMarketNewsLoadFailed(String error) {
    context.read<ReportsBloc>().add(
      ReportsEvent.marketNewsLoadFailed(error: error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BizzieSearchBar(
          readOnly: true,
          onTap: () {
            SearchNavigation.push(context, source: SearchSource.reports);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Market'),
            Tab(child: _ReportsTabLabel()),
          ],
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReportsBloc, ReportsState>(
            listenWhen: (previous, current) =>
                previous is! ReportsLoaded && current is ReportsLoaded,
            listener: (context, _) => _scheduleViewed(),
          ),
          BlocListener<ReportsBloc, ReportsState>(
            listenWhen: (previous, current) =>
                previous is ReportsLoaded &&
                current is ReportsLoaded &&
                current.unreadCount > previous.unreadCount,
            listener: (context, _) => _scheduleViewedIfUnread(),
          ),
        ],
        child: _ReportsBodyGate(
          tabController: _tabController,
          onMarketNewsTapped: _onMarketNewsTapped,
          onMarketNewsLoadFailed: _onMarketNewsLoadFailed,
        ),
      ),
    );
  }
}

class _ReportsBodyGate extends StatefulWidget {
  const _ReportsBodyGate({
    required this.tabController,
    required this.onMarketNewsTapped,
    required this.onMarketNewsLoadFailed,
  });

  final TabController tabController;
  final ValueChanged<MarketNewsArticle> onMarketNewsTapped;
  final ValueChanged<String> onMarketNewsLoadFailed;

  @override
  State<_ReportsBodyGate> createState() => _ReportsBodyGateState();
}

class _ReportsBodyGateState extends State<_ReportsBodyGate> {
  late ReportsLoadStatus _loadStatus;

  @override
  void initState() {
    super.initState();
    _loadStatus = _resolveLoadStatus();
  }

  ReportsLoadStatus _resolveLoadStatus() {
    return resolveReportsLoadStatus(
      context.read<ReportsBloc>().state,
      context.read<MarketNewsBloc>().state,
      context.read<WatchlistYtdBloc>().state,
    );
  }

  void _onLoadSourceChanged(BuildContext context, Object? _) {
    if (_loadStatus == ReportsLoadStatus.ready) return;
    final loadStatus = _resolveLoadStatus();
    if (loadStatus == _loadStatus) return;
    setState(() => _loadStatus = loadStatus);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReportsBloc, ReportsState>(
          listener: _onLoadSourceChanged,
        ),
        BlocListener<MarketNewsBloc, MarketNewsState>(
          listener: _onLoadSourceChanged,
        ),
        BlocListener<WatchlistYtdBloc, WatchlistYtdState>(
          listener: _onLoadSourceChanged,
        ),
      ],
      child: switch (_loadStatus) {
        ReportsLoadStatus.loading => const ReportsLoadingView(),
        ReportsLoadStatus.failure => const ReportsErrorView(),
        ReportsLoadStatus.ready => TabBarView(
          controller: widget.tabController,
          children: [
            MarketTabBody(
              onArticleTapped: widget.onMarketNewsTapped,
              onLoadFailed: widget.onMarketNewsLoadFailed,
            ),
            const ReportsTabBody(),
          ],
        ),
      },
    );
  }
}

class _ReportsTabLabel extends StatelessWidget {
  const _ReportsTabLabel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        final unreadCount = state.unreadCount;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Reports'),
            if (unreadCount > 0) ...[
              const SizedBox(width: _reportsBadgeSpacing),
              Badge(
                label: Text(
                  ReportsBadgeFormatter.formatUnreadCount(unreadCount),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
