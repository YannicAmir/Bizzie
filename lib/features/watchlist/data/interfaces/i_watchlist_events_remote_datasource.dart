import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';

abstract class IWatchlistEventsRemoteDataSource {
  Future<List<WatchlistEarningsDto>> getUpcomingEarnings(List<String> tickers);
  Future<List<WatchlistFilingDto>> getSecFilings(List<String> tickers);
}
