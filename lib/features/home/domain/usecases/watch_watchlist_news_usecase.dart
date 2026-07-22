import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_news_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchWatchlistNewsUseCase
    implements
        StreamUseCase<
          Either<Failure, List<WatchlistNewsArticle>>,
          List<String>
        > {
  final IWatchlistNewsRepository _repository;

  WatchWatchlistNewsUseCase(this._repository);

  @override
  Stream<Either<Failure, List<WatchlistNewsArticle>>> call(
    List<String> tickers,
  ) {
    return _repository.watchWatchlistNews(tickers);
  }
}
