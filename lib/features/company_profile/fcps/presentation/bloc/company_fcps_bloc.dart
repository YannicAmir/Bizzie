import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/fcps/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/chart_data_presentation_extensions.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_fcps_stats_usecase.dart';
import 'company_fcps_event.dart';
import 'company_fcps_state.dart';

final _logger = BizzieLogger('CompanyFcpsBloc');

@injectable
class CompanyFcpsBloc extends Bloc<CompanyFcpsEvent, CompanyFcpsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyFcpsEvent,
          CompanyFcpsState,
          FcpsTabViewState
        >,
        AuthSessionResetMixin<CompanyFcpsEvent, CompanyFcpsState>,
        CompanyProfileLoadGuardMixin {
  final GetFcpsStatsUseCase _getFcpsStats;
  final IConfigService _configService;
  final FcpsTabAnalytics _fcpsTabAnalytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final TabContentFreshnessService _freshnessService;
  final ITimeProvider _timeProvider;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyFcpsBloc(
    this._getFcpsStats,
    this._configService,
    this._fcpsTabAnalytics,
    this._watchActiveTabUseCase,
    this._freshnessService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyFcpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<Reset>((_, emit) => emit(const CompanyFcpsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyFcpsEvent.reset());
    _setupAnalyticsHandlers();
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.fcps)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(CompanyFcpsEvent.stalenessCheckRequested(activation.ticker));
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<FcpsTabViewState> get analyticsTracker =>
      _fcpsTabAnalytics;

  @override
  String get featureName => 'Company FCPS';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyFcpsState> emit,
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
    add(CompanyFcpsEvent.stalenessCheckRequested(event.ticker));
  }

  FcpsTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );
    return FcpsTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onPeriodChanged(PeriodChanged event, Emitter<CompanyFcpsState> emit) {
    state.mapOrNull(
      loaded: (s) => emit(s.copyWith(isAnnualView: event.isAnnual)),
    );
    _markPeriodViewed(isAnnual: event.isAnnual);
  }

  void _markPeriodViewed({required bool isAnnual}) {
    updateAnalyticsState(
      (s) => isAnnual
          ? s.copyWith(viewedYearlyFcpsTab: true)
          : s.copyWith(viewedQtrlyFcpsTab: true),
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
    Emitter<CompanyFcpsState> emit,
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
    Emitter<CompanyFcpsState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading FCPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    final wasAnnualView =
        state.mapOrNull(loaded: (s) => s.isAnnualView) ?? true;
    emit(const CompanyFcpsState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getFcpsStats(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load FCPS stats', failure);
        _recordLoadMetrics(
          ticker: event.ticker,
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanyFcpsState.failure(failure));
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

  FcpsTabViewState _recordLoadMetrics({
    required String ticker,
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final session =
        analyticsSession ??
        FcpsTabViewState(
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
    required (FcpsStats, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required bool isAnnualView,
    required Emitter<CompanyFcpsState> emit,
  }) {
    final (data, origin) = tuple;
    _logger.info('Successfully loaded FCPS stats (origin: $origin)');

    final metrics = _recordLoadMetrics(
      ticker: ticker,
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );

    emit(
      CompanyFcpsState.loaded(
        ticker: ticker,
        fcpsStats: data,
        annualChartData: data.annualFcps.toChartDataReversed(isAnnual: true),
        quarterlyChartData: data.quarterlyFcps.toChartDataReversed(
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
    Emitter<CompanyFcpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'FCPS in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'FCPS in initial state. Triggering load.',
      ),
      loading: (_) =>
          _logger.info('FCPS already loading, skipping staleness check.'),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (_freshnessService.isStale(lastUpdated)) {
      _triggerRefresh(
        ticker,
        'FCPS stale (last updated: $lastUpdated). Triggering load.',
      );
    } else {
      _logger.info('FCPS still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyFcpsEvent.loadRequested(ticker, forceRefresh: true));
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
