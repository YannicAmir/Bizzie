part of 'market_news_bloc.dart';

@freezed
abstract class MarketNewsState with _$MarketNewsState {
  const factory MarketNewsState.initial() = _Initial;
  const factory MarketNewsState.loading() = _Loading;
  const factory MarketNewsState.loaded(List<MarketNewsArticle> articles) =
      MarketNewsLoaded;
  const factory MarketNewsState.failure(Failure failure) = _Failure;
}
