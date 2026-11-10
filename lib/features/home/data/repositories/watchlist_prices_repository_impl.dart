import 'dart:async';

import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_prices_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistPricesRepositoryImpl');

@LazySingleton(as: IWatchlistPricesRepository)
class WatchlistPricesRepositoryImpl implements IWatchlistPricesRepository {
  final IWatchlistPricesRemoteDataSource _remoteDataSource;

  WatchlistPricesRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<Failure, List<WatchlistStockPrice>>> watchWatchlistPrices(
    List<String> tickers,
  ) {
    return _remoteDataSource
        .getWatchlistPricesStream(tickers)
        .transform(
          StreamTransformer<
            List<WatchlistStockPriceDto>,
            Either<Failure, List<WatchlistStockPrice>>
          >.fromHandlers(
            handleData: (dtos, sink) {
              try {
                sink.add(Right(dtos.map((dto) => dto.toDomain()).toList()));
              } catch (e, stack) {
                _logger.severe(
                  'Failed to map watchlist prices stream',
                  e,
                  stack,
                );
                sink.add(Left(Failure.server(e.toString())));
              }
            },
            handleError: (error, stack, sink) {
              sink.add(
                Left(
                  error is PermissionDeniedException
                      ? const Failure.permission()
                      : Failure.server(error.toString()),
                ),
              );
            },
          ),
        );
  }
}
