import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eps_stats.freezed.dart';

@freezed
abstract class EpsStats with _$EpsStats {
  const factory EpsStats({
    required String reportedCurrency,
    required List<FinancialDataPoint> annualEps,
    required List<FinancialDataPoint> quarterlyEps,
  }) = _EpsStats;
}
