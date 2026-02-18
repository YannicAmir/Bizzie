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

  HomeBloc(this._analytics) : super(const HomeState.initial()) {
    on<_Started>(_onStarted);
    on<_SearchTapped>(_onSearchTapped);
    on<_WatchlistTapped>(_onWatchlistTapped);
    on<_EmptyStateViewed>(_onEmptyStateViewed);
  }

  void _onStarted(_Started event, Emitter<HomeState> emit) {
    _analytics.logHomeViewed();
  }

  void _onSearchTapped(_SearchTapped event, Emitter<HomeState> emit) {
    _analytics.logHomeSearchTapped();
  }

  void _onWatchlistTapped(_WatchlistTapped event, Emitter<HomeState> emit) {
    _analytics.logHomeWatchlistTapped(ticker: event.ticker);
  }

  void _onEmptyStateViewed(_EmptyStateViewed event, Emitter<HomeState> emit) {
    _analytics.logHomeEmptyStateViewed();
  }
}
