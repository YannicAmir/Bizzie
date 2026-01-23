import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';

extension WatchlistStateX on WatchlistState {
  bool isInWatchlist(String ticker) {
    return maybeMap(
      loaded: (s) => s.companies.any((c) => c.ticker == ticker),
      orElse: () => false,
    );
  }
}
