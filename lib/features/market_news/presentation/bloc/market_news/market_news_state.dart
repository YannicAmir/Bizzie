import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_news_state.freezed.dart';

@freezed
abstract class MarketNewsState with _$MarketNewsState {
  const factory MarketNewsState.initial() = _Initial;
  const factory MarketNewsState.loading() = _Loading;
  const factory MarketNewsState.loaded(List<MarketNewsArticle> articles) =
      MarketNewsLoaded;
  const factory MarketNewsState.failure(Failure failure) = _Failure;
}
