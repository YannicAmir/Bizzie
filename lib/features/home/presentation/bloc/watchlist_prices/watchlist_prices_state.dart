import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_prices_state.freezed.dart';

@freezed
abstract class WatchlistPricesState with _$WatchlistPricesState {
  const factory WatchlistPricesState.initial() = _Initial;
  const factory WatchlistPricesState.loading() = _Loading;
  const factory WatchlistPricesState.disabled() = _Disabled;
  const factory WatchlistPricesState.loaded(
    Map<String, WatchlistStockPrice> prices,
  ) = WatchlistPricesLoaded;
  const factory WatchlistPricesState.failure(Failure failure) = _Failure;
}
