import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist_ytd/domain/interfaces/i_watchlist_ytd_repository.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetWatchlistYtdUseCase');

@lazySingleton
class GetWatchlistYtdUseCase
    implements UseCase<Either<Failure, List<YtdPriceChange>>, List<String>> {
  final IWatchlistYtdRepository _repository;

  GetWatchlistYtdUseCase(this._repository);

  @override
  Future<Either<Failure, List<YtdPriceChange>>> call(List<String> tickers) {
    _logger.info(
      'Executing GetWatchlistYtdUseCase: Requesting YTD price change for '
      '${tickers.length} tickers',
    );

    return _repository.getWatchlistYtd(tickers);
  }
}
