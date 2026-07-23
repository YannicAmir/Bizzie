part of 'market_news_bloc.dart';

@freezed
sealed class MarketNewsEvent with _$MarketNewsEvent {
  const factory MarketNewsEvent.loadRequested() = LoadRequested;
}
