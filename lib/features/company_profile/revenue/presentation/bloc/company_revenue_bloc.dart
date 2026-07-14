import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/revenue/domain/models/revenue_stats.dart';
import 'package:bizzie/features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_analytics.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_view_state.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyRevenueBloc');

@injectable
class CompanyRevenueBloc extends Bloc<CompanyRevenueEvent, CompanyRevenueState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyRevenueEvent,
          CompanyRevenueState,
          RevenueTabViewState
        >,
        AuthSessionResetMixin<CompanyRevenueEvent, CompanyRevenueState>,
        CompanyProfileLoadGuardMixin {
  static const _refreshIntervalMinutes = 60;

  final GetRevenueStatsUseCase _getRevenueStatsUseCase;
  final IConfigService _configService;
  final RevenueTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyRevenueBloc(
    this._getRevenueStatsUseCase,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyRevenueState.initial()) {
    on<CompanyRevenueEvent>(_onEvent);
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodChanged>(_onPeriodChanged);
    on<ViewAllTapped>(_onViewAllTapped);
    on<Reset>((_, emit) => emit(const CompanyRevenueState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyRevenueEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.revenue)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(CompanyRevenueEvent.stalenessCheckRequested(activation.ticker));
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<RevenueTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company Revenue';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  void _onEvent(CompanyRevenueEvent event, Emitter<CompanyRevenueState> emit) {
    _logger.info('Event: $event');
  }

  void _onTabShown(TabShown event, Emitter<CompanyRevenueState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    state.mapOrNull(
      loaded: (s) => _markVisiblePeriodViewedFor(
        isAnnualView: s.isAnnualView,
        hasData: s.isAnnualView
            ? s.annualChartData.isNotEmpty
            : s.quarterlyChartData.isNotEmpty,
      ),
    );
    add(CompanyRevenueEvent.stalenessCheckRequested(event.ticker));
  }

  RevenueTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );
    return RevenueTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onPeriodChanged(
    PeriodChanged event,
    Emitter<CompanyRevenueState> emit,
  ) {
    state.mapOrNull(
      loaded: (s) => emit(s.copyWith(isAnnualView: event.isAnnual)),
    );
    _markPeriodViewed(isAnnual: event.isAnnual);
  }

  void _markPeriodViewed({required bool isAnnual}) {
    updateAnalyticsState(
      (s) => isAnnual
          ? s.copyWith(viewedYearlyRevTab: true)
          : s.copyWith(viewedQtrlyRevTab: true),
    );
  }

  void _markVisiblePeriodViewedFor({
    required bool isAnnualView,
    required bool hasData,
  }) {
    if (hasData) {
      _markPeriodViewed(isAnnual: isAnnualView);
    }
  }

  void _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyRevenueState> emit,
  ) {
    updateAnalyticsState((s) {
      if (event.isAnnual) {
        return event.isChart
            ? s.copyWith(tappedYrchartViewAll: true)
            : s.copyWith(tappedYrtableViewAll: true);
      } else {
        return event.isChart
            ? s.copyWith(tappedQtrchartViewAll: true)
            : s.copyWith(tappedQtrtableViewAll: true);
      }
    });
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRevenueState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading Revenue stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    final wasAnnualView =
        state.mapOrNull(loaded: (s) => s.isAnnualView) ?? true;
    emit(const CompanyRevenueState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getRevenueStatsUseCase(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Revenue stats', failure);
        _recordLoadMetrics(
          ticker: event.ticker,
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanyRevenueState.failure(failure));
      },
      (tuple) => _emitLoadedState(
        ticker: event.ticker,
        tuple: tuple,
        loadTimeMs: stopwatch.elapsedMilliseconds,
        isAnnualView: wasAnnualView,
        emit: emit,
      ),
    );
  }

  RevenueTabViewState _recordLoadMetrics({
    required String ticker,
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final session =
        analyticsSession ??
        RevenueTabViewState(
          ticker: ticker,
          timestamp: _timeProvider.nowLocal.toIso8601String(),
        );
    final metrics = dataSource == null
        ? session.copyWith(isSuccess: isSuccess, loadTimeMs: loadTimeMs)
        : session.copyWith(
            isSuccess: isSuccess,
            dataSource: dataSource,
            loadTimeMs: loadTimeMs,
          );

    if (analyticsSession != null) {
      updateAnalyticsState((s) => metrics);
    }
    return metrics;
  }

  void _emitLoadedState({
    required String ticker,
    required (RevenueStats, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required bool isAnnualView,
    required Emitter<CompanyRevenueState> emit,
  }) {
    final (stats, origin) = tuple;
    _logger.info('Successfully loaded Revenue stats (origin: $origin)');

    final metrics = _recordLoadMetrics(
      ticker: ticker,
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );

    emit(
      CompanyRevenueState.loaded(
        ticker: ticker,
        revenueStats: stats,
        annualChartData: _toChartData(stats.annualRevenue, isAnnual: true),
        quarterlyChartData: _toChartData(
          stats.quarterlyRevenue,
          isAnnual: false,
        ),
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        isAnnualView: isAnnualView,
        lastUpdated: _timeProvider.nowLocal,
        analyticsState: metrics,
      ),
    );
    state.mapOrNull(
      loaded: (s) => _markVisiblePeriodViewedFor(
        isAnnualView: s.isAnnualView,
        hasData: s.isAnnualView
            ? s.annualChartData.isNotEmpty
            : s.quarterlyChartData.isNotEmpty,
      ),
    );
  }

  void _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyRevenueState> emit,
  ) {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (s) => _evaluateStaleness(event.ticker, s.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'Revenue in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'Revenue in initial state. Triggering load.',
      ),
      loading: (_) =>
          _logger.info('Revenue already loading, skipping staleness check.'),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (BizzieDateFormatter.isStale(
      lastUpdated ?? _timeProvider.nowLocal.subtract(const Duration(days: 1)),
      refreshIntervalMinutes: _refreshIntervalMinutes,
    )) {
      _logger.info('Revenue data is stale. Refreshing...');
      add(CompanyRevenueEvent.loadRequested(ticker, forceRefresh: false));
    } else {
      _logger.info('Revenue still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyRevenueEvent.loadRequested(ticker, forceRefresh: true));
  }

  List<ChartDataPoint> _toChartData(
    List<FinancialDataPoint> points, {
    required bool isAnnual,
  }) {
    final sortedPoints = List<FinancialDataPoint>.from(points)
      ..sort((a, b) => a.date.compareTo(b.date));

    return sortedPoints
        .map(
          (p) => ChartDataPoint(
            label: isAnnual
                ? BizzieDateFormatter.formatYearOnly(p.date)
                : BizzieDateFormatter.formatQuarterYearShort(p.date),
            value: p.value.toDouble(),
          ),
        )
        .toList();
  }
}
