import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_news_event.freezed.dart';

@freezed
sealed class WatchlistNewsEvent with _$WatchlistNewsEvent {
  const factory WatchlistNewsEvent.loadRequested(List<String> tickers) =
      LoadRequested;
  const factory WatchlistNewsEvent.reset() = Reset;
}
