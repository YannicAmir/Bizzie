import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_segment.freezed.dart';

@freezed
abstract class RevenueSegment with _$RevenueSegment {
  const factory RevenueSegment({
    required String date,
    required int fiscalYear,
    required String period,
    required String reportedCurrency,
    required Map<String, double> data,
  }) = _RevenueSegment;
}
