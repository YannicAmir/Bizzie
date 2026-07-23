import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_load_status.dart';
import 'package:bizzie/features/reports/presentation/widgets/market_tab_body.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_status_views.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_tab_body.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const int _marketTabIndex = 0;
const int _reportsTabIndex = 1;

const int _maxReportsBadgeCount = 9;
const double _reportsBadgeSpacing = 8;

class ReportsPage extends StatefulWidget {
  final ReportsEntrySource entrySource;
  final ReportsNotificationType? notificationType;

  const ReportsPage({
    super.key,
    this.entrySource = ReportsEntrySource.nav,
    this.notificationType,
  });

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: _wantsReportsTab()
          ? _reportsTabIndex
          : _marketTabIndex,
    );
    _tabController.addListener(_onTabChanged);
    context.read<MarketNewsBloc>().add(const MarketNewsEvent.loadRequested());
    if (_tabController.index == _reportsTabIndex) {
      _triggerViewed();
    }
  }

  @override
  void didUpdateWidget(covariant ReportsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entrySource != widget.entrySource ||
        oldWidget.notificationType != widget.notificationType) {
      if (_wantsReportsTab()) {
        _tabController.animateTo(_reportsTabIndex);
      }
      if (_tabController.index == _reportsTabIndex) {
        _triggerViewed();
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
      _triggerViewed();
    }
  }

  void _triggerViewed() {
    final bloc = context.read<ReportsBloc>();
    bloc.state.mapOrNull(
      loaded: (s) {
        bloc.add(
          ReportsEvent.viewed(
            unreadCount: s.unreadCount(bloc.seenWeeklyReportIds),
            entrySource: widget.entrySource,
            notificationType: widget.notificationType,
          ),
        );
      },
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
            context.push(AppRoutes.search, extra: SearchSource.reports);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Market'),
            const Tab(child: _ReportsTabLabel()),
          ],
        ),
      ),
      body: BlocListener<ReportsBloc, ReportsState>(
        listenWhen: (previous, current) =>
            previous is! Loaded && current is Loaded,
        listener: (context, _) {
          if (_tabController.index == _reportsTabIndex) {
            _triggerViewed();
          }
        },
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
  bool _hasCompletedInitialLoad = false;

  @override
  Widget build(BuildContext context) {
    if (!_hasCompletedInitialLoad) {
      final status = resolveReportsLoadStatus(
        context.watch<ReportsBloc>().state,
        context.watch<MarketNewsBloc>().state,
        context.watch<WatchlistYtdBloc>().state,
      );
      switch (status) {
        case ReportsLoadStatus.loading:
          return const ReportsLoadingView();
        case ReportsLoadStatus.failure:
          return const ReportsErrorView();
        case ReportsLoadStatus.ready:
          _hasCompletedInitialLoad = true;
      }
    }

    return TabBarView(
      controller: widget.tabController,
      children: [
        MarketTabBody(
          onArticleTapped: widget.onMarketNewsTapped,
          onLoadFailed: widget.onMarketNewsLoadFailed,
        ),
        const ReportsTabBody(),
      ],
    );
  }
}

class _ReportsTabLabel extends StatelessWidget {
  const _ReportsTabLabel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        final unreadCount = state.unreadCount(
          context.read<ReportsBloc>().seenWeeklyReportIds,
        );
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Reports'),
            if (unreadCount > 0) ...[
              const SizedBox(width: _reportsBadgeSpacing),
              Badge(
                label: Text(
                  unreadCount > _maxReportsBadgeCount
                      ? '9+'
                      : unreadCount.toString(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
