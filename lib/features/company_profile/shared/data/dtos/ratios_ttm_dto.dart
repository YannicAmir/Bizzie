import 'package:freezed_annotation/freezed_annotation.dart';

part 'ratios_ttm_dto.freezed.dart';
part 'ratios_ttm_dto.g.dart';

@freezed
abstract class RatiosTtmDto with _$RatiosTtmDto {
  const factory RatiosTtmDto({
    String? symbol,
    double? priceToEarningsRatioTTM,
    double? priceToFreeCashFlowRatioTTM,
  }) = _RatiosTtmDto;

  const RatiosTtmDto._();

  factory RatiosTtmDto.fromJson(Map<String, dynamic> json) =>
      _$RatiosTtmDtoFromJson(json);
}
