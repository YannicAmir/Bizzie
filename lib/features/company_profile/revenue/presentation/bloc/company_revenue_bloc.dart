import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_analytics.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
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
        > {
  final GetRevenueStatsUseCase _getRevenueStatsUseCase;
  final IConfigService _configService;
  final RevenueTabAnalytics _analytics;

  CompanyRevenueBloc(
    this._getRevenueStatsUseCase,
    this._configService,
    this._analytics,
  ) : super(const CompanyRevenueState.initial()) {
    on<CompanyRevenueEvent>(_onEvent);
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) => onTabHidden());
    on<AppBackgrounded>((_, __) => onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodViewed>(_onPeriodViewed);
    on<ViewAllTapped>(_onViewAllTapped);
  }

  @override
  CompanyProfileTabTracker<RevenueTabViewState> get analyticsTracker =>
      _analytics;

  void _onEvent(CompanyRevenueEvent event, Emitter<CompanyRevenueState> emit) {
    _logger.info('Event: $event');
  }

  void _onTabShown(TabShown event, Emitter<CompanyRevenueState> emit) {
    onTabShown(
      event.ticker,
      RevenueTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onPeriodViewed(PeriodViewed event, Emitter<CompanyRevenueState> emit) {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlyRevTab: true)
          : s.copyWith(viewedQtrlyRevTab: true),
    );
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
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

    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRevenueState> emit,
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
        'Company Revenue already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading Revenue stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyRevenueState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getRevenueStatsUseCase(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Revenue stats', failure);
        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: false,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
        );
        emit(CompanyRevenueState.failure(failure));
      },
      (tuple) {
        final (stats, origin) = tuple;
        _logger.info('Successfully loaded Revenue stats (origin: $origin)');

        final newState = CompanyRevenueState.loaded(
          ticker: event.ticker,
          revenueStats: stats,
          annualChartData: _toChartData(stats.annualRevenue, isAnnual: true),
          quarterlyChartData: _toChartData(
            stats.quarterlyRevenue,
            isAnnual: false,
          ),
          historyLimit: _configService.freePlanHistoryCount,
          dataOrigin: origin,
          lastUpdated: DateTime.now(),
        );

        emit(newState);

        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: true,
            dataSource: origin,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyRevenueState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (s) {
        if (BizzieDateFormatter.isStale(
          s.lastUpdated ?? DateTime.now().subtract(const Duration(days: 1)),
          refreshIntervalMinutes: 60,
        )) {
          _logger.info('Revenue data is stale. Refreshing...');
          add(
            CompanyRevenueEvent.loadRequested(
              event.ticker,
              forceRefresh: false,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Revenue in failure state. Triggering retry.');
        add(
          CompanyRevenueEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Revenue in initial state. Triggering load.');
        add(
          CompanyRevenueEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
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
