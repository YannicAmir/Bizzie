import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';

abstract class SegmentPeriodKey {
  static String annual(RevenueSegment segment) =>
      segment.fiscalYear.toString();

  static String quarterly(RevenueSegment segment) =>
      '${segment.period} ${segment.fiscalYear}';

  static String? previous(String key, {required bool isAnnual}) {
    if (isAnnual) {
      final year = int.tryParse(key);
      return year == null ? null : (year - 1).toString();
    }

    final parts = key.split(' ');
    if (parts.length != 2) return null;
    final year = int.tryParse(parts[1]);
    return year == null ? null : '${parts[0]} ${year - 1}';
  }

  static String of(RevenueSegment segment, {required bool isAnnual}) =>
      isAnnual ? annual(segment) : quarterly(segment);
}
