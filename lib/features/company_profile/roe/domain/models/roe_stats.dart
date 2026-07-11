import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';

part 'roe_stats.freezed.dart';

@freezed
abstract class RoeStats with _$RoeStats {
  const factory RoeStats({
    required List<FinancialDataPoint> dataPoints,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceDate,
  }) = _RoeStats;
}
