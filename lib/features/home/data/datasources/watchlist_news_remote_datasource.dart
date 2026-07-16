import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_news_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_news_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistNewsRemoteDataSource');

const Duration _recencyWindow = Duration(days: 3);
const int _articlesPerChunkLimit = 10;

@Injectable(as: IWatchlistNewsRemoteDataSource)
class WatchlistNewsRemoteDataSource implements IWatchlistNewsRemoteDataSource {
  final FirestoreService _firestoreService;
  final ITimeProvider _timeProvider;

  WatchlistNewsRemoteDataSource(this._firestoreService, this._timeProvider);

  @override
  Stream<List<WatchlistNewsDto>> getWatchlistNewsStream(List<String> tickers) {
    _logger.info(
      'Requesting watchlist news stream for ${tickers.length} tickers',
    );
    final cutoff = _timeProvider.nowUtc.subtract(_recencyWindow);

    return _firestoreService
        .getCollectionStreamChunked<WatchlistNewsDto>(
          path: FirestoreConstants.stockNews,
          whereInField: FirestoreConstants.symbol,
          values: tickers,
          fromJson: WatchlistNewsDto.fromJson,
          toJson: (dto) => dto.toJson(),
          queryBuilder: (query) => query
              .where(
                FirestoreConstants.publishedAt,
                isGreaterThanOrEqualTo: cutoff,
              )
              .orderBy(FirestoreConstants.publishedAt, descending: true)
              .limit(_articlesPerChunkLimit),
        )
        .handleError((Object e, StackTrace s) {
          _logger.severe('Error in watchlist news stream', e, s);
          throw e;
        });
  }
}
