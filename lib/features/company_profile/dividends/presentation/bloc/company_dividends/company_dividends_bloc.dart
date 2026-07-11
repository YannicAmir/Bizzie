import 'dart:async';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
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
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        > {
  final GetDividendInfoUseCase _getDividendInfo;
  final IConfigService _configService;
  final DividendTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanyDividendsBloc(
    this._getDividendInfo,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
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
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );

    onTabShown(
      event.ticker,
      DividendTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
        loadTimeMs: existingState?.loadTimeMs,
        isSuccess: existingState?.isSuccess ?? false,
        dataSource: existingState?.dataSource,
      ),
    );
    add(CompanyDividendsEvent.stalenessCheckRequested(event.ticker));
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
        'Company Dividends already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading dividends for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyDividendsState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getDividendInfo(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load dividends', failure);

        final metrics =
            (analyticsSession ??
                    DividendTabViewState(
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

        emit(CompanyDividendsState.failure(failure));
      },
      (tuple) {
        final info = tuple.$1;
        final origin = tuple.$2;
        _logger.info('Successfully loaded dividends, origin=$origin');

        final metrics =
            (analyticsSession ??
                    DividendTabViewState(
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
          CompanyDividendsState.loaded(
            ticker: event.ticker,
            dividendInfo: info,
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
    Emitter<CompanyDividendsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Dividends stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyDividendsEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Dividends still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Dividends lastUpdated is null. Triggering load.');
          add(
            CompanyDividendsEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Dividends in failure state. Triggering retry.');
        add(
          CompanyDividendsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Dividends in initial state. Triggering load.');
        add(
          CompanyDividendsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      loading: (_) {
        _logger.info('Dividends already loading, skipping staleness check.');
      },
    );
  }
}
