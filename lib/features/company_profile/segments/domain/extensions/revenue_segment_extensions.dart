import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';

extension RevenueSegmentExtensions on RevenueSegment {
  double? growthPercentFor(String topic, {required RevenueSegment? previous}) {
    final currentValue = data[topic];
    final previousValue = previous?.data[topic];
    if (currentValue == null || previousValue == null || previousValue == 0) {
      return null;
    }
    return (currentValue - previousValue) / previousValue.abs() * 100;
  }
}
