import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_product_segments.freezed.dart';

@freezed
abstract class RevenueProductSegments with _$RevenueProductSegments {
  const factory RevenueProductSegments({
    required String symbol,
    required String reportedCurrency,
    required List<RevenueSegment> annual,
    required List<RevenueSegment> quarterly,
  }) = _RevenueProductSegments;
}
