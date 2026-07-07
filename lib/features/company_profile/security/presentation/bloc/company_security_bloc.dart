import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/shared/utils/market_hours_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

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
        > {
  final GetSecurityDetailsUseCase _getSecurityDetailsUseCase;
  final SecurityTabAnalytics _tracker;

  final _loadStopwatch = Stopwatch();

  @override
  SecurityTabAnalytics get analyticsTracker => _tracker;

  CompanySecurityBloc(this._getSecurityDetailsUseCase, this._tracker)
    : super(const CompanySecurityState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<TabShown>(_onTabShown);
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<PriceAnalyticsUpdated>(_onPriceAnalyticsUpdated);
    on<EarningsAnalyticsUpdated>(_onEarningsAnalyticsUpdated);
    on<SecurityReset>(_onReset);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (s) => s.analyticsState.ticker == event.ticker,
      unsupported: (s) => s.analyticsState.ticker == event.ticker,
      orElse: () => false,
    );

    if (!event.forceRefresh && isAlreadyLoaded) {
      _logger.info(
        'Skip loading Security: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Security details for ${event.ticker} (force=${event.forceRefresh})',
    );

    if (!isAlreadyLoaded) {
      emit(const CompanySecurityState.loading());
    }

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getSecurityDetailsUseCase(event.ticker);
    _loadStopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Security details', failure);
        emit(CompanySecurityState.failure(failure));
      },
      (tuple) => _emitLoadedState(event, emit, tuple),
    );
  }

  void _emitLoadedState(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
    (SecurityDetails, CompanyProfileDataOrigin) tuple,
  ) {
    final details = tuple.$1;
    final origin = tuple.$2;

    _logger.info(
      'Successfully loaded Security details for ${event.ticker}',
    );

    final analytics = SecurityTabViewState(
      ticker: event.ticker,
      timestamp: DateTime.now().toIso8601String(),
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
        CompanySecurityState.unsupported(
          details,
          analyticsState: analytics,
        ),
      );
    } else {
      emit(
        CompanySecurityState.loaded(
          details,
          analyticsState: analytics,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  void _onTabShown(
    TabShown event,
    Emitter<CompanySecurityState> emit,
  ) {
    _logger.info('Security Tab Shown - Starting session tracker');

    final initialState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      unsupported: (s) => s.analyticsState,
      orElse: () => SecurityTabViewState(
        ticker: event.ticker,
        securityType: _securityTypePending,
        timestamp: DateTime.now().toIso8601String(),
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

  void _onTabHidden(TabHidden event, Emitter<CompanySecurityState> emit) =>
      onTabHidden();

  void _onAppBackgrounded(
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
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final isStale = MarketHoursHelper.isDataStale(lastUpdated);
          if (isStale) {
            _logger.info(
              'Security stale (MarketHoursHelper check). Triggering load.',
            );
            add(
              CompanySecurityEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Security still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Security lastUpdated is null. Triggering load.');
          add(
            CompanySecurityEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Security in failure state. Triggering retry.');
        add(
          CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Security in initial state. Triggering load.');
        add(
          CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
