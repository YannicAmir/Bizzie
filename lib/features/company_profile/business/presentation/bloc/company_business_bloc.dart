import 'dart:async';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
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
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final TabContentFreshnessService _freshnessService;

  final Stopwatch _loadStopwatch = Stopwatch();
  StreamSubscription<TabActivation>? _tabSubscription;

  @override
  BusinessTabAnalytics get analyticsTracker => _analytics;

  CompanyBusinessBloc(
    this._getBusinessProfileUseCase,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._freshnessService,
  ) : super(const CompanyBusinessState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
    on<TabShown>(_onTabShown);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<AnalyticsInteractionOccurred>(_onAnalyticsInteractionOccurred);
    on<BusinessReset>(_onReset);
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.business)
        .listen((activation) {
            final shouldHandle = state.maybeMap(
              loaded: (s) => s.businessProfile.symbol == activation.ticker,
              orElse: () => true,
            );
            if (shouldHandle) {
              add(CompanyBusinessEvent.stalenessCheckRequested(activation.ticker));
            }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  void _onTabHidden(TabHidden event, Emitter<CompanyBusinessState> emit) =>
      onTabHidden();

  void _onAppBackgrounded(
    AppBackgrounded event,
    Emitter<CompanyBusinessState> emit,
  ) => onAppBackgrounded();

  void _onAppForegrounded(
    AppForegrounded event,
    Emitter<CompanyBusinessState> emit,
  ) => onAppForegrounded();

  void _onReset(BusinessReset event, Emitter<CompanyBusinessState> emit) =>
      emit(const CompanyBusinessState.initial());

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
    add(CompanyBusinessEvent.stalenessCheckRequested(event.ticker));
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
        if (_freshnessService.isStale(loadedState.lastUpdated)) {
          _logger.info(
            'Company business stale (last updated: ${loadedState.lastUpdated}). Triggering load.',
          );
          add(
            CompanyBusinessEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        } else {
          _logger.info(
            'Company business still fresh (Last updated: ${loadedState.lastUpdated})',
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
