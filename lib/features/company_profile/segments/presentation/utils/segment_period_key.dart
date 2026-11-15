import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';

abstract class SegmentPeriodKey {
  static String annual(RevenueSegment segment) => segment.fiscalYear.toString();

  static String quarterly(RevenueSegment segment) =>
      '${segment.period} ${segment.fiscalYear}';

  static String? previous(String key, {required FinancialPeriod period}) =>
      switch (period) {
        FinancialPeriod.annual => _previousAnnual(key),
        FinancialPeriod.quarterly => _previousQuarterly(key),
      };

  static String? _previousAnnual(String key) {
    final year = int.tryParse(key);
    return year == null ? null : (year - 1).toString();
  }

  static String? _previousQuarterly(String key) {
    final parts = key.split(' ');
    if (parts.length != 2) return null;
    final year = int.tryParse(parts[1]);
    return year == null ? null : '${parts[0]} ${year - 1}';
  }

  static String of(RevenueSegment segment, {required FinancialPeriod period}) =>
      switch (period) {
        FinancialPeriod.annual => annual(segment),
        FinancialPeriod.quarterly => quarterly(segment),
      };
}
