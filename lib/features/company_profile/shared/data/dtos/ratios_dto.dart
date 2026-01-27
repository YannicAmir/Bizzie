import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio.dart';
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

  const RatiosDto._();

  factory RatiosDto.fromJson(Map<String, dynamic> json) =>
      _$RatiosDtoFromJson(json);

  PeRatio toPeRatio() {
    return PeRatio(
      symbol: symbol ?? '',
      date: date ?? '',
      period: period ?? '',
      priceToEarningsRatio: priceToEarningsRatio ?? 0,
    );
  }

  PfcfRatio toPfcfRatio() {
    return PfcfRatio(
      symbol: symbol ?? '',
      date: date ?? '',
      period: period ?? '',
      priceToFreeCashFlowRatio: priceToFreeCashFlowRatio ?? 0,
    );
  }
}
