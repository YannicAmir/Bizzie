import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event.freezed.dart';

@freezed
sealed class WatchlistEvent with _$WatchlistEvent {
  const factory WatchlistEvent.syncRequested() = SyncRequested;
  const factory WatchlistEvent.addRequested({
    required String ticker,
    String? name,
    String? logoUrl,
    String? tabName,
    int? durationOnPageSeconds,
  }) = AddRequested;
  const factory WatchlistEvent.removeRequested({
    required String ticker,
    String? tabName,
    int? durationOnPageSeconds,
  }) = RemoveRequested;
  const factory WatchlistEvent.loadRequested({String? uid}) = LoadRequested;
  const factory WatchlistEvent.loadWatchlistEvents(List<String> tickers) =
      LoadWatchlistEvents;
  const factory WatchlistEvent.reset() = Reset;
}
