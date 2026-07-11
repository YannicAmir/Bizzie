import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:bizzie/core/enums/data_origin.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/roe/domain/models/roe_stats.dart';
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
    on<RoeReset>(_onReset);
  }

  void _onReset(RoeReset event, Emitter<CompanyRoeState> emit) =>
      emit(const CompanyRoeState.initial());

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
    );  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyRoeState> emit,
  ) async {
    await onTabHidden();  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyRoeState> emit,
  ) async {
    await onAppBackgrounded();  }

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyRoeState> emit,
  ) {
    onAppForegrounded();  }

  void _onViewAllTapped(ViewAllTapped event, Emitter<CompanyRoeState> emit) {
    updateAnalyticsState((s) {
      return event.isChart
          ? s.copyWith(tappedChartViewAll: true)
          : s.copyWith(tappedTableViewAll: true);
    });
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
        final (stats, origin) = tuple;
        _logger.info(
          'Successfully loaded ROE stats (origin: $origin): ${stats.dataPoints.length} points',
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
        _emitLoadedState(event.ticker, stats, origin, loadTime, true, emit);
      },
    );
  }

  void _emitLoadedState(
    String ticker,
    RoeStats stats,
    CompanyProfileDataOrigin origin,
    int? loadTimeMs,
    bool isSuccess,
    Emitter<CompanyRoeState> emit,
  ) {
    if (stats.dataPoints.isEmpty) {
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

    final referenceLabel = _formatReferenceLabel(stats.referenceDate);
    final chartData = _buildChartData(stats.dataPoints);

    _logger.info(
      'Emitting loaded state: current=${stats.currentValue}, growth=${stats.growthPercentage}%',
    );
    emit(
      CompanyRoeState.loaded(
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
        lastUpdated: DateTime.now(),
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
