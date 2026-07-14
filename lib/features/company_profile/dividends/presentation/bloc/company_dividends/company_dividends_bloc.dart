import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_analytics.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_view_state.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyDividendsBloc');

@injectable
class CompanyDividendsBloc
    extends Bloc<CompanyDividendsEvent, CompanyDividendsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyDividendsEvent,
          CompanyDividendsState,
          DividendTabViewState
        >,
        AuthSessionResetMixin<CompanyDividendsEvent, CompanyDividendsState> {
  static const int _staleTtlHours = 24;

  final GetDividendInfoUseCase _getDividendInfo;
  final IConfigService _configService;
  final DividendTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyDividendsBloc(
    this._getDividendInfo,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyDividendsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<ViewAllTapped>(_onViewAllTapped);
    on<Reset>((_, emit) => emit(const CompanyDividendsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyDividendsEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.dividends)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(
              CompanyDividendsEvent.stalenessCheckRequested(activation.ticker),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<DividendTabViewState> get analyticsTracker =>
      _analytics;

  void _onTabShown(TabShown event, Emitter<CompanyDividendsState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    add(CompanyDividendsEvent.stalenessCheckRequested(event.ticker));
  }

  DividendTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );
    return DividendTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onViewAllTapped(
    ViewAllTapped event,
    Emitter<CompanyDividendsState> emit,
  ) {
    updateAnalyticsState(
      (s) => event.isChart
          ? s.copyWith(tappedChartViewAll: true)
          : s.copyWith(tappedTableViewAll: true),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    if (_shouldSkipLoad(event)) {
      _logger.info(
        'Company Dividends already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading dividends for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyDividendsState.loading());

    final stopwatch = Stopwatch()..start();
    final result = await _getDividendInfo(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) => _emitLoadFailure(failure, event, stopwatch, emit),
      (loaded) => _emitLoadSuccess(loaded, event, stopwatch, emit),
    );
  }

  bool _shouldSkipLoad(LoadRequested event) {
    final isLoadedForTicker = state.maybeMap(
      loaded: (s) => s.ticker == event.ticker,
      orElse: () => false,
    );
    return isLoadedForTicker && !event.forceRefresh;
  }

  void _emitLoadFailure(
    Failure failure,
    LoadRequested event,
    Stopwatch stopwatch,
    Emitter<CompanyDividendsState> emit,
  ) {
    _logger.severe('Failed to load dividends', failure);
    final metrics = _buildLoadMetrics(
      event.ticker,
      stopwatch,
      isSuccess: false,
    );
    updateAnalyticsState((_) => metrics);
    emit(CompanyDividendsState.failure(failure));
  }

  void _emitLoadSuccess(
    (DividendInfo, CompanyProfileDataOrigin) loaded,
    LoadRequested event,
    Stopwatch stopwatch,
    Emitter<CompanyDividendsState> emit,
  ) {
    final (info, origin) = loaded;
    _logger.info('Successfully loaded dividends, origin=$origin');
    final metrics = _buildLoadMetrics(
      event.ticker,
      stopwatch,
      isSuccess: true,
      dataSource: origin,
    );
    updateAnalyticsState((_) => metrics);
    emit(
      CompanyDividendsState.loaded(
        ticker: event.ticker,
        dividendInfo: info,
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        lastUpdated: _timeProvider.nowLocal,
        analyticsState: metrics,
      ),
    );
  }

  DividendTabViewState _buildLoadMetrics(
    String ticker,
    Stopwatch stopwatch, {
    required bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final base =
        analyticsSession ??
        DividendTabViewState(
          ticker: ticker,
          timestamp: _timeProvider.nowLocal.toIso8601String(),
        );
    final metrics = base.copyWith(
      isSuccess: isSuccess,
      loadTimeMs: stopwatch.elapsedMilliseconds,
    );
    return dataSource == null
        ? metrics
        : metrics.copyWith(dataSource: dataSource);
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        _evaluateLoadedStaleness(event.ticker, loadedState.lastUpdated);
      },
      failure: (_) {
        _logger.info('Dividends in failure state. Triggering retry.');
        _triggerForceRefresh(event.ticker);
      },
      initial: (_) {
        _logger.info('Dividends in initial state. Triggering load.');
        _triggerForceRefresh(event.ticker);
      },
      loading: (_) {
        _logger.info('Dividends already loading, skipping staleness check.');
      },
    );
  }

  void _evaluateLoadedStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _logger.info('Dividends lastUpdated is null. Triggering load.');
      _triggerForceRefresh(ticker);
      return;
    }
    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inHours >= _staleTtlHours) {
      _logger.info(
        'Dividends stale (TTL expired: ${difference.inHours}h). Triggering load.',
      );
      _triggerForceRefresh(ticker);
    } else {
      _logger.info('Dividends still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerForceRefresh(String ticker) {
    add(CompanyDividendsEvent.loadRequested(ticker, forceRefresh: true));
  }
}
