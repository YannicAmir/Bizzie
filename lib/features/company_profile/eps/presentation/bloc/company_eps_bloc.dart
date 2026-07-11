import 'dart:async';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_view_state.dart';
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
import 'company_eps_event.dart';
import 'company_eps_state.dart';

final _logger = BizzieLogger('CompanyEpsBloc');

@injectable
class CompanyEpsBloc extends Bloc<CompanyEpsEvent, CompanyEpsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyEpsEvent,
          CompanyEpsState,
          EpsTabViewState
        > {
  final GetEpsStatsUseCase _getEpsStatsUseCase;
  final IConfigService _configService;
  final EpsTabAnalytics _epsTabAnalytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyEpsBloc(
    this._getEpsStatsUseCase,
    this._configService,
    this._epsTabAnalytics,
    this._watchActiveTabUseCase,
  ) : super(const CompanyEpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<Reset>((_, emit) => emit(const CompanyEpsState.initial()));
    _setupAnalyticsHandlers();
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.eps)
        .listen((activation) {
            final shouldHandle = state.maybeMap(
              loading: (_) => false,
              loaded: (s) => s.ticker == activation.ticker,
              orElse: () => true,
            );
            if (shouldHandle) {
                          add(CompanyEpsEvent.stalenessCheckRequested(activation.ticker));
            }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<EpsTabViewState> get analyticsTracker =>
      _epsTabAnalytics;

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyEpsState> emit,
  ) async {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );

    onTabShown(
      event.ticker,
      EpsTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
        loadTimeMs: existingState?.loadTimeMs,
        isSuccess: existingState?.isSuccess ?? false,
        dataSource: existingState?.dataSource,
      ),
    );    add(CompanyEpsEvent.stalenessCheckRequested(event.ticker));
  }

  Future<void> _onPeriodViewed(
    PeriodViewed event,
    Emitter<CompanyEpsState> emit,
  ) async {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlyEpsTab: true)
          : s.copyWith(viewedQtrlyEpsTab: true),
    );  }

  Future<void> _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyEpsState> emit,
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
    );  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyEpsState> emit,
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
        'Company EPS already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading EPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyEpsState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getEpsStatsUseCase(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load EPS stats', failure);
        final metrics =
            (analyticsSession ??
                    EpsTabViewState(
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
        emit(CompanyEpsState.failure(failure));
      },
      (tuple) {
        final (stats, origin) = tuple;
        _logger.info('Successfully loaded EPS stats (origin: $origin)');

        final metrics =
            (analyticsSession ??
                    EpsTabViewState(
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
          CompanyEpsState.loaded(
            ticker: event.ticker,
            epsStats: stats,
            annualChartData: _toChartData(stats.annualEps, isAnnual: true),
            quarterlyChartData: _toChartData(
              stats.quarterlyEps,
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
    Emitter<CompanyEpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'EPS stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('EPS still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('EPS lastUpdated is null. Triggering load.');
          add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('EPS in failure state. Triggering retry.');
        add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('EPS in initial state. Triggering load.');
        add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      loading: (_) {
        _logger.info('EPS already loading, skipping staleness check.');
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
