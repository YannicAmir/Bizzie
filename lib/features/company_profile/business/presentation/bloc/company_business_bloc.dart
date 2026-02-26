import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyBusinessBloc');

@injectable
class CompanyBusinessBloc
    extends Bloc<CompanyBusinessEvent, CompanyBusinessState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyBusinessEvent,
          CompanyBusinessState,
          BusinessTabViewState
        > {
  final GetBusinessProfileUseCase _getBusinessProfileUseCase;
  final IConfigService _configService;
  final BusinessTabAnalytics _analytics;

  final Stopwatch _loadStopwatch = Stopwatch();

  @override
  BusinessTabAnalytics get analyticsTracker => _analytics;

  CompanyBusinessBloc(
    this._getBusinessProfileUseCase,
    this._configService,
    this._analytics,
  ) : super(const CompanyBusinessState.initial()) {
    on<CompanyBusinessEvent>(_onEvent, transformer: sequential());
  }

  Future<void> _onEvent(
    CompanyBusinessEvent event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e, emit),
      tabShown: (e) async => _onTabShown(e, emit),
      tabHidden: (_) async => onTabHidden(),
      appBackgrounded: (_) async => onAppBackgrounded(),
      appForegrounded: (_) async => onAppForegrounded(),
      analyticsInteractionOccurred: (e) async =>
          _onAnalyticsInteractionOccurred(e, emit),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (s) => s.businessProfile.symbol == event.ticker,
      orElse: () => false,
    );

    if (!event.forceRefresh && isAlreadyLoaded) {
      _logger.info(
        'Skip loading company business: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading company business profile for ${event.ticker} (force=${event.forceRefresh})',
    );

    if (!isAlreadyLoaded) {
      emit(const CompanyBusinessState.loading());
    }

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getBusinessProfileUseCase(event.ticker);
    _loadStopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load company business profile', failure);
        emit(CompanyBusinessState.failure(failure));
      },
      (tuple) {
        final profile = tuple.$1;
        final origin = tuple.$2;

        _logger.info('Successfully loaded company business profile');

        final analytics = BusinessTabViewState(
          ticker: event.ticker,
          timestamp: DateTime.now().toIso8601String(),
          loadTimeMs: _loadStopwatch.elapsedMilliseconds,
          isSuccess: true,
          dataSource: origin,
        );

        updateAnalyticsState((_) => analytics);

        emit(
          CompanyBusinessState.loaded(
            profile,
            analyticsState: analytics,
            historyLimit: _configService.freePlanHistoryCount,
            lastUpdated: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    final initialState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => BusinessTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );

    onTabShown(event.ticker, initialState);
  }

  Future<void> _onAnalyticsInteractionOccurred(
    AnalyticsInteractionOccurred event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    updateAnalyticsState(
      (current) => current.copyWith(
        tappedWebsite: event.tappedWebsite ?? current.tappedWebsite,
        tappedProxy: event.tappedProxy ?? current.tappedProxy,
        didExpandDescription:
            event.didExpandDescription ?? current.didExpandDescription,
        viewed10Ks: event.viewed10Ks ?? current.viewed10Ks,
        viewed10Qs: event.viewed10Qs ?? current.viewed10Qs,
        viewAll10KsTapped: event.viewAll10KsTapped ?? current.viewAll10KsTapped,
        viewAll10QsTapped: event.viewAll10QsTapped ?? current.viewAll10QsTapped,
      ),
    );

    final currentAnalytics = analyticsSession;
    if (currentAnalytics != null) {
      state.mapOrNull(
        loaded: (s) {
          emit(s.copyWith(analyticsState: currentAnalytics));
        },
      );
    }
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Company business stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyBusinessEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info(
              'Company business still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info(
            'Company business lastUpdated is null. Triggering load.',
          );
          add(
            CompanyBusinessEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Company business in failure state. Triggering retry.');
        add(
          CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Company business in initial state. Triggering load.');
        add(
          CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
