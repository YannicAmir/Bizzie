import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/market_news/data/dtos/market_news_dto.dart';
import 'package:bizzie/features/market_news/data/interfaces/i_market_news_remote_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketNewsRemoteDataSource');

const Duration _recencyWindow = Duration(days: 3);
const int _articleLimit = 12;

@Injectable(as: IMarketNewsRemoteDataSource)
class MarketNewsRemoteDataSource implements IMarketNewsRemoteDataSource {
  final FirestoreService _firestoreService;
  final ITimeProvider _timeProvider;

  MarketNewsRemoteDataSource(this._firestoreService, this._timeProvider);

  @override
  Stream<List<MarketNewsDto>> getMarketNewsStream() {
    _logger.info('Requesting general market news stream');
    final cutoff = _timeProvider.nowUtc.subtract(_recencyWindow);

    return _firestoreService
        .getCollectionStream<MarketNewsDto>(
          path: FirestoreConstants.generalMarketNews,
          fromJson: MarketNewsDto.fromJson,
          toJson: (dto) => dto.toJson(),
          queryBuilder: (query) => query
              .where(
                FirestoreConstants.publishedAt,
                isGreaterThanOrEqualTo: cutoff,
              )
              .orderBy(FirestoreConstants.publishedAt, descending: true)
              .limit(_articleLimit),
        )
        .handleError((Object e, StackTrace s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'Market news stream permission denied (expected on logout)',
            );
          } else {
            _logger.severe('Error in market news stream', e, s);
          }
          Error.throwWithStackTrace(e, s);
        });
  }
}
