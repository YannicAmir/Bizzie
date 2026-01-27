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

  factory KeyMetricsDto.fromJson(Map<String, dynamic> json) =>
      _$KeyMetricsDtoFromJson(json);
}
