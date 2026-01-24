import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price_eod_dto.freezed.dart';
part 'historical_price_eod_dto.g.dart';

@freezed
abstract class HistoricalPriceEodDto with _$HistoricalPriceEodDto {
  const factory HistoricalPriceEodDto({
    required String symbol,
    required String date,
    required double price,
    required double volume,
  }) = _HistoricalPriceEodDto;

  factory HistoricalPriceEodDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceEodDtoFromJson(json);
}

extension HistoricalPriceEodDtoX on HistoricalPriceEodDto {
  HistoricalPriceEod toDomain() {
    return HistoricalPriceEod(
      symbol: symbol,
      date: date,
      price: price,
      volume: volume,
    );
  }
}
