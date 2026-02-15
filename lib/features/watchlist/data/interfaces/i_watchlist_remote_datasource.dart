import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';

abstract class IWatchlistRemoteDataSource {
  Future<void> addWatchlistItem(WatchlistItemDto item, String uid);
  Future<void> removeWatchlistItem(String ticker, String uid);
  Stream<List<WatchlistItemDto>> getWatchlistStream(String uid);
}
