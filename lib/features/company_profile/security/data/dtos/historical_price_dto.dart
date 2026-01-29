import 'package:bizzie/features/company_profile/security/domain/models/price_point.dart';
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

  const HistoricalPriceDto._();

  factory HistoricalPriceDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceDtoFromJson(json);

  PricePoint toDomain() {
    return PricePoint(date: date, close: price ?? 0, volume: volume);
  }
}
