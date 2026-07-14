import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_geographic_segments.freezed.dart';

@freezed
abstract class RevenueGeographicSegments with _$RevenueGeographicSegments {
  const factory RevenueGeographicSegments({
    required String symbol,
    required String reportedCurrency,
    required List<RevenueSegment> annual,
    required List<RevenueSegment> quarterly,
  }) = _RevenueGeographicSegments;
}
