import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price.freezed.dart';
part 'historical_price.g.dart';

@freezed
abstract class HistoricalPrice with _$HistoricalPrice {
  const factory HistoricalPrice({
    required String symbol,
    required String date,
    required double price,
    required int volume,
  }) = _HistoricalPrice;

  factory HistoricalPrice.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceFromJson(json);
}
