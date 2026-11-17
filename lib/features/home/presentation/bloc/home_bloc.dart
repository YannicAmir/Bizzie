import 'package:bizzie/features/home/presentation/analytics/home_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeAnalytics _analytics;

  HomeBloc(this._analytics) : super(const HomeState.initial()) {
    on<HomeStarted>(_onStarted, transformer: droppable());
    on<HomeWatchlistTapped>(_onWatchlistTapped, transformer: droppable());
    on<HomeEmptyStateViewed>(_onEmptyStateViewed, transformer: droppable());
    on<HomeWatchlistLoadFailed>(
      _onWatchlistLoadFailed,
      transformer: droppable(),
    );
    on<HomeNewsArticleTapped>(_onNewsArticleTapped, transformer: droppable());
    on<HomeNewsLoadFailed>(_onNewsLoadFailed, transformer: droppable());
  }

  void _onStarted(HomeStarted event, Emitter<HomeState> emit) {
    _analytics.logHomeViewed();
  }

  void _onWatchlistTapped(HomeWatchlistTapped event, Emitter<HomeState> emit) {
    _analytics.logHomeWatchlistTapped(
      ticker: event.ticker,
      eventText: event.eventText,
      isUpcoming: event.isUpcoming,
    );
  }

  void _onEmptyStateViewed(
    HomeEmptyStateViewed event,
    Emitter<HomeState> emit,
  ) {
    _analytics.logHomeEmptyStateViewed();
  }

  void _onWatchlistLoadFailed(
    HomeWatchlistLoadFailed event,
    Emitter<HomeState> emit,
  ) {
    _analytics.logHomeWatchlistError(message: event.error);
  }

  void _onNewsArticleTapped(
    HomeNewsArticleTapped event,
    Emitter<HomeState> emit,
  ) {
    _analytics.logHomeNewsArticleTapped(ticker: event.ticker, site: event.site);
  }

  void _onNewsLoadFailed(HomeNewsLoadFailed event, Emitter<HomeState> emit) {
    _analytics.logHomeNewsLoadError(message: event.error);
  }
}
