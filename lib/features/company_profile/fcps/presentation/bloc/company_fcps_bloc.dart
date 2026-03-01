import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import '../../domain/usecases/get_fcps_stats_usecase.dart';
import 'company_fcps_event.dart';
import 'company_fcps_state.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';

final _logger = BizzieLogger('CompanyFcpsBloc');

@injectable
class CompanyFcpsBloc extends Bloc<CompanyFcpsEvent, CompanyFcpsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyFcpsEvent,
          CompanyFcpsState,
          FcpsTabViewState
        > {
  final GetFcpsStatsUseCase _getFcpsStats;
  final IConfigService _configService;
  final FcpsTabAnalytics _fcpsTabAnalytics;

  CompanyFcpsBloc(
    this._getFcpsStats,
    this._configService,
    this._fcpsTabAnalytics,
  ) : super(const CompanyFcpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    _setupAnalyticsHandlers();
  }

  @override
  CompanyProfileTabTracker<FcpsTabViewState> get analyticsTracker =>
      _fcpsTabAnalytics;

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyFcpsState> emit,
  ) async {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );

    onTabShown(
      event.ticker,
      FcpsTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
        loadTimeMs: existingState?.loadTimeMs,
        isSuccess: existingState?.isSuccess ?? false,
        dataSource: existingState?.dataSource,
      ),
    );
    _emitAnalyticsUpdate(emit);
  }

  Future<void> _onPeriodViewed(
    PeriodViewed event,
    Emitter<CompanyFcpsState> emit,
  ) async {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlyFcpsTab: true)
          : s.copyWith(viewedQtrlyFcpsTab: true),
    );
    _emitAnalyticsUpdate(emit);
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
    _emitAnalyticsUpdate(emit);
  }

  void _emitAnalyticsUpdate(Emitter<CompanyFcpsState> emit) {
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFcpsState> emit,
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
        'Company FCPS already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading FCPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyFcpsState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getFcpsStats(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load FCPS stats', failure);
        final metrics =
            (analyticsSession ??
                    FcpsTabViewState(
                      ticker: event.ticker,
                      timestamp: DateTime.now().toIso8601String(),
                    ))
                .copyWith(
                  isSuccess: false,
                  loadTimeMs: stopwatch.elapsedMilliseconds,
                );

        if (analyticsSession != null) {
          updateAnalyticsState((s) => metrics);
        }
        emit(CompanyFcpsState.failure(failure));
      },
      (tuple) {
        final (data, origin) = tuple;
        _logger.info('Successfully loaded FCPS stats (origin: $origin)');

        final metrics =
            (analyticsSession ??
                    FcpsTabViewState(
                      ticker: event.ticker,
                      timestamp: DateTime.now().toIso8601String(),
                    ))
                .copyWith(
                  isSuccess: true,
                  dataSource: origin,
                  loadTimeMs: stopwatch.elapsedMilliseconds,
                );

        if (analyticsSession != null) {
          updateAnalyticsState((s) => metrics);
        }

        emit(
          CompanyFcpsState.loaded(
            ticker: event.ticker,
            fcpsStats: data,
            annualChartData: _toChartData(data.annualFcps, isAnnual: true),
            quarterlyChartData: _toChartData(
              data.quarterlyFcps,
              isAnnual: false,
            ),
            historyLimit: _configService.freePlanHistoryCount,
            dataOrigin: origin,
            lastUpdated: DateTime.now(),
            analyticsState: metrics,
          ),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyFcpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'FCPS stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('FCPS still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('FCPS lastUpdated is null. Triggering load.');
          add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('FCPS in failure state. Triggering retry.');
        add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('FCPS in initial state. Triggering load.');
        add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }

  List<ChartDataPoint> _toChartData(
    List<FinancialDataPoint> dataPoints, {
    required bool isAnnual,
  }) {
    return dataPoints.reversed.map((p) {
      final label = BizzieDateFormatter.formatChartLabel(
        p.date,
        isAnnual: isAnnual,
      );
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  void _setupAnalyticsHandlers() {
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodViewed>(_onPeriodViewed);
    on<ViewAllTapped>(_onViewAllTapped);
  }
}
