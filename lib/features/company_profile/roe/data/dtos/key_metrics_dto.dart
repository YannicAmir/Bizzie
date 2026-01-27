import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_metrics_dto.freezed.dart';
part 'key_metrics_dto.g.dart';

@freezed
abstract class KeyMetricsDto with _$KeyMetricsDto {
  const factory KeyMetricsDto({
    String? symbol,
    String? date,
    String? period,
    double? returnOnEquity,
  }) = _KeyMetricsDto;

  const KeyMetricsDto._();

  factory KeyMetricsDto.fromJson(Map<String, dynamic> json) =>
      _$KeyMetricsDtoFromJson(json);

  Roe toRoe() {
    return Roe(
      symbol: symbol ?? '',
      date: date ?? '',
      period: period ?? '',
      returnOnEquity: returnOnEquity ?? 0,
    );
  }
}
