import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price_dto.freezed.dart';
part 'historical_price_dto.g.dart';

@freezed
abstract class HistoricalPriceDto with _$HistoricalPriceDto {
  const factory HistoricalPriceDto({
    required String date,
    double? price,
    double? close,
    double? volume,
  }) = _HistoricalPriceDto;

  factory HistoricalPriceDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceDtoFromJson(json);
}
