import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
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
        >,
        AuthSessionResetMixin<CompanyBusinessEvent, CompanyBusinessState>,
        CompanyProfileLoadGuardMixin {
  final GetBusinessProfileUseCase _getBusinessProfileUseCase;
  final IConfigService _configService;
  final BusinessTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final TabContentFreshnessService _freshnessService;
  final ITimeProvider _timeProvider;

  final Stopwatch _loadStopwatch = Stopwatch();
  StreamSubscription<TabActivation>? _tabSubscription;

  @override
  BusinessTabAnalytics get analyticsTracker => _analytics;

  @override
  String get featureName => 'Company Business';

  @override
  String? get loadedTicker =>
      state.mapOrNull(loaded: (s) => s.businessProfile.symbol);

  CompanyBusinessBloc(
    this._getBusinessProfileUseCase,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._freshnessService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyBusinessState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
    on<TabShown>(_onTabShown);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<AnalyticsInteractionOccurred>(_onAnalyticsInteractionOccurred);
    on<BusinessReset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanyBusinessEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.business)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loaded: (s) => s.businessProfile.symbol == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(
              CompanyBusinessEvent.stalenessCheckRequested(activation.ticker),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  Future<void> _onTabHidden(
    TabHidden event,
    Emitter<CompanyBusinessState> emit,
  ) => onTabHidden();

  Future<void> _onAppBackgrounded(
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
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading company business profile for ${event.ticker} (force=${event.forceRefresh})',
    );

    if (loadedTicker != event.ticker) {
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
      (tuple) =>
          _emitLoadedState(ticker: event.ticker, tuple: tuple, emit: emit),
    );
  }

  void _emitLoadedState({
    required String ticker,
    required (BusinessProfile, CompanyProfileDataOrigin) tuple,
    required Emitter<CompanyBusinessState> emit,
  }) {
    final (profile, origin) = tuple;
    _logger.info('Successfully loaded company business profile');

    final analytics = BusinessTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
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
        lastUpdated: _timeProvider.nowLocal,
      ),
    );
  }

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    add(CompanyBusinessEvent.stalenessCheckRequested(event.ticker));
  }

  BusinessTabViewState _buildTabShownViewState(String ticker) => state.maybeMap(
    loaded: (s) => s.analyticsState,
    orElse: () => BusinessTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
    ),
  );

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
      loaded: (loadedState) =>
          _evaluateStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'Company business in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'Company business in initial state. Triggering load.',
      ),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (_freshnessService.isStale(lastUpdated)) {
      _triggerRefresh(
        ticker,
        'Company business stale (last updated: $lastUpdated). Triggering load.',
      );
    } else {
      _logger.info('Company business still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyBusinessEvent.loadRequested(ticker, forceRefresh: true));
  }
}
