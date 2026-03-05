part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.watchlistTapped({
    required String ticker,
    String? eventText,
    bool? isUpcoming,
  }) = _WatchlistTapped;
  const factory HomeEvent.emptyStateViewed() = _EmptyStateViewed;
  const factory HomeEvent.watchlistLoadFailed({required String error}) =
      _WatchlistLoadFailed;
}
