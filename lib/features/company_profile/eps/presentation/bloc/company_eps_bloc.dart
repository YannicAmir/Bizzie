import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/chart_data_presentation_extensions.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'company_eps_event.dart';
import 'company_eps_state.dart';

final _logger = BizzieLogger('CompanyEpsBloc');

@injectable
class CompanyEpsBloc extends Bloc<CompanyEpsEvent, CompanyEpsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyEpsEvent,
          CompanyEpsState,
          EpsTabViewState
        >,
        AuthSessionResetMixin<CompanyEpsEvent, CompanyEpsState>,
        CompanyProfileLoadGuardMixin {
  final GetEpsStatsUseCase _getEpsStatsUseCase;
  final IConfigService _configService;
  final EpsTabAnalytics _epsTabAnalytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyEpsBloc(
    this._getEpsStatsUseCase,
    this._configService,
    this._epsTabAnalytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyEpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<Reset>((_, emit) => emit(const CompanyEpsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyEpsEvent.reset());
    _setupAnalyticsHandlers();
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.eps)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(CompanyEpsEvent.stalenessCheckRequested(activation.ticker));
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<EpsTabViewState> get analyticsTracker =>
      _epsTabAnalytics;

  @override
  String get featureName => 'Company EPS';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyEpsState> emit,
  ) async {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    state.mapOrNull(
      loaded: (s) => _markVisiblePeriodViewedFor(
        isAnnualView: s.isAnnualView,
        hasData: s.isAnnualView
            ? s.annualChartData.isNotEmpty
            : s.quarterlyChartData.isNotEmpty,
      ),
    );
    add(CompanyEpsEvent.stalenessCheckRequested(event.ticker));
  }

  EpsTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );
    return EpsTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onPeriodChanged(PeriodChanged event, Emitter<CompanyEpsState> emit) {
    state.mapOrNull(
      loaded: (s) => emit(s.copyWith(isAnnualView: event.isAnnual)),
    );
    _markPeriodViewed(isAnnual: event.isAnnual);
  }

  void _markPeriodViewed({required bool isAnnual}) {
    updateAnalyticsState(
      (s) => isAnnual
          ? s.copyWith(viewedYearlyEpsTab: true)
          : s.copyWith(viewedQtrlyEpsTab: true),
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

  Future<void> _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyEpsState> emit,
  ) async {
    updateAnalyticsState(
      (s) => s.copyWith(
        tappedQtrchartViewAll: event.isChart && !event.isAnnual
            ? true
            : s.tappedQtrchartViewAll,
        tappedYrchartViewAll: event.isChart && event.isAnnual
            ? true
            : s.tappedYrchartViewAll,
        tappedQtrtableViewAll: !event.isChart && !event.isAnnual
            ? true
            : s.tappedQtrtableViewAll,
        tappedYrtableViewAll: !event.isChart && event.isAnnual
            ? true
            : s.tappedYrtableViewAll,
      ),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyEpsState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading EPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    final wasAnnualView =
        state.mapOrNull(loaded: (s) => s.isAnnualView) ?? true;
    emit(const CompanyEpsState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getEpsStatsUseCase(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load EPS stats', failure);
        _recordLoadMetrics(
          ticker: event.ticker,
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanyEpsState.failure(failure));
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

  EpsTabViewState _recordLoadMetrics({
    required String ticker,
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final session =
        analyticsSession ??
        EpsTabViewState(
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
    required (EpsStats, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required bool isAnnualView,
    required Emitter<CompanyEpsState> emit,
  }) {
    final (stats, origin) = tuple;
    _logger.info('Successfully loaded EPS stats (origin: $origin)');

    final metrics = _recordLoadMetrics(
      ticker: ticker,
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );

    emit(
      CompanyEpsState.loaded(
        ticker: ticker,
        epsStats: stats,
        annualChartData: stats.annualEps.toChartDataReversed(isAnnual: true),
        quarterlyChartData: stats.quarterlyEps.toChartDataReversed(
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

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyEpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'EPS in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'EPS in initial state. Triggering load.',
      ),
      loading: (_) =>
          _logger.info('EPS already loading, skipping staleness check.'),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerRefresh(ticker, 'EPS lastUpdated is null. Triggering load.');
      return;
    }
    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inHours >= 24) {
      _triggerRefresh(
        ticker,
        'EPS stale (TTL expired: ${difference.inHours}h). Triggering load.',
      );
    } else {
      _logger.info('EPS still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyEpsEvent.loadRequested(ticker, forceRefresh: true));
  }

  void _setupAnalyticsHandlers() {
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodChanged>(_onPeriodChanged);
    on<ViewAllTapped>(_onViewAllTapped);
  }
}
