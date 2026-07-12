import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/market_hours_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanySecurityBloc');

const _securityTypeEtf = 'etf';
const _securityTypeFund = 'fund';
const _securityTypeCompany = 'company';
const _securityTypePending = 'pending';

@injectable
class CompanySecurityBloc
    extends Bloc<CompanySecurityEvent, CompanySecurityState>
    with
        CompanyProfileAnalyticsMixin<
          CompanySecurityEvent,
          CompanySecurityState,
          SecurityTabViewState
        >,
        AuthSessionResetMixin<CompanySecurityEvent, CompanySecurityState> {
  final GetSecurityDetailsUseCase _getSecurityDetailsUseCase;
  final SecurityTabAnalytics _tracker;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final MarketHoursFreshnessService _freshnessService;
  final ITimeProvider _timeProvider;

  final _loadStopwatch = Stopwatch();
  StreamSubscription<TabActivation>? _tabSubscription;

  @override
  SecurityTabAnalytics get analyticsTracker => _tracker;

  CompanySecurityBloc(
    this._getSecurityDetailsUseCase,
    this._tracker,
    this._watchActiveTabUseCase,
    this._freshnessService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanySecurityState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<TabShown>(_onTabShown);
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<PriceAnalyticsUpdated>(_onPriceAnalyticsUpdated);
    on<EarningsAnalyticsUpdated>(_onEarningsAnalyticsUpdated);
    on<SecurityReset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanySecurityEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.security)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loaded: (s) => s.analyticsState.ticker == activation.ticker,
            unsupported: (s) => s.analyticsState.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(
              CompanySecurityEvent.stalenessCheckRequested(activation.ticker),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
  ) async {
    final forceRefresh = event.forceRefresh ?? false;
    final isAlreadyLoaded = _isLoadedForTicker(event.ticker);

    if (!forceRefresh && isAlreadyLoaded) {
      _logger.info(
        'Skip loading Security: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Security details for ${event.ticker} (force=$forceRefresh)',
    );

    if (!isAlreadyLoaded) {
      emit(const CompanySecurityState.loading());
    }

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getSecurityDetailsUseCase(event.ticker);
    _loadStopwatch.stop();

    result.fold((failure) {
      _logger.severe('Failed to load Security details', failure);
      emit(CompanySecurityState.failure(failure));
    }, (tuple) => _emitLoadedState(event, emit, tuple));
  }

  bool _isLoadedForTicker(String ticker) => state.maybeMap(
    loaded: (s) => s.analyticsState.ticker == ticker,
    unsupported: (s) => s.analyticsState.ticker == ticker,
    orElse: () => false,
  );

  void _emitLoadedState(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
    (SecurityDetails, CompanyProfileDataOrigin) tuple,
  ) {
    final details = tuple.$1;
    final origin = tuple.$2;

    _logger.info('Successfully loaded Security details for ${event.ticker}');

    final analytics = SecurityTabViewState(
      ticker: event.ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      securityType: details.isEtf
          ? _securityTypeEtf
          : details.isFund
          ? _securityTypeFund
          : _securityTypeCompany,
      loadTimeMs: _loadStopwatch.elapsedMilliseconds,
      isSuccess: true,
      dataSource: origin,
    );

    updateAnalyticsState((current) => analytics);

    if (details.isEtf || details.isFund) {
      _logger.info(
        'Security is unsupported (ETF or Fund). Emitting unsupported state.',
      );
      emit(
        CompanySecurityState.unsupported(details, analyticsState: analytics),
      );
    } else {
      emit(
        CompanySecurityState.loaded(
          details,
          analyticsState: analytics,
          lastUpdated: _timeProvider.nowLocal,
        ),
      );
    }
  }

  void _onTabShown(TabShown event, Emitter<CompanySecurityState> emit) {
    _logger.info('Security Tab Shown - Starting session tracker');

    final initialState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      unsupported: (s) => s.analyticsState,
      orElse: () => SecurityTabViewState(
        ticker: event.ticker,
        securityType: _securityTypePending,
        timestamp: _timeProvider.nowLocal.toIso8601String(),
      ),
    );

    onTabShown(event.ticker, initialState);
  }

  void _onPriceAnalyticsUpdated(
    PriceAnalyticsUpdated event,
    Emitter<CompanySecurityState> emit,
  ) {
    updateAnalyticsState(
      (current) => current.copyWith(
        priceLoadMs: event.loadTimeMs ?? current.priceLoadMs,
        isPriceSuccess: event.isSuccess ?? current.isPriceSuccess,
        finalPriceTimeframe:
            event.finalTimeframe ?? current.finalPriceTimeframe,
        priceChartChangeCount:
            event.chartChangeCount ?? current.priceChartChangeCount,
      ),
    );

    final currentAnalytics = analyticsSession;
    if (currentAnalytics != null) {
      state.mapOrNull(
        loaded: (s) {
          emit(s.copyWith(analyticsState: currentAnalytics));
        },
        unsupported: (s) {
          emit(s.copyWith(analyticsState: currentAnalytics));
        },
      );
    }
  }

  void _onEarningsAnalyticsUpdated(
    EarningsAnalyticsUpdated event,
    Emitter<CompanySecurityState> emit,
  ) {
    state.mapOrNull(
      loaded: (s) {
        updateAnalyticsState(
          (current) => current.copyWith(
            hasUpcomingEarnings:
                event.hasUpcoming ?? current.hasUpcomingEarnings,
            earningsDaysAway: event.daysAway ?? current.earningsDaysAway,
          ),
        );

        final currentAnalytics = analyticsSession;
        if (currentAnalytics != null) {
          emit(s.copyWith(analyticsState: currentAnalytics));
        }
      },
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanySecurityState> emit,
  ) => onTabHidden();

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanySecurityState> emit,
  ) => onAppBackgrounded();

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanySecurityState> emit,
  ) => onAppForegrounded();

  void _onReset(SecurityReset event, Emitter<CompanySecurityState> emit) =>
      emit(const CompanySecurityState.initial());

  void _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanySecurityState> emit,
  ) {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _reloadIfStale(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerForcedReload(
        event.ticker,
        'Security in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerForcedReload(
        event.ticker,
        'Security in initial state. Triggering load.',
      ),
    );
  }

  void _reloadIfStale(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerForcedReload(
        ticker,
        'Security lastUpdated is null. Triggering load.',
      );
      return;
    }
    if (_freshnessService.isStale(lastUpdated)) {
      _triggerForcedReload(
        ticker,
        'Security stale (market hours freshness check). Triggering load.',
      );
    } else {
      _logger.info('Security still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerForcedReload(String ticker, String reason) {
    _logger.info(reason);
    add(CompanySecurityEvent.loadRequested(ticker, forceRefresh: true));
  }
}
