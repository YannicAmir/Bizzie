import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/watchlist_ytd/data/dtos/ytd_price_change_dto.dart';
import 'package:bizzie/features/watchlist_ytd/data/interfaces/i_watchlist_ytd_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistYtdRemoteDataSource');

@Injectable(as: IWatchlistYtdRemoteDataSource)
class WatchlistYtdRemoteDataSource implements IWatchlistYtdRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistYtdRemoteDataSource(this._firestoreService);

  @override
  Future<List<YtdPriceChangeDto>> getWatchlistYtd(List<String> tickers) async {
    if (tickers.isEmpty) return [];

    _logger.info('Fetching YTD price change for ${tickers.length} tickers');

    try {
      return await _firestoreService
          .getCollectionFutureChunked<YtdPriceChangeDto>(
        path: FirestoreConstants.ytdPriceChange,
        whereInField: FirestoreConstants.ticker,
        values: tickers,
        fromJson: YtdPriceChangeDto.fromJson,
        toJson: (dto) => dto.toJson(),
      );
    } catch (e, s) {
      _logger.severe('Failed to fetch watchlist YTD price change', e, s);
      rethrow;
    }
  }
}
