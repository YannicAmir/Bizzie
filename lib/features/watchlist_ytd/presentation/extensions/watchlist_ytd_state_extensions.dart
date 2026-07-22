import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';

extension WatchlistYtdStateX on WatchlistYtdState {
  List<YtdPriceChange> orderedChanges(List<String> tickerOrder) {
    return maybeMap(
      loaded: (loaded) {
        if (tickerOrder.isEmpty) return loaded.changes.values.toList();
        return [
          for (final ticker in tickerOrder)
            if (loaded.changes[ticker] case final change?) change,
        ];
      },
      orElse: () => const <YtdPriceChange>[],
    );
  }
}
