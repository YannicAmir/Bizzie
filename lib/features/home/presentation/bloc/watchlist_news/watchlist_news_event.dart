part of 'watchlist_news_bloc.dart';

@freezed
sealed class WatchlistNewsEvent with _$WatchlistNewsEvent {
  const factory WatchlistNewsEvent.loadRequested(List<String> tickers) =
      LoadRequested;
  const factory WatchlistNewsEvent.reset() = Reset;
}
