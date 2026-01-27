import 'package:freezed_annotation/freezed_annotation.dart';

part 'ratios_dto.freezed.dart';
part 'ratios_dto.g.dart';

@freezed
abstract class RatiosDto with _$RatiosDto {
  const factory RatiosDto({
    String? symbol,
    String? date,
    String? period,
    double? priceToEarningsRatio,
    double? priceToFreeCashFlowRatio,
  }) = _RatiosDto;

  factory RatiosDto.fromJson(Map<String, dynamic> json) =>
      _$RatiosDtoFromJson(json);
}
