import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/chart_data_presentation_extensions.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:bizzie/features/company_profile/shares/domain/services/shares_summary_service.dart';
import 'package:bizzie/features/company_profile/shares/domain/usecases/get_shares_usecase.dart';
import 'package:bizzie/features/company_profile/shares/presentation/analytics/shares_tab_analytics.dart';
import 'package:bizzie/features/company_profile/shares/presentation/analytics/shares_tab_view_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'company_shares_event.dart';
import 'company_shares_state.dart';

final _logger = BizzieLogger('CompanySharesBloc');

@injectable
class CompanySharesBloc extends Bloc<CompanySharesEvent, CompanySharesState>
    with
        CompanyProfileAnalyticsMixin<
          CompanySharesEvent,
          CompanySharesState,
          SharesTabViewState
        >,
        AuthSessionResetMixin<CompanySharesEvent, CompanySharesState>,
        CompanyProfileLoadGuardMixin {
  final GetSharesUseCase _getShares;
  final IConfigService _configService;
  final SharesTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;
  final SharesSummaryService _summaryService;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanySharesBloc(
    this._getShares,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    this._summaryService,
    GetAuthStream getAuthStream,
  ) : super(const CompanySharesState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodChanged>(_onPeriodChanged);
    on<ViewAllTapped>(_onViewAllTapped);
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanySharesEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.shares)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(CompanySharesEvent.stalenessCheckRequested(activation.ticker));
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<SharesTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company Shares';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  void _onTabShown(TabShown event, Emitter<CompanySharesState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    state.mapOrNull(
      loaded: (s) => _markVisiblePeriodViewedFor(
        isAnnualView: s.isAnnualView,
        hasData: s.isAnnualView
            ? s.annualChartData.isNotEmpty
            : s.quarterlyChartData.isNotEmpty,
      ),
    );
    add(CompanySharesEvent.stalenessCheckRequested(event.ticker));
  }

  SharesTabViewState _buildTabShownViewState(String ticker) =>
      SharesTabViewState(
        ticker: ticker,
        timestamp: _timeProvider.nowLocal.toIso8601String(),
      );

  void _onPeriodChanged(PeriodChanged event, Emitter<CompanySharesState> emit) {
    state.mapOrNull(
      loaded: (s) => emit(s.copyWith(isAnnualView: event.isAnnual)),
    );
    _markPeriodViewed(isAnnual: event.isAnnual);
  }

  void _markPeriodViewed({required bool isAnnual}) {
    updateAnalyticsState(
      (s) => isAnnual
          ? s.copyWith(viewedYearlySharesTab: true)
          : s.copyWith(viewedQtrlySharesTab: true),
    );
  }

  void _markVisiblePeriodViewedFor({
    required bool isAnnualView,
    required bool hasData,
  }) {
    if (hasData) {
      _markPeriodViewed(isAnnual: isAnnualView);
    }
  }

  void _onViewAllTapped(ViewAllTapped event, Emitter<CompanySharesState> emit) {
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
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    final wasAnnualView =
        state.mapOrNull(loaded: (s) => s.isAnnualView) ?? true;
    emit(const CompanySharesState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getShares(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Shares stats', failure);
        _recordLoadMetrics(
          isSuccess: false,
          loadTimeMs: stopwatch.elapsedMilliseconds,
        );
        emit(CompanySharesState.failure(failure));
      },
      (tuple) => _emitLoadedState(
        ticker: event.ticker,
        tuple: tuple,
        loadTimeMs: stopwatch.elapsedMilliseconds,
        isAnnualView: wasAnnualView,
        emit: emit,
      ),
    );
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

  void _emitLoadedState({
    required String ticker,
    required (ShareStats, CompanyProfileDataOrigin) tuple,
    required int loadTimeMs,
    required bool isAnnualView,
    required Emitter<CompanySharesState> emit,
  }) {
    final (data, origin) = tuple;
    _logger.info('Successfully loaded Shares stats (origin: $origin)');

    emit(
      CompanySharesState.loaded(
        ticker: ticker,
        shareStats: data,
        annualChartData: data.annualWeightedAverageShares
            .toChartDataSortedByDate(isAnnual: true),
        quarterlyChartData: data.quarterlyWeightedAverageShares
            .toChartDataSortedByDate(isAnnual: false),
        annualSummary: _summaryService.computeSummary(
          data.annualWeightedAverageShares,
          isAnnual: true,
        ),
        quarterlySummary: _summaryService.computeSummary(
          data.quarterlyWeightedAverageShares,
          isAnnual: false,
        ),
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        isAnnualView: isAnnualView,
        lastUpdated: _timeProvider.nowLocal,
      ),
    );
    state.mapOrNull(
      loaded: (s) => _markVisiblePeriodViewedFor(
        isAnnualView: s.isAnnualView,
        hasData: s.isAnnualView
            ? s.annualChartData.isNotEmpty
            : s.quarterlyChartData.isNotEmpty,
      ),
    );

    _recordLoadMetrics(
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );
  }

  Future<void> _onReset(Reset event, Emitter<CompanySharesState> emit) async {
    _logger.info('Resetting Shares state.');
    emit(const CompanySharesState.initial());
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'Shares in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'Shares in initial state. Triggering load.',
      ),
      loading: (_) =>
          _logger.info('Shares already loading, skipping staleness check.'),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerRefresh(ticker, 'Shares lastUpdated is null. Triggering load.');
      return;
    }
    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inHours >= 24) {
      _triggerRefresh(
        ticker,
        'Shares stale (TTL expired: ${difference.inHours}h). Triggering load.',
      );
    } else {
      _logger.info('Shares still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanySharesEvent.loadRequested(ticker, forceRefresh: true));
  }
}
