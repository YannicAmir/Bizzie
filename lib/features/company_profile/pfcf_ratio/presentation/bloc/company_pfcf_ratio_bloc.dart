import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio_stats.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';

import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'company_pfcf_ratio_event.dart';
import 'company_pfcf_ratio_state.dart';

final _logger = BizzieLogger('CompanyPfcfRatioBloc');

@injectable
class CompanyPfcfRatioBloc
    extends Bloc<CompanyPfcfRatioEvent, CompanyPfcfRatioState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyPfcfRatioEvent,
          CompanyPfcfRatioState,
          PfcfRatioTabViewState
        >,
        AuthSessionResetMixin<CompanyPfcfRatioEvent, CompanyPfcfRatioState>,
        CompanyProfileLoadGuardMixin {
  final GetPfcfRatioUseCase _getPfcfRatio;
  final IConfigService _configService;
  final PfcfRatioTabAnalytics _analytics;
  final TabContentFreshnessService _freshnessService;
  final ITimeProvider _timeProvider;

  CompanyPfcfRatioBloc(
    this._getPfcfRatio,
    this._configService,
    this._analytics,
    this._freshnessService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyPfcfRatioState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<ViewAllTapped>(_onViewAllTapped);
    on<Reset>((_, emit) => emit(const CompanyPfcfRatioState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyPfcfRatioEvent.reset());
  }

  @override
  CompanyProfileTabTracker<PfcfRatioTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company PFCF Ratio';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  void _onTabShown(TabShown event, Emitter<CompanyPfcfRatioState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
  }

  PfcfRatioTabViewState _buildTabShownViewState(String ticker) {
    final timestamp = _timeProvider.nowLocal.toIso8601String();
    return state.maybeMap(
      loaded: (s) => PfcfRatioTabViewState(
        ticker: ticker,
        timestamp: timestamp,
        isSuccess: s.isSuccess,
        loadTimeMs: s.loadTimeMs,
        dataSource: s.dataOrigin,
      ),
      orElse: () => PfcfRatioTabViewState(ticker: ticker, timestamp: timestamp),
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    await onTabHidden();
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    await onAppBackgrounded();
  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    onAppForegrounded();
  }

  void _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    updateAnalyticsState((s) {
      return event.isChart
          ? s.copyWith(tappedChartViewAll: true)
          : s.copyWith(tappedTableViewAll: true);
    });
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading PFCF Ratio stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyPfcfRatioState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getPfcfRatio(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load PFCF Ratio stats', failure);
        _recordLoadMetrics(
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanyPfcfRatioState.failure(failure));
      },
      (tuple) => _handleLoadSuccess(
        ticker: event.ticker,
        tuple: tuple,
        loadTimeMs: stopwatch.elapsedMilliseconds,
        emit: emit,
      ),
    );
  }

  void _handleLoadSuccess({
    required String ticker,
    required (PfcfRatioStats, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required Emitter<CompanyPfcfRatioState> emit,
  }) {
    final stats = tuple.$1;
    final origin = tuple.$2;
    _logger.info(
      'Successfully loaded PFCF Ratio stats: ${stats.dataPoints.length} points, origin=$origin',
    );
    _recordLoadMetrics(
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );
    _emitLoadedState(ticker, stats, origin, loadTimeMs, true, emit);
  }

  void _recordLoadMetrics({
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    updateAnalyticsState(
      (s) => dataSource == null
          ? s.copyWith(isSuccess: isSuccess, loadTimeMs: loadTimeMs)
          : s.copyWith(
              isSuccess: isSuccess,
              dataSource: dataSource,
              loadTimeMs: loadTimeMs,
            ),
    );
  }

  void _emitLoadedState(
    String ticker,
    PfcfRatioStats stats,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    if (stats.dataPoints.isEmpty) {
      _logger.info('PFCF Ratio data points empty after extraction');
      emit(_emptyLoadedState(ticker, origin, loadTimeMs, isSuccess));
      return;
    }

    final referenceLabel = _formatReferenceLabel(stats.referenceDate);
    final chartData = _buildChartData(stats.dataPoints);

    _logger.info(
      'Emitting loaded state: current=${stats.currentValue}, growth=${stats.growthPercentage}%',
    );
    emit(
      CompanyPfcfRatioState.loaded(
        ticker: ticker,
        dataPoints: stats.dataPoints,
        chartData: chartData,
        currentValue: stats.currentValue,
        growthPercentage: stats.growthPercentage,
        absoluteDelta: stats.absoluteDelta,
        isPositive: stats.isPositive,
        referenceLabel: referenceLabel,
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        loadTimeMs: loadTimeMs,
        isSuccess: isSuccess,
        lastUpdated: _timeProvider.nowLocal,
        analyticsState: analyticsSession,
      ),
    );
  }

  String _formatReferenceLabel(String referenceDate) {
    final refDate = DateTime.tryParse(referenceDate);
    return refDate != null ? DateFormat('yyyy').format(refDate) : referenceDate;
  }

  List<ChartDataPoint> _buildChartData(List<FinancialDataPoint> sortedPoints) {
    return sortedPoints.map((p) {
      final date = DateTime.tryParse(p.date);
      final label = date != null ? DateFormat("MMM ''yy").format(date) : p.date;
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  CompanyPfcfRatioState _emptyLoadedState(
    String ticker,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
  ) {
    return CompanyPfcfRatioState.loaded(
      ticker: ticker,
      dataPoints: [],
      chartData: [],
      currentValue: 0,
      growthPercentage: 0,
      absoluteDelta: 0,
      isPositive: false,
      referenceLabel: '',
      historyLimit: _configService.freePlanHistoryCount,
      dataOrigin: origin,
      loadTimeMs: loadTimeMs,
      isSuccess: isSuccess,
      lastUpdated: _timeProvider.nowLocal,
      analyticsState: analyticsSession,
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'PFCF Ratio in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'PFCF Ratio in initial state. Triggering load.',
      ),
      loading: (_) => _triggerRefresh(
        event.ticker,
        'PFCF Ratio in loading state. Restarting load.',
      ),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (_freshnessService.isStale(lastUpdated)) {
      _triggerRefresh(
        ticker,
        'PFCF Ratio stale (last updated: $lastUpdated). Triggering load.',
      );
    } else {
      _logger.info('PFCF Ratio still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyPfcfRatioEvent.loadRequested(ticker, forceRefresh: true));
  }
}
