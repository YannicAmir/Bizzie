import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_ytd_event.freezed.dart';

@freezed
sealed class WatchlistYtdEvent with _$WatchlistYtdEvent {
  const factory WatchlistYtdEvent.loadRequested(List<String> tickers) =
      LoadRequested;
  const factory WatchlistYtdEvent.reset() = Reset;
}
