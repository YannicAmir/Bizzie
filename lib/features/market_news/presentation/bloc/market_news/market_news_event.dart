import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_news_event.freezed.dart';

@freezed
sealed class MarketNewsEvent with _$MarketNewsEvent {
  const factory MarketNewsEvent.loadRequested() = LoadRequested;
}
