import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_period_key.dart';

extension CompanySegmentsLoadedX on CompanySegmentsLoaded {
  String? selectedKey({required FinancialPeriod period}) => switch (period) {
    FinancialPeriod.annual => selectedAnnualKey,
    FinancialPeriod.quarterly => selectedQuarterlyKey,
  };

  List<String> periodKeys({required FinancialPeriod period}) =>
      switch (period) {
        FinancialPeriod.annual => annualPeriodKeys,
        FinancialPeriod.quarterly => quarterlyPeriodKeys,
      };

  String get reportedCurrency => productSegments.reportedCurrency.isNotEmpty
      ? productSegments.reportedCurrency
      : geographicSegments.reportedCurrency;

  String? get originalCurrency =>
      productSegments.originalCurrency ?? geographicSegments.originalCurrency;

  RevenueSegment? productSegmentForKey(
    String? key, {
    required FinancialPeriod period,
  }) => _segmentForKey(
    switch (period) {
      FinancialPeriod.annual => productSegments.annual,
      FinancialPeriod.quarterly => productSegments.quarterly,
    },
    key,
    period: period,
  );

  RevenueSegment? geographicSegmentForKey(
    String? key, {
    required FinancialPeriod period,
  }) => _segmentForKey(
    switch (period) {
      FinancialPeriod.annual => geographicSegments.annual,
      FinancialPeriod.quarterly => geographicSegments.quarterly,
    },
    key,
    period: period,
  );

  String pairLabel(String key, {required FinancialPeriod period}) {
    final previousKey = SegmentPeriodKey.previous(key, period: period);
    final hasPrevious =
        previousKey != null &&
        (productSegmentForKey(previousKey, period: period) != null ||
            geographicSegmentForKey(previousKey, period: period) != null);
    return hasPrevious ? '$key, $previousKey' : key;
  }

  RevenueSegment? _segmentForKey(
    List<RevenueSegment> segments,
    String? key, {
    required FinancialPeriod period,
  }) {
    if (key == null) return null;
    for (final segment in segments) {
      if (SegmentPeriodKey.of(segment, period: period) == key) {
        return segment;
      }
    }
    return null;
  }
}
