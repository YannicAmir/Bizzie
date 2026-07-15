// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_segmentation_dto.freezed.dart';
part 'revenue_segmentation_dto.g.dart';

@freezed
abstract class RevenueSegmentationDto with _$RevenueSegmentationDto {
  @JsonSerializable()
  const factory RevenueSegmentationDto({
    String? symbol,
    int? fiscalYear,
    String? period,
    String? reportedCurrency,
    String? date,
    Map<String, double>? data,
  }) = _RevenueSegmentationDto;

  const RevenueSegmentationDto._();

  factory RevenueSegmentationDto.fromJson(Map<String, dynamic> json) =>
      _$RevenueSegmentationDtoFromJson(json);

  RevenueSegment toDomain({double multiplier = 1.0, String? targetCurrency}) {
    return RevenueSegment(
      date: date ?? '',
      fiscalYear: fiscalYear ?? 0,
      period: period ?? '',
      reportedCurrency: targetCurrency ?? reportedCurrency ?? '',
      data: (data ?? const {}).map(
        (label, value) => MapEntry(label, value * multiplier),
      ),
    );
  }
}
