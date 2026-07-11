import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';

part 'pfcf_ratio_stats.freezed.dart';

@freezed
abstract class PfcfRatioStats with _$PfcfRatioStats {
  const factory PfcfRatioStats({
    required List<FinancialDataPoint> dataPoints,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceDate,
  }) = _PfcfRatioStats;
}
