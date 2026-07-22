import 'package:bizzie/features/home/data/dtos/watchlist_news_dto.dart';

abstract class IWatchlistNewsRemoteDataSource {
  Stream<List<WatchlistNewsDto>> getWatchlistNewsStream(List<String> tickers);
}
