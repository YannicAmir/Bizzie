import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/watchlist/constants/watchlist_constants.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_remote_datasource.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistEventsRemoteDataSource');

@LazySingleton(as: IWatchlistEventsRemoteDataSource)
class WatchlistEventsRemoteDataSourceImpl
    implements IWatchlistEventsRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistEventsRemoteDataSourceImpl(this._firestoreService);

  @override
  Future<List<WatchlistEarningsDto>> getUpcomingEarnings(
    List<String> tickers,
  ) async {
    try {
      if (tickers.isEmpty) return [];

      final chunks = _chunkList(tickers, WatchlistConstants.firestoreChunkSize);
      _logger.info(
        'Fetching upcoming earnings in ${chunks.length} chunks for ${tickers.length} tickers',
      );

      final futures = chunks.map((chunk) {
        return _firestoreService.getCollectionFuture<WatchlistEarningsDto>(
          path: FirestoreConstants.upcomingEarnings,
          whereInField: FirestoreConstants.symbol,
          whereInValues: chunk,
          fromJson: WatchlistEarningsDto.fromJson,
          toJson: (dto) => dto.toJson(),
        );
      });

      final results = await Future.wait(futures);
      final flattened = results.expand((element) => element).toList();

      _logger.info(
        'Successfully fetched ${flattened.length} upcoming earnings',
      );
      return flattened;
    } catch (e, stack) {
      _logger.severe('Failed to fetch upcoming earnings', e, stack);
      throw ServerException(message: 'Failed to fetch upcoming earnings: $e');
    }
  }

  @override
  Future<List<WatchlistFilingDto>> getSecFilings(List<String> tickers) async {
    try {
      if (tickers.isEmpty) return [];

      final chunks = _chunkList(tickers, WatchlistConstants.firestoreChunkSize);
      _logger.info(
        'Fetching SEC filings in ${chunks.length} chunks for ${tickers.length} tickers',
      );

      final futures = chunks.map((chunk) {
        return _firestoreService.getCollectionFuture<WatchlistFilingDto>(
          path: FirestoreConstants.secFilings,
          whereInField: FirestoreConstants.symbol,
          whereInValues: chunk,
          fromJson: WatchlistFilingDto.fromJson,
          toJson: (dto) => dto.toJson(),
        );
      });

      final results = await Future.wait(futures);
      final flattened = results.expand((element) => element).toList();

      _logger.info('Successfully fetched ${flattened.length} SEC filings');
      return flattened;
    } catch (e, stack) {
      _logger.severe('Failed to fetch SEC filings', e, stack);
      throw ServerException(message: 'Failed to fetch SEC filings: $e');
    }
  }

  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
          i,
          i + chunkSize > list.length ? list.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }
}
