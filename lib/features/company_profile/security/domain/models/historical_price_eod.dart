import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price_eod.freezed.dart';

@freezed
abstract class HistoricalPriceEod with _$HistoricalPriceEod {
  const factory HistoricalPriceEod({
    required String symbol,
    required String date,
    required double price,
    required double volume,
  }) = _HistoricalPriceEod;
}
