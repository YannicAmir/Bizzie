import 'dart:async';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/market_news/data/dtos/market_news_dto.dart';
import 'package:bizzie/features/market_news/data/interfaces/i_market_news_remote_datasource.dart';
import 'package:bizzie/features/market_news/domain/interfaces/i_market_news_repository.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketNewsRepositoryImpl');

@LazySingleton(as: IMarketNewsRepository)
class MarketNewsRepositoryImpl implements IMarketNewsRepository {
  final IMarketNewsRemoteDataSource _remoteDataSource;

  MarketNewsRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<Failure, List<MarketNewsArticle>>> watchMarketNews() {
    return _remoteDataSource
        .getMarketNewsStream()
        .transform(
          StreamTransformer<
            List<MarketNewsDto>,
            Either<Failure, List<MarketNewsArticle>>
          >.fromHandlers(
            handleData: (dtos, sink) {
              try {
                sink.add(Right(dtos.map((dto) => dto.toDomain()).toList()));
              } catch (e, stack) {
                _logger.severe('Failed to map market news stream', e, stack);
                sink.add(Left(Failure.server(e.toString())));
              }
            },
            handleError: (error, stack, sink) {
              _logger.severe('Market news stream error', error, stack);
              sink.add(Left(Failure.server(error.toString())));
            },
          ),
        );
  }
}
