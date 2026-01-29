import 'package:freezed_annotation/freezed_annotation.dart';

part 'shares_summary_data.freezed.dart';

@freezed
abstract class SharesSummaryData with _$SharesSummaryData {
  const factory SharesSummaryData({
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
  }) = _SharesSummaryData;
}
