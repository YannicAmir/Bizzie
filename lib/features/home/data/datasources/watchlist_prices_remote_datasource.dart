import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistPricesRemoteDataSource');

@Injectable(as: IWatchlistPricesRemoteDataSource)
class WatchlistPricesRemoteDataSource
    implements IWatchlistPricesRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistPricesRemoteDataSource(this._firestoreService);

  @override
  Stream<List<WatchlistStockPriceDto>> getWatchlistPricesStream(
    List<String> tickers,
  ) {
    _logger.info(
      'Requesting stock prices stream for ${tickers.length} tickers',
    );

    return _firestoreService
        .getCollectionStreamChunked<WatchlistStockPriceDto>(
          path: FirestoreConstants.stockPrices,
          whereInField: FirestoreConstants.ticker,
          values: tickers,
          fromJson: WatchlistStockPriceDto.fromJson,
        )
        .handleError((Object e, StackTrace s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'Stock prices stream permission denied (expected on logout)',
            );
            Error.throwWithStackTrace(PermissionDeniedException(), s);
          }
          _logger.severe('Error in stock prices stream', e, s);
          Error.throwWithStackTrace(e, s);
        });
  }
}
