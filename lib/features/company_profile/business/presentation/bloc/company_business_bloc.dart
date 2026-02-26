import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyBusinessBloc');

@injectable
class CompanyBusinessBloc
    extends Bloc<CompanyBusinessEvent, CompanyBusinessState> {
  final GetBusinessProfileUseCase _getBusinessProfileUseCase;
  final IConfigService _configService;
  final BusinessTabAnalytics _analytics;

  BusinessTabViewState? _analyticsSessionState;
  Stopwatch? _viewStopwatch;
  Stopwatch? _loadStopwatch;

  CompanyBusinessBloc(
    this._getBusinessProfileUseCase,
    this._configService,
    this._analytics,
  ) : super(const CompanyBusinessState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: droppable(),
    );
    on<TabShown>(_onTabShown, transformer: sequential());
    on<TabHidden>(_onTabHidden, transformer: sequential());
    on<AppBackgrounded>(_onAppBackgrounded, transformer: sequential());
    on<AppForegrounded>(_onAppForegrounded, transformer: sequential());
    on<AnalyticsInteractionOccurred>(
      _onAnalyticsInteractionOccurred,
      transformer: sequential(),
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
    _loadStopwatch = Stopwatch()..start();

    final result = await _getBusinessProfileUseCase(event.ticker);

    _loadStopwatch?.stop();

    result.fold(
      (failure) {
        _analyticsSessionState = _analyticsSessionState?.copyWith(
          isSuccess: false,
          loadTimeMs: _loadStopwatch?.elapsedMilliseconds,
        );
        _logger.severe('Failed to load company business profile', failure);
        emit(CompanyBusinessState.failure(failure));
      },
      (tuple) {
        final profile = tuple.$1;
        final origin = tuple.$2;

        _analyticsSessionState = _analyticsSessionState?.copyWith(
          isSuccess: true,
          loadTimeMs: _loadStopwatch?.elapsedMilliseconds,
          dataSource: origin,
        );
        _logger.info('Successfully loaded company business profile');
        emit(
          CompanyBusinessState.loaded(
            profile,
            historyLimit: _configService.freePlanHistoryCount,
            dataOrigin: origin,
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
    _viewStopwatch = Stopwatch()..start();
    _analyticsSessionState = BusinessTabViewState(ticker: event.ticker);
  }

  Future<void> _onAnalyticsInteractionOccurred(
    AnalyticsInteractionOccurred event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    if (_analyticsSessionState == null) return;

    _analyticsSessionState = _analyticsSessionState!.copyWith(
      tappedWebsite:
          event.tappedWebsite ?? _analyticsSessionState!.tappedWebsite,
      tappedProxy: event.tappedProxy ?? _analyticsSessionState!.tappedProxy,
      didExpandDescription:
          event.didExpandDescription ??
          _analyticsSessionState!.didExpandDescription,
      viewed10Ks: event.viewed10Ks ?? _analyticsSessionState!.viewed10Ks,
      viewed10Qs: event.viewed10Qs ?? _analyticsSessionState!.viewed10Qs,
      viewAll10KsTapped:
          event.viewAll10KsTapped ?? _analyticsSessionState!.viewAll10KsTapped,
      viewAll10QsTapped:
          event.viewAll10QsTapped ?? _analyticsSessionState!.viewAll10QsTapped,
    );
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    _viewStopwatch?.stop();
    if (_analyticsSessionState != null) {
      final finalState = _analyticsSessionState!.copyWith(
        viewDurationSec: _viewStopwatch?.elapsed.inSeconds ?? 0,
      );
      await _analytics.logViewSummary(finalState, isFinal: true);
      _analyticsSessionState = null;
    }
    _viewStopwatch = null;
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    if (_analyticsSessionState != null) {
      final snapshotState = _analyticsSessionState!.copyWith(
        viewDurationSec: _viewStopwatch?.elapsed.inSeconds ?? 0,
      );
      await _analytics.logViewSummary(snapshotState, isFinal: false);
    }
  }

  Future<void> _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    _viewStopwatch?.start();
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
