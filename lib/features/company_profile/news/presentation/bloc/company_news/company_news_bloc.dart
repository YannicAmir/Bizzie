import 'dart:async';

import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
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
        > {
  final GetCompanyNewsUseCase _getCompanyNews;
  final NewsTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;

  final Stopwatch _loadStopwatch = Stopwatch();
  StreamSubscription<TabActivation>? _tabSubscription;

  @override
  NewsTabAnalytics get analyticsTracker => _analytics;

  CompanyNewsBloc(this._getCompanyNews, this._analytics, this._watchActiveTabUseCase)
    : super(const CompanyNewsState.initial()) {
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
        'Company news already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading company news for ${event.ticker} (force=${event.forceRefresh})',
    );

    if (event.forceRefresh) {
      updateAnalyticsState(
        (current) => current.copyWith(
          refreshTriggeredCount: current.refreshTriggeredCount + 1,
        ),
      );
    }

    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyNewsState.loading());
    }

    _loadStopwatch.reset();
    _loadStopwatch.start();

    final result = await _getCompanyNews(event.ticker);
    _loadStopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load company news', failure);
        emit(CompanyNewsState.failure(failure));
      },
      (tuple) {
        final news = tuple.$1;
        final origin = tuple.$2;
        _logger.info(
          'Successfully loaded company news: ${news.articles.length} articles, origin=$origin',
        );

        final analytics = NewsTabViewState(
          ticker: event.ticker,
          timestamp: DateTime.now().toIso8601String(),
          loadTimeMs: _loadStopwatch.elapsedMilliseconds,
          isSuccess: true,
          dataSource: origin,
        );

        updateAnalyticsState((_) => analytics);

        emit(
          CompanyNewsState.loaded(
            articles: news.articles,
            ticker: event.ticker,
            dataOrigin: origin,
            analyticsState: analytics,
            lastUpdated: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> _onTabShown(
    TabShown event,
    Emitter<CompanyNewsState> emit,
  ) async {
    final initialState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => NewsTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );

    onTabShown(event.ticker, initialState!);
    add(CompanyNewsEvent.stalenessCheckRequested(event.ticker));
  }

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
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inMinutes >= 5) {
            _logger.info(
              'Company news stale (TTL expired: ${difference.inMinutes}m). Triggering load.',
            );
            add(
              CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info(
              'Company news still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info('Company news lastUpdated is null. Triggering load.');
          add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('Company news in failure state. Triggering retry.');
        add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('Company news in initial state. Triggering load.');
        add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }
}
