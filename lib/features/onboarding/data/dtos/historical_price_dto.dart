import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price_dto.freezed.dart';
part 'historical_price_dto.g.dart';

@freezed
abstract class HistoricalPriceDto with _$HistoricalPriceDto {
  const factory HistoricalPriceDto({
    required String symbol,
    required String date,
    required double price,
    required int volume,
  }) = _HistoricalPriceDto;

  const HistoricalPriceDto._();

  factory HistoricalPriceDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceDtoFromJson(json);

  HistoricalPrice toDomain() {
    return HistoricalPrice(
      symbol: symbol,
      date: date,
      price: price,
      volume: volume,
    );
  }
}
