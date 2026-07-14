import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_period_key.dart';

extension CompanySegmentsLoadedX on CompanySegmentsLoaded {
  String? selectedKey({required bool isAnnual}) =>
      isAnnual ? selectedAnnualKey : selectedQuarterlyKey;

  List<String> periodKeys({required bool isAnnual}) =>
      isAnnual ? annualPeriodKeys : quarterlyPeriodKeys;

  String get reportedCurrency => productSegments.reportedCurrency.isNotEmpty
      ? productSegments.reportedCurrency
      : geographicSegments.reportedCurrency;

  RevenueSegment? productSegmentForKey(String? key, {required bool isAnnual}) =>
      _segmentForKey(
        isAnnual ? productSegments.annual : productSegments.quarterly,
        key,
        isAnnual: isAnnual,
      );

  RevenueSegment? geographicSegmentForKey(
    String? key, {
    required bool isAnnual,
  }) => _segmentForKey(
    isAnnual ? geographicSegments.annual : geographicSegments.quarterly,
    key,
    isAnnual: isAnnual,
  );

  String pairLabel(String key, {required bool isAnnual}) {
    final previousKey = SegmentPeriodKey.previous(key, isAnnual: isAnnual);
    final hasPrevious =
        previousKey != null &&
        (productSegmentForKey(previousKey, isAnnual: isAnnual) != null ||
            geographicSegmentForKey(previousKey, isAnnual: isAnnual) != null);
    return hasPrevious ? '$key, $previousKey' : key;
  }

  RevenueSegment? _segmentForKey(
    List<RevenueSegment> segments,
    String? key, {
    required bool isAnnual,
  }) {
    if (key == null) return null;
    for (final segment in segments) {
      if (SegmentPeriodKey.of(segment, isAnnual: isAnnual) == key) {
        return segment;
      }
    }
    return null;
  }
}
