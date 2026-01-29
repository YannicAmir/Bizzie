import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_stats.freezed.dart';

@freezed
abstract class ShareStats with _$ShareStats {
  const factory ShareStats({
    required double currentSharesOutstanding,
    required List<FinancialDataPoint> annualWeightedAverageShares,
    required List<FinancialDataPoint> quarterlyWeightedAverageShares,
  }) = _ShareStats;
}
