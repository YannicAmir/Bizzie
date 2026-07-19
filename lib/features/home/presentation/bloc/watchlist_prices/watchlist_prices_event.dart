import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_prices_event.freezed.dart';

@freezed
sealed class WatchlistPricesEvent with _$WatchlistPricesEvent {
  const factory WatchlistPricesEvent.loadRequested(List<String> tickers) =
      LoadRequested;
  const factory WatchlistPricesEvent.reset() = Reset;
}
