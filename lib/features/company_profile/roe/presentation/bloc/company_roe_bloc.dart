import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:bizzie/core/enums/data_origin.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_analytics.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';

import 'company_roe_event.dart';
import 'company_roe_state.dart';

final _logger = BizzieLogger('CompanyRoeBloc');

@injectable
class CompanyRoeBloc extends Bloc<CompanyRoeEvent, CompanyRoeState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyRoeEvent,
          CompanyRoeState,
          RoeTabViewState
        > {
  final GetRoeUseCase _getRoeStats;
  final IConfigService _configService;
  final RoeTabAnalytics _analytics;

  CompanyRoeBloc(this._getRoeStats, this._configService, this._analytics)
    : super(const CompanyRoeState.initial()) {
    on<LoadRequested>(_onLoadRequested);
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<ViewAllTapped>(_onViewAllTapped);
  }

  bool _lastLoadSuccess = false;
  int? _lastLoadTimeMs;
  CompanyProfileDataOrigin? _lastDataSource;

  @override
  CompanyProfileTabTracker<RoeTabViewState> get analyticsTracker => _analytics;

  void _onTabShown(TabShown event, Emitter<CompanyRoeState> emit) {
    onTabShown(
      event.ticker,
      RoeTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
        loadTimeMs: _lastLoadTimeMs,
        isSuccess: _lastLoadSuccess,
        dataSource: _lastDataSource,
      ),
    );
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyRoeState> emit,
  ) async {
    await onTabHidden();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyRoeState> emit,
  ) async {
    await onAppBackgrounded();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyRoeState> emit,
  ) {
    onAppForegrounded();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onViewAllTapped(ViewAllTapped event, Emitter<CompanyRoeState> emit) {
    updateAnalyticsState((s) {
      return event.isChart
          ? s.copyWith(tappedChartViewAll: true)
          : s.copyWith(tappedTableViewAll: true);
    });

    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRoeState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (s) => true,
      orElse: () => false,
    );

    final isRightTicker = state.maybeMap(
      loaded: (s) => s.ticker == event.ticker,
      orElse: () => false,
    );

    if (isAlreadyLoaded && isRightTicker && !event.forceRefresh) {
      _logger.info(
        'Company ROE already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading ROE stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyRoeState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getRoeStats(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load ROE stats', failure);
        final loadTime = stopwatch.elapsedMilliseconds;
        _lastLoadSuccess = false;
        _lastLoadTimeMs = loadTime;
        _lastDataSource = null;

        updateAnalyticsState(
          (s) => s.copyWith(isSuccess: false, loadTimeMs: loadTime),
        );
        emit(CompanyRoeState.failure(failure));
      },
      (tuple) {
        final (keyMetrics, origin) = tuple;
        _logger.info(
          'Successfully loaded ROE stats (origin: $origin): ${keyMetrics.length} points',
        );
        final loadTime = stopwatch.elapsedMilliseconds;
        _lastLoadSuccess = true;
        _lastLoadTimeMs = loadTime;
        _lastDataSource = origin;

        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: true,
            dataSource: origin,
            loadTimeMs: loadTime,
          ),
        );
        _emitLoadedState(
          event.ticker,
          keyMetrics,
          origin,
          loadTime,
          true,
          emit,
        );
      },
    );
  }

  void _emitLoadedState(
    String ticker,
    List<dynamic> keyMetrics,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyRoeState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(keyMetrics);

    if (sortedPoints.isEmpty) {
      _logger.info('ROE metrics empty after extraction');
      emit(
        _emptyLoadedState(
          ticker,
          origin,
          loadTimeMs: loadTimeMs,
          isSuccess: isSuccess,
        ),
      );
      return;
    }

    final currentPoint = sortedPoints.last;
    final referencePoint = _findReferencePoint(sortedPoints, currentPoint);
    final growth = _calculateGrowth(currentPoint.value, referencePoint.value);
    final referenceLabel = _formatReferenceLabel(referencePoint);
    final chartData = _buildChartData(sortedPoints);

    _logger.info(
      'Emitting loaded state: current=${currentPoint.value}, growth=${growth.percentage}%',
    );
    emit(
      CompanyRoeState.loaded(
        ticker: ticker,
        dataPoints: sortedPoints,
        chartData: chartData,
        currentValue: currentPoint.value,
        growthPercentage: growth.percentage,
        absoluteDelta: growth.delta.abs(),
        isPositive: growth.delta >= 0,
        referenceLabel: referenceLabel,
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        loadTimeMs: loadTimeMs,
        isSuccess: isSuccess,
        lastUpdated: DateTime.now(),
        analyticsState: analyticsSession,
      ),
    );
  }

  List<FinancialDataPoint> _extractSortedDataPoints(List<dynamic> keyMetrics) {
    final dataPoints = keyMetrics
        .map(
          (m) => FinancialDataPoint(
            date: m.date,
            period: m.period,
            value: m.returnOnEquity,
          ),
        )
        .toList();
    return dataPoints..sort((a, b) => a.date.compareTo(b.date));
  }

  FinancialDataPoint _findReferencePoint(
    List<FinancialDataPoint> sortedPoints,
    FinancialDataPoint currentPoint,
  ) {
    var referencePoint = sortedPoints.first;
    final currentDate = DateTime.tryParse(currentPoint.date);

    if (currentDate != null && sortedPoints.length > 1) {
      final cutoffDate = DateTime(
        currentDate.year - 5,
        currentDate.month,
        currentDate.day,
      );
      for (final p in sortedPoints) {
        final d = DateTime.tryParse(p.date);
        if (d != null && (d.isAfter(cutoffDate) || d == cutoffDate)) {
          referencePoint = p;
          break;
        }
      }
    }
    return referencePoint;
  }

  ({double delta, double percentage}) _calculateGrowth(
    double currentValue,
    double referenceValue,
  ) {
    final delta = currentValue - referenceValue;
    final percentage = referenceValue.abs() < 0.001
        ? 0.0
        : (delta / referenceValue.abs()) * 100;
    return (delta: delta, percentage: percentage);
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
      return ChartDataPoint(label: label, value: p.value * 100);
    }).toList();
  }

  CompanyRoeState _emptyLoadedState(
    String ticker,
    CompanyProfileDataOrigin origin, {
    int? loadTimeMs,
    bool isSuccess = false,
  }) {
    return CompanyRoeState.loaded(
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
      lastUpdated: DateTime.now(),
      analyticsState: analyticsSession,
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyRoeState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'ROE stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('ROE still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('ROE lastUpdated is null. Triggering load.');
          add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('ROE in failure state. Triggering retry.');
        add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('ROE in initial state. Triggering load.');
        add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }
}
