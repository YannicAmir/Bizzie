import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcps_stats.freezed.dart';

@freezed
abstract class FcpsStats with _$FcpsStats {
  const factory FcpsStats({
    required List<FinancialDataPoint> annualFcps,
    required List<FinancialDataPoint> quarterlyFcps,
    required String reportedCurrency,
  }) = _FcpsStats;
}
