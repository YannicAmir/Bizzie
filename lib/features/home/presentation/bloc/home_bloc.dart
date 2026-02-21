import 'package:bizzie/features/home/presentation/analytics/home_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeAnalytics _analytics;

  HomeBloc(this._analytics) : super(const HomeState.initial()) {
    on<_Started>(_onStarted, transformer: droppable());
    on<_WatchlistTapped>(_onWatchlistTapped, transformer: droppable());
    on<_EmptyStateViewed>(_onEmptyStateViewed, transformer: droppable());
    on<_WatchlistLoadFailed>(_onWatchlistLoadFailed, transformer: droppable());
  }

  void _onStarted(_Started event, Emitter<HomeState> emit) {
    _analytics.logHomeViewed();
  }

  void _onWatchlistTapped(_WatchlistTapped event, Emitter<HomeState> emit) {
    _analytics.logHomeWatchlistTapped(
      ticker: event.ticker,
      eventText: event.eventText,
      isUpcoming: event.isUpcoming,
    );
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
}
