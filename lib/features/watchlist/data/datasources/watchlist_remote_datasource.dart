import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistRemoteDataSource');

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
    _logger.info('Adding item to watchlist: ${item.ticker} for UID: $uid');
    final path = 'users/$uid/watchlist/${item.ticker}';

    try {
      await _firestoreService.setDocument<WatchlistItemDto>(
        path: path,
        value: item,
        toJson: (dto) => dto.toJson(),
      );
      _logger.info('Successfully added ${item.ticker} to watchlist');
    } catch (e, s) {
      _logger.severe('Failed to add ${item.ticker} to watchlist', e, s);
      rethrow;
    }
  }

  @override
  Future<void> removeWatchlistItem(String ticker, String uid) async {
    _logger.info('Removing item from watchlist: $ticker for UID: $uid');
    final path = 'users/$uid/watchlist/$ticker';
    try {
      await _firestoreService.deleteDocument(path: path);
      _logger.info('Successfully removed $ticker from watchlist');
    } catch (e, s) {
      _logger.severe('Failed to remove $ticker from watchlist', e, s);
      rethrow;
    }
  }

  @override
  Stream<List<WatchlistItemDto>> getWatchlistStream(String uid) {
    _logger.info('Requesting Watchlist stream for UID: $uid');
    final path = 'users/$uid/watchlist';
    return _firestoreService
        .getCollectionStream<WatchlistItemDto>(
          path: path,
          fromJson: WatchlistItemDto.fromJson,
          toJson: (dto) => dto.toJson(),
        )
        .handleError((e, s) {
          _logger.severe('Error in Watchlist stream for UID: $uid', e, s);
        });
  }
}
