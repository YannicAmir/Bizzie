import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';

extension WatchlistPricesStatePresentationX on WatchlistPricesState {
  bool get isSettled => maybeMap(
    loaded: (_) => true,
    disabled: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );
}
