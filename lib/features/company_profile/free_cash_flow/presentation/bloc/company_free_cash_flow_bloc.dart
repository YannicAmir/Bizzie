import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import '../../domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'company_free_cash_flow_event.dart';
import 'company_free_cash_flow_state.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_analytics.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';

final _logger = BizzieLogger('CompanyFreeCashFlowBloc');

@injectable
class CompanyFreeCashFlowBloc
    extends Bloc<CompanyFreeCashFlowEvent, CompanyFreeCashFlowState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyFreeCashFlowEvent,
          CompanyFreeCashFlowState,
          FreeCashFlowTabViewState
        > {
  final GetFreeCashFlowStatsUseCase _getFreeCashFlowStats;
  final IConfigService _configService;
  final FreeCashFlowTabAnalytics _freeCashFlowTabAnalytics;

  CompanyFreeCashFlowBloc(
    this._getFreeCashFlowStats,
    this._configService,
    this._freeCashFlowTabAnalytics,
  ) : super(const CompanyFreeCashFlowState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    _setupAnalyticsHandlers();
  }

  @override
  CompanyProfileTabTracker<FreeCashFlowTabViewState> get analyticsTracker =>
      _freeCashFlowTabAnalytics;

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );

    onTabShown(
      event.ticker,
      FreeCashFlowTabViewState(
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
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlyFcfTab: true)
          : s.copyWith(viewedQtrlyFcfTab: true),
    );
    _emitAnalyticsUpdate(emit);
  }

  Future<void> _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyFreeCashFlowState> emit,
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

  void _emitAnalyticsUpdate(Emitter<CompanyFreeCashFlowState> emit) {
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFreeCashFlowState> emit,
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
        'Company Free Cash Flow already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading Free Cash Flow stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyFreeCashFlowState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getFreeCashFlowStats(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Free Cash Flow stats', failure);
        final metrics =
            (analyticsSession ??
                    FreeCashFlowTabViewState(
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
        emit(CompanyFreeCashFlowState.failure(failure));
      },
      (tuple) {
        final (data, origin) = tuple;
        _logger.info(
          'Successfully loaded Free Cash Flow stats (origin: $origin)',
        );

        final metrics =
            (analyticsSession ??
                    FreeCashFlowTabViewState(
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
          CompanyFreeCashFlowState.loaded(
            ticker: event.ticker,
            fcfStats: data,
            annualChartData: _toChartData(data.annualFcf, isAnnual: true),
            quarterlyChartData: _toChartData(
              data.quarterlyFcf,
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
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Free Cash Flow stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyFreeCashFlowEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info(
              'Free Cash Flow still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info('Free Cash Flow lastUpdated is null. Triggering load.');
          add(
            CompanyFreeCashFlowEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Free Cash Flow in failure state. Triggering retry.');
        add(
          CompanyFreeCashFlowEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
      },
      initial: (_) {
        _logger.info('Free Cash Flow in initial state. Triggering load.');
        add(
          CompanyFreeCashFlowEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
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
