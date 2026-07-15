import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/news/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_state.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_analytics.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyNewsBloc');

@injectable
class CompanyNewsBloc extends Bloc<CompanyNewsEvent, CompanyNewsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyNewsEvent,
          CompanyNewsState,
          NewsTabViewState
        >,
        AuthSessionResetMixin<CompanyNewsEvent, CompanyNewsState> {
  final GetCompanyNewsUseCase _getCompanyNews;
  final NewsTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  final Stopwatch _loadStopwatch = Stopwatch();
  StreamSubscription<TabActivation>? _tabSubscription;

  @override
  NewsTabAnalytics get analyticsTracker => _analytics;

  CompanyNewsBloc(
    this._getCompanyNews,
    this._analytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyNewsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<ArticleTapped>(_onArticleTapped);
    on<Reset>((_, emit) => emit(const CompanyNewsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyNewsEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.news)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(CompanyNewsEvent.stalenessCheckRequested(activation.ticker));
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
    Emitter<CompanyNewsState> emit,
  ) async {
    if (_shouldSkipLoad(event)) {
      _logger.info(
        'Company news already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading company news for ${event.ticker} (force=${event.forceRefresh})',
    );

    _trackRefreshTriggered(event);
    emit(const CompanyNewsState.loading());

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getCompanyNews(event.ticker);
    _loadStopwatch.stop();

    result.fold((failure) {
      _logger.severe('Failed to load company news', failure);
      emit(CompanyNewsState.failure(failure));
    }, (tuple) => _emitLoaded(event.ticker, tuple.$1, tuple.$2, emit));
  }

  bool _shouldSkipLoad(LoadRequested event) {
    if (event.forceRefresh) return false;
    return state.maybeMap(
      loaded: (s) => s.ticker == event.ticker,
      orElse: () => false,
    );
  }

  void _trackRefreshTriggered(LoadRequested event) {
    if (!event.forceRefresh) return;
    updateAnalyticsState(
      (current) => current.copyWith(
        refreshTriggeredCount: current.refreshTriggeredCount + 1,
      ),
    );
  }

  void _emitLoaded(
    String ticker,
    CompanyNews news,
    CompanyProfileDataOrigin origin,
    Emitter<CompanyNewsState> emit,
  ) {
    _logger.info(
      'Successfully loaded company news: ${news.articles.length} articles, origin=$origin',
    );

    final analytics = _buildLoadedAnalytics(ticker, origin);
    updateAnalyticsState((_) => analytics);

    emit(
      CompanyNewsState.loaded(
        articles: news.articles,
        ticker: ticker,
        dataOrigin: origin,
        analyticsState: analytics,
        lastUpdated: _timeProvider.nowLocal,
      ),
    );
  }

  NewsTabViewState _buildLoadedAnalytics(
    String ticker,
    CompanyProfileDataOrigin origin,
  ) {
    return NewsTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: _loadStopwatch.elapsedMilliseconds,
      isSuccess: true,
      dataSource: origin,
    );
  }

  void _onTabShown(TabShown event, Emitter<CompanyNewsState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    add(CompanyNewsEvent.stalenessCheckRequested(event.ticker));
  }

  NewsTabViewState _buildTabShownViewState(String ticker) =>
      state.mapOrNull(loaded: (s) => s.analyticsState) ??
      NewsTabViewState(
        ticker: ticker,
        timestamp: _timeProvider.nowLocal.toIso8601String(),
      );

  Future<void> _onArticleTapped(
    ArticleTapped event,
    Emitter<CompanyNewsState> emit,
  ) async {
    updateAnalyticsState(
      (current) => current.copyWith(
        featuredArticleTapped: event.isFeatured
            ? true
            : current.featuredArticleTapped,
        normalArticleTapped: !event.isFeatured
            ? true
            : current.normalArticleTapped,
      ),
    );

    state.mapOrNull(
      loaded: (s) {
        final currentAnalytics = analyticsSession;
        if (currentAnalytics != null) {
          emit(s.copyWith(analyticsState: currentAnalytics));
        }
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyNewsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _refreshIfStale(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerForceRefresh(
        event.ticker,
        'Company news in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerForceRefresh(
        event.ticker,
        'Company news in initial state. Triggering load.',
      ),
    );
  }

  void _refreshIfStale(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerForceRefresh(
        ticker,
        'Company news lastUpdated is null. Triggering load.',
      );
      return;
    }

    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inMinutes >= 5) {
      _triggerForceRefresh(
        ticker,
        'Company news stale (TTL expired: ${difference.inMinutes}m). Triggering load.',
      );
    } else {
      _logger.info('Company news still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerForceRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanyNewsEvent.loadRequested(ticker, forceRefresh: true));
  }
}
