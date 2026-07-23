import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_prices_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWatchlistPricesUseCase
    implements
        UseCase<Either<Failure, List<WatchlistStockPrice>>, List<String>> {
  final IWatchlistPricesRepository _repository;

  GetWatchlistPricesUseCase(this._repository);

  @override
  Future<Either<Failure, List<WatchlistStockPrice>>> call(
    List<String> params,
  ) {
    return _repository.getWatchlistPrices(params);
  }
}
