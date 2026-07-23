import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_prices_state_extensions.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';

enum HomeLoadStatus { loading, failure, empty, ready }

HomeLoadStatus resolveHomeLoadStatus(
  WatchlistState watchlist,
  WatchlistPricesState prices,
  WatchlistNewsState news,
) {
  final watchlistStatus = watchlist.map(
    initial: (_) => HomeLoadStatus.loading,
    loading: (_) => HomeLoadStatus.loading,
    success: (_) => HomeLoadStatus.loading,
    failure: (_) => HomeLoadStatus.failure,
    loaded: (loaded) => loaded.companies.isEmpty
        ? HomeLoadStatus.empty
        : HomeLoadStatus.ready,
  );

  if (watchlistStatus != HomeLoadStatus.ready) return watchlistStatus;

  return _secondaryFeedsSettled(prices, news)
      ? HomeLoadStatus.ready
      : HomeLoadStatus.loading;
}

bool _secondaryFeedsSettled(
  WatchlistPricesState prices,
  WatchlistNewsState news,
) {
  final pricesSettled = prices.isSettled;
  final newsSettled = news.maybeMap(
    loaded: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );
  return pricesSettled && newsSettled;
}
