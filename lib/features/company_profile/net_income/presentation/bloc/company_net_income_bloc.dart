import 'dart:async';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_analytics.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'company_net_income_event.dart';
import 'company_net_income_state.dart';

final _logger = BizzieLogger('CompanyNetIncomeBloc');

@injectable
class CompanyNetIncomeBloc
    extends Bloc<CompanyNetIncomeEvent, CompanyNetIncomeState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyNetIncomeEvent,
          CompanyNetIncomeState,
          NetIncomeTabViewState
        > {
  final GetNetIncomeStatsUseCase _getNetIncomeStatsUseCase;
  final IConfigService _configService;
  final NetIncomeTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyNetIncomeBloc(
    this._getNetIncomeStatsUseCase,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
  ) : super(const CompanyNetIncomeState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodViewed>(_onPeriodViewed);
    on<ViewAllTapped>(_onViewAllTapped);
    on<NetIncomeReset>(_onReset);
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.netIncome)
        .listen((activation) {
            final shouldHandle = state.maybeMap(
              loading: (_) => false,
              loaded: (s) => s.ticker == activation.ticker,
              orElse: () => true,
            );
            if (shouldHandle) {
                          add(CompanyNetIncomeEvent.stalenessCheckRequested(activation.ticker));
            }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<NetIncomeTabViewState> get analyticsTracker =>
      _analytics;

  void _onReset(NetIncomeReset event, Emitter<CompanyNetIncomeState> emit) =>
      emit(const CompanyNetIncomeState.initial());

  void _onTabShown(TabShown event, Emitter<CompanyNetIncomeState> emit) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );

    onTabShown(
      event.ticker,
      NetIncomeTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
        loadTimeMs: existingState?.loadTimeMs,
        isSuccess: existingState?.isSuccess ?? false,
        dataSource: existingState?.dataSource,
      ),
    );    add(CompanyNetIncomeEvent.stalenessCheckRequested(event.ticker));
  }

  void _onPeriodViewed(
    PeriodViewed event,
    Emitter<CompanyNetIncomeState> emit,
  ) {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlyNetTab: true)
          : s.copyWith(viewedQtrlyNetTab: true),
    );  }

  void _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyNetIncomeState> emit,
  ) {
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
    );  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyNetIncomeState> emit,
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
        'Company Net Income already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading Net Income stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyNetIncomeState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getNetIncomeStatsUseCase(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Net Income stats', failure);

        final metrics =
            (analyticsSession ??
                    NetIncomeTabViewState(
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

        emit(CompanyNetIncomeState.failure(failure));
      },
      (tuple) {
        final (stats, origin) = tuple;
        _logger.info('Successfully loaded Net Income stats (origin: $origin)');

        final metrics =
            (analyticsSession ??
                    NetIncomeTabViewState(
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
          CompanyNetIncomeState.loaded(
            ticker: event.ticker,
            netIncomeStats: stats,
            annualChartData: _toChartData(
              stats.annualNetIncome,
              isAnnual: true,
            ),
            quarterlyChartData: _toChartData(
              stats.quarterlyNetIncome,
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
    Emitter<CompanyNetIncomeState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Net Income stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyNetIncomeEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Net Income still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Net Income lastUpdated is null. Triggering load.');
          add(
            CompanyNetIncomeEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Net Income in failure state. Triggering retry.');
        add(
          CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Net Income in initial state. Triggering load.');
        add(
          CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      loading: (_) {
        _logger.info('Net Income already loading, skipping staleness check.');
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
}
