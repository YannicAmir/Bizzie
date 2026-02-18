part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.searchTapped() = _SearchTapped;
  const factory HomeEvent.watchlistTapped({required String ticker}) =
      _WatchlistTapped;
  const factory HomeEvent.emptyStateViewed() = _EmptyStateViewed;
}
