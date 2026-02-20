import 'package:bizzie/features/home/presentation/analytics/home_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeAnalytics _analytics;
  DateTime? _loadStartTime;

  HomeBloc(this._analytics) : super(const HomeState.initial()) {
    on<_Started>(_onStarted);
    on<_SearchTapped>(_onSearchTapped);
    on<_WatchlistTapped>(_onWatchlistTapped);
    on<_EmptyStateViewed>(_onEmptyStateViewed);
    on<_WatchlistLoadFailed>(_onWatchlistLoadFailed);
    on<_WatchlistLoaded>(_onWatchlistLoaded);
  }

  void _onStarted(_Started event, Emitter<HomeState> emit) {
    _loadStartTime = DateTime.now();
    _analytics.logHomeViewed();
  }

  void _onSearchTapped(_SearchTapped event, Emitter<HomeState> emit) {
    // Redundant event. SearchPage logs page_viewed with source context.
  }

  void _onWatchlistTapped(_WatchlistTapped event, Emitter<HomeState> emit) {
    _analytics.logHomeWatchlistTapped(ticker: event.ticker);
  }

  void _onEmptyStateViewed(_EmptyStateViewed event, Emitter<HomeState> emit) {
    _analytics.logHomeEmptyStateViewed();
  }

  void _onWatchlistLoadFailed(
    _WatchlistLoadFailed event,
    Emitter<HomeState> emit,
  ) {
    _analytics.logHomeWatchlistError(message: event.error);
  }

  void _onWatchlistLoaded(_WatchlistLoaded event, Emitter<HomeState> emit) {
    final now = DateTime.now();
    final durationMs = _loadStartTime != null
        ? now.difference(_loadStartTime!).inMilliseconds
        : 0;

    _analytics.logHomeWatchlistLoaded(
      itemCount: event.itemCount,
      durationMs: durationMs,
    );
  }
}
