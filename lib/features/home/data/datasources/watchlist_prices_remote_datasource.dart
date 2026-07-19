import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistPricesRemoteDataSource');

@Injectable(as: IWatchlistPricesRemoteDataSource)
class WatchlistPricesRemoteDataSource
    implements IWatchlistPricesRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistPricesRemoteDataSource(this._firestoreService);

  @override
  Future<List<WatchlistStockPriceDto>> getWatchlistPrices(
    List<String> tickers,
  ) async {
    if (tickers.isEmpty) return [];

    _logger.info('Fetching stock prices for ${tickers.length} tickers');

    try {
      return await _firestoreService
          .getCollectionFutureChunked<WatchlistStockPriceDto>(
        path: FirestoreConstants.stockPrices,
        whereInField: FirestoreConstants.ticker,
        values: tickers,
        fromJson: WatchlistStockPriceDto.fromJson,
        toJson: (dto) => dto.toJson(),
      );
    } catch (e, s) {
      _logger.severe('Failed to fetch watchlist stock prices', e, s);
      rethrow;
    }
  }
}
