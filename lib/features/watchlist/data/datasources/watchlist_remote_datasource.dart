import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

abstract class IWatchlistRemoteDataSource {
  Future<void> addWatchlistItem(WatchlistItemDto item, String uid);
  Future<void> removeWatchlistItem(String ticker, String uid);
  Stream<List<WatchlistItemDto>> getWatchlistStream(String uid);
}

@Injectable(as: IWatchlistRemoteDataSource)
class WatchlistRemoteDataSource implements IWatchlistRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistRemoteDataSource(this._firestoreService);

  @override
  Future<void> addWatchlistItem(WatchlistItemDto item, String uid) async {
    final path = 'users/$uid/watchlist/${item.ticker}';

    await _firestoreService.setDocument(path: path, data: item.toJson());
  }

  @override
  Future<void> removeWatchlistItem(String ticker, String uid) async {
    final path = 'users/$uid/watchlist/$ticker';
    await _firestoreService.deleteDocument(path: path);
  }

  @override
  Stream<List<WatchlistItemDto>> getWatchlistStream(String uid) {
    final path = 'users/$uid/watchlist';
    return _firestoreService.getCollectionStream(path: path).map((snapshot) {
      return snapshot.docs
          .map((doc) => WatchlistItemDto.fromJson(doc.data()))
          .toList();
    });
  }
}
