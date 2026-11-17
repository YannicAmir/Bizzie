import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = HomeStarted;
  const factory HomeEvent.watchlistTapped({
    required String ticker,
    String? eventText,
    bool? isUpcoming,
  }) = HomeWatchlistTapped;
  const factory HomeEvent.emptyStateViewed() = HomeEmptyStateViewed;
  const factory HomeEvent.watchlistLoadFailed({required String error}) =
      HomeWatchlistLoadFailed;
  const factory HomeEvent.newsArticleTapped({
    required String ticker,
    required String site,
  }) = HomeNewsArticleTapped;
  const factory HomeEvent.newsLoadFailed({required String error}) =
      HomeNewsLoadFailed;
}
