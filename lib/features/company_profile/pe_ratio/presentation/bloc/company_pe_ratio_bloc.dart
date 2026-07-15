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
import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/services/pe_ratio_metrics_service.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';

import 'company_pe_ratio_event.dart';
import 'company_pe_ratio_state.dart';

final _logger = BizzieLogger('CompanyPeRatioBloc');

@injectable
class CompanyPeRatioBloc extends Bloc<CompanyPeRatioEvent, CompanyPeRatioState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyPeRatioEvent,
          CompanyPeRatioState,
          PeRatioTabViewState
        >,
        AuthSessionResetMixin<CompanyPeRatioEvent, CompanyPeRatioState>,
        CompanyProfileLoadGuardMixin {
  final GetPeRatioUseCase _getPeRatio;
  final IConfigService _configService;
  final PeRatioTabAnalytics _analytics;
  final PeRatioMetricsService _metricsService;
  final ITimeProvider _timeProvider;

  CompanyPeRatioBloc(
    this._getPeRatio,
    this._configService,
    this._analytics,
    this._metricsService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyPeRatioState.initial()) {
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
    on<PeRatioReset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanyPeRatioEvent.reset());
  }

  void _onReset(PeRatioReset event, Emitter<CompanyPeRatioState> emit) =>
      emit(const CompanyPeRatioState.initial());

  @override
  CompanyProfileTabTracker<PeRatioTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company PE Ratio';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  void _onTabShown(TabShown event, Emitter<CompanyPeRatioState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
  }

  PeRatioTabViewState _buildTabShownViewState(String ticker) {
    final timestamp = _timeProvider.nowLocal.toIso8601String();
    return state.maybeMap(
      loaded: (s) => PeRatioTabViewState(
        ticker: ticker,
        timestamp: timestamp,
        isSuccess: s.isSuccess,
        loadTimeMs: s.loadTimeMs,
        dataSource: s.dataOrigin,
      ),
      orElse: () => PeRatioTabViewState(ticker: ticker, timestamp: timestamp),
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    await onTabHidden();
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    await onAppBackgrounded();
  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyPeRatioState> emit,
  ) {
    onAppForegrounded();
  }

  void _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyPeRatioState> emit,
  ) {
    updateAnalyticsState((s) {
      return event.isChart
          ? s.copyWith(tappedChartViewAll: true)
          : s.copyWith(tappedTableViewAll: true);
    });
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading PE Ratio stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyPeRatioState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getPeRatio(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load PE Ratio stats', failure);
        _recordLoadMetrics(
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanyPeRatioState.failure(failure));
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
    required (List<PeRatio>, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required Emitter<CompanyPeRatioState> emit,
  }) {
    final ratios = tuple.$1;
    final origin = tuple.$2;
    _logger.info(
      'Successfully loaded PE Ratio stats: ${ratios.length} points, origin=$origin',
    );
    _recordLoadMetrics(
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );
    _emitLoadedState(ticker, ratios, origin, loadTimeMs, true, emit);
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
    List<PeRatio> ratios,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyPeRatioState> emit,
  ) {
    final sortedPoints = _metricsService.extractSortedDataPoints(ratios);

    if (sortedPoints.isEmpty) {
      _logger.info('PE Ratio data points empty after extraction');
      _emptyLoadedState(
        ticker,
        sortedPoints,
        origin,
        loadTimeMs,
        isSuccess,
        emit,
      );
      return;
    }

    final currentPoint = sortedPoints.last;
    final referenceDataPoint = _metricsService.findReferencePoint(
      sortedPoints,
      currentPoint,
    );
    final growth = _metricsService.calculateGrowth(
      currentPoint.value,
      referenceDataPoint.value,
    );
    final referenceLabel = _formatReferenceLabel(referenceDataPoint);
    final chartData = _buildChartData(sortedPoints);
    final historyLimit = _configService.freePlanHistoryCount;

    _logger.info(
      'Emitting loaded state: current=${currentPoint.value}, growth=${growth.percentage}%',
    );
    emit(
      CompanyPeRatioState.loaded(
        ticker: ticker,
        dataPoints: sortedPoints,
        chartData: chartData,
        currentValue: currentPoint.value,
        growthPercentage: growth.percentage,
        absoluteDelta: growth.delta.abs(),
        isPositive: growth.delta >= 0,
        referenceLabel: referenceLabel,
        historyLimit: historyLimit,
        dataOrigin: origin,
        loadTimeMs: loadTimeMs,
        isSuccess: isSuccess,
        lastUpdated: _timeProvider.nowLocal,
        analyticsState: analyticsSession,
      ),
    );
  }

  String _formatReferenceLabel(FinancialDataPoint referencePoint) {
    final refDate = DateTime.tryParse(referencePoint.date);
    return refDate != null
        ? DateFormat('yyyy').format(refDate)
        : referencePoint.date;
  }

  List<ChartDataPoint> _buildChartData(List<FinancialDataPoint> sortedPoints) {
    return sortedPoints.map((p) {
      final date = DateTime.tryParse(p.date);
      final label = date != null ? DateFormat("MMM ''yy").format(date) : p.date;
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  void _emptyLoadedState(
    String ticker,
    List<FinancialDataPoint> ratios,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyPeRatioState> emit,
  ) {
    if (ratios.isEmpty) {
      emit(
        CompanyPeRatioState.loaded(
          ticker: ticker,
          dataPoints: [],
          chartData: [],
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
          historyLimit: 0,
          dataOrigin: origin,
          loadTimeMs: loadTimeMs,
          isSuccess: isSuccess,
          analyticsState: analyticsSession,
        ),
      );
      return;
    }
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'PE Ratio in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'PE Ratio in initial state. Triggering load.',
      ),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerRefresh(ticker, 'PE Ratio lastUpdated is null. Triggering load.');
      return;
    }
    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inHours >= 24) {
      _triggerRefresh(
        ticker,
        'PE Ratio stale (TTL expired: ${difference.inHours}h). Triggering load.',
      );
    } else {
      _logger.info('PE Ratio still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyPeRatioEvent.loadRequested(ticker, forceRefresh: true));
  }
}
