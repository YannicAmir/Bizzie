import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

final _logger = BizzieLogger('CompanySecurityBloc');

@injectable
class CompanySecurityBloc
    extends Bloc<CompanySecurityEvent, CompanySecurityState> {
  final GetSecurityDetailsUseCase _getSecurityDetailsUseCase;
  final SecurityTabAnalytics _tracker;

  final _sessionStopwatch = Stopwatch();
  final _loadStopwatch = Stopwatch();

  CompanySecurityBloc(this._getSecurityDetailsUseCase, this._tracker)
    : super(const CompanySecurityState.initial()) {
    on<CompanySecurityEvent>(_onEvent, transformer: sequential());
  }

  Future<void> _onEvent(
    CompanySecurityEvent event,
    Emitter<CompanySecurityState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
      tabShown: (_) async => _onTabShown(),
      tabHidden: (_) async => _onTabHidden(),
      appBackgrounded: (_) async => _onAppBackgrounded(),
      appForegrounded: (_) async => _onAppForegrounded(),
      priceAnalyticsUpdated: (e) async => _onPriceAnalyticsUpdated(e, emit),
      earningsAnalyticsUpdated: (e) async =>
          _onEarningsAnalyticsUpdated(e, emit),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading Security: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Security details for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanySecurityState.loading());

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getSecurityDetailsUseCase(event.ticker);
    _loadStopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Security details', failure);
        emit(CompanySecurityState.failure(failure));
      },
      (tuple) {
        final details = tuple.$1;
        final origin = tuple.$2;

        _logger.info(
          'Successfully loaded Security details for ${event.ticker}',
        );

        final analytics = SecurityTabViewState(
          ticker: event.ticker,
          securityType: details.isEtf
              ? 'etf'
              : details.isFund
              ? 'fund'
              : 'company',
          loadTimeMs: _loadStopwatch.elapsedMilliseconds,
          isSuccess: true,
          dataSource: origin,
        );

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
      },
    );
  }

  Future<void> _onTabShown() async {
    _logger.info('Security Tab Shown - Starting session tracker');
    _sessionStopwatch.start();
  }

  Future<void> _onTabHidden() async {
    _logger.info('Security Tab Hidden - Logging final summary');
    await _logSummary(isFinal: true);
    _sessionStopwatch.stop();
    _sessionStopwatch.reset();
  }

  Future<void> _onAppBackgrounded() async {
    if (_sessionStopwatch.isRunning) {
      _logger.info('App Backgrounded - Logging interim summary');
      await _logSummary(isFinal: false);
      _sessionStopwatch.stop();
    }
  }

  Future<void> _onAppForegrounded() async {
    _logger.info('App Foregrounded - Resuming session tracker');
    _sessionStopwatch.start();
  }

  Future<void> _onPriceAnalyticsUpdated(
    PriceAnalyticsUpdated event,
    Emitter<CompanySecurityState> emit,
  ) async {
    state.mapOrNull(
      loaded: (s) {
        emit(
          s.copyWith(
            analyticsState: s.analyticsState.copyWith(
              priceLoadMs: event.loadTimeMs ?? s.analyticsState.priceLoadMs,
              isPriceSuccess:
                  event.isSuccess ?? s.analyticsState.isPriceSuccess,
              finalPriceTimeframe:
                  event.finalTimeframe ?? s.analyticsState.finalPriceTimeframe,
              priceChartChangeCount:
                  event.chartChangeCount ??
                  s.analyticsState.priceChartChangeCount,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onEarningsAnalyticsUpdated(
    EarningsAnalyticsUpdated event,
    Emitter<CompanySecurityState> emit,
  ) async {
    state.mapOrNull(
      loaded: (s) {
        emit(
          s.copyWith(
            analyticsState: s.analyticsState.copyWith(
              hasUpcomingEarnings:
                  event.hasUpcoming ?? s.analyticsState.hasUpcomingEarnings,
              earningsDaysAway:
                  event.daysAway ?? s.analyticsState.earningsDaysAway,
            ),
          ),
        );
      },
    );
  }

  Future<void> _logSummary({required bool isFinal}) async {
    final analytics = state.maybeMap(
      loaded: (s) => s.analyticsState,
      unsupported: (s) => s.analyticsState,
      orElse: () => null,
    );

    if (analytics != null) {
      final updated = analytics.copyWith(
        viewDurationSec: _sessionStopwatch.elapsed.inSeconds,
      );
      await _tracker.logViewSummary(updated, isFinal: isFinal);
    }
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Security stale (TTL expired: ${difference.inHours}h). Triggering load.',
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
