import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/market_news/domain/interfaces/i_market_news_repository.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchMarketNewsUseCase
    implements
        StreamUseCase<Either<Failure, List<MarketNewsArticle>>, NoParams> {
  final IMarketNewsRepository _repository;

  WatchMarketNewsUseCase(this._repository);

  @override
  Stream<Either<Failure, List<MarketNewsArticle>>> call(NoParams params) {
    return _repository.watchMarketNews();
  }
}
