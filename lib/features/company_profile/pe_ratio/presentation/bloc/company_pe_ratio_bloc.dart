import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/services/pe_ratio_metrics_service.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';

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
        > {
  final GetPeRatioUseCase _getPeRatio;
  final IConfigService _configService;
  final PeRatioTabAnalytics _analytics;
  final PeRatioMetricsService _metricsService;

  CompanyPeRatioBloc(
    this._getPeRatio,
    this._configService,
    this._analytics,
    this._metricsService,
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
  }

  void _onReset(PeRatioReset event, Emitter<CompanyPeRatioState> emit) =>
      emit(const CompanyPeRatioState.initial());

  @override
  CompanyProfileTabTracker<PeRatioTabViewState> get analyticsTracker =>
      _analytics;

  void _onTabShown(TabShown event, Emitter<CompanyPeRatioState> emit) {
    state.maybeMap(
      loaded: (s) {
        onTabShown(
          event.ticker,
          PeRatioTabViewState(
            ticker: event.ticker,
            timestamp: DateTime.now().toIso8601String(),
            isSuccess: s.isSuccess,
            loadTimeMs: s.loadTimeMs,
            dataSource: s.dataOrigin,
          ),
        );      },
      orElse: () {
        onTabShown(
          event.ticker,
          PeRatioTabViewState(
            ticker: event.ticker,
            timestamp: DateTime.now().toIso8601String(),
          ),
        );
      },
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    await onTabHidden();  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    await onAppBackgrounded();  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyPeRatioState> emit,
  ) {
    onAppForegrounded();  }

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
        'Company PE Ratio already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading PE Ratio stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyPeRatioState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getPeRatio(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load PE Ratio stats', failure);
        final loadTime = stopwatch.elapsedMilliseconds;
        updateAnalyticsState(
          (s) => s.copyWith(isSuccess: false, loadTimeMs: loadTime),
        );
        emit(CompanyPeRatioState.failure(failure));
      },
      (tuple) {
        final ratios = tuple.$1;
        final origin = tuple.$2;
        _logger.info(
          'Successfully loaded PE Ratio stats: ${ratios.length} points, origin=$origin',
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
        lastUpdated: DateTime.now(),
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
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'PE Ratio stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyPeRatioEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('PE Ratio still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('PE Ratio lastUpdated is null. Triggering load.');
          add(
            CompanyPeRatioEvent.loadRequested(event.ticker, forceRefresh: true),
          );
        }
      },
      failure: (_) {
        _logger.info('PE Ratio in failure state. Triggering retry.');
        add(
          CompanyPeRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('PE Ratio in initial state. Triggering load.');
        add(
          CompanyPeRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
