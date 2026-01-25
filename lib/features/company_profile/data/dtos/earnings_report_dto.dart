import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'earnings_report_dto.g.dart';
part 'earnings_report_dto.freezed.dart';

@freezed
abstract class EarningsReportDto with _$EarningsReportDto {
  const factory EarningsReportDto({
    required String symbol,
    required String date,
    double? epsActual,
    double? epsEstimated,
    int? revenueActual,
    int? revenueEstimated,
    String? lastUpdated,
  }) = _EarningsReportDto;

  factory EarningsReportDto.fromJson(Map<String, dynamic> json) =>
      _$EarningsReportDtoFromJson(json);
}
