import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';

import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
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
        > {
  final GetPfcfRatioUseCase _getPfcfRatio;
  final IConfigService _configService;
  final PfcfRatioTabAnalytics _analytics;

  CompanyPfcfRatioBloc(this._getPfcfRatio, this._configService, this._analytics)
    : super(const CompanyPfcfRatioState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
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

  @override
  CompanyProfileTabTracker<PfcfRatioTabViewState> get analyticsTracker =>
      _analytics;

  void _onTabShown(TabShown event, Emitter<CompanyPfcfRatioState> emit) {
    state.maybeMap(
      loaded: (s) {
        onTabShown(
          event.ticker,
          PfcfRatioTabViewState(
            ticker: event.ticker,
            timestamp: DateTime.now().toIso8601String(),
            isSuccess: s.isSuccess,
            loadTimeMs: s.loadTimeMs,
            dataSource: s.dataOrigin,
          ),
        );
        emit(s.copyWith(analyticsState: analyticsSession));
      },
      orElse: () {
        onTabShown(
          event.ticker,
          PfcfRatioTabViewState(
            ticker: event.ticker,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
      },
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    await onTabHidden();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    await onAppBackgrounded();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    onAppForegrounded();
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
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

    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyPfcfRatioState> emit,
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
        'Company PFCF Ratio already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading PFCF Ratio stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyPfcfRatioState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getPfcfRatio(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load PFCF Ratio stats', failure);
        final loadTime = stopwatch.elapsedMilliseconds;
        updateAnalyticsState(
          (s) => s.copyWith(isSuccess: false, loadTimeMs: loadTime),
        );
        emit(CompanyPfcfRatioState.failure(failure));
      },
      (tuple) {
        final ratios = tuple.$1;
        final origin = tuple.$2;
        _logger.info(
          'Successfully loaded PFCF Ratio stats: ${ratios.length} points, origin=$origin',
        );

        final loadTime = stopwatch.elapsedMilliseconds;
        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: true,
            dataSource: origin,
            loadTimeMs: loadTime,
          ),
        );
        _emitLoadedState(event.ticker, ratios, origin, loadTime, true, emit);
      },
    );
  }

  void _emitLoadedState(
    String ticker,
    List<dynamic> ratios,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(ratios);

    if (sortedPoints.isEmpty) {
      _logger.info('PFCF Ratio data points empty after extraction');
      emit(_emptyLoadedState(ticker, origin, loadTimeMs, isSuccess));
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
      CompanyPfcfRatioState.loaded(
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

  List<FinancialDataPoint> _extractSortedDataPoints(List<dynamic> ratios) {
    final allPoints = ratios
        .map(
          (r) => FinancialDataPoint(
            date: r.date,
            period: r.period,
            value: r.priceToFreeCashFlowRatio,
          ),
        )
        .toList();

    final validPoints = allPoints.where((p) => p.value != 0).toList();

    if (validPoints.length != allPoints.length) {
      _logger.info(
        'Filtered ${allPoints.length - validPoints.length} zero-value P/FCF points',
      );
    }

    return validPoints..sort((a, b) => a.date.compareTo(b.date));
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
      lastUpdated: DateTime.now(),
      analyticsState: analyticsSession,
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'PFCF Ratio stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyPfcfRatioEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('PFCF Ratio still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('PFCF Ratio lastUpdated is null. Triggering load.');
          add(
            CompanyPfcfRatioEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('PFCF Ratio in failure state. Triggering retry.');
        add(
          CompanyPfcfRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('PFCF Ratio in initial state. Triggering load.');
        add(
          CompanyPfcfRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
