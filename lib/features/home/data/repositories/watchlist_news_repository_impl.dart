import 'dart:async';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_news_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_news_remote_datasource.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_news_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistNewsRepositoryImpl');

@LazySingleton(as: IWatchlistNewsRepository)
class WatchlistNewsRepositoryImpl implements IWatchlistNewsRepository {
  final IWatchlistNewsRemoteDataSource _remoteDataSource;

  WatchlistNewsRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<Failure, List<WatchlistNewsArticle>>> watchWatchlistNews(
    List<String> tickers,
  ) {
    return _remoteDataSource
        .getWatchlistNewsStream(tickers)
        .transform(
          StreamTransformer<
            List<WatchlistNewsDto>,
            Either<Failure, List<WatchlistNewsArticle>>
          >.fromHandlers(
            handleData: (dtos, sink) {
              try {
                sink.add(Right(dtos.map((dto) => dto.toDomain()).toList()));
              } catch (e, stack) {
                _logger.severe('Failed to map watchlist news stream', e, stack);
                sink.add(Left(Failure.server(e.toString())));
              }
            },
            handleError: (error, stack, sink) {
              _logger.severe('Watchlist news stream error', error, stack);
              sink.add(Left(Failure.server(error.toString())));
            },
          ),
        );
  }
}
