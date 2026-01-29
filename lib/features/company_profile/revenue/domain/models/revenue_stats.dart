import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_stats.freezed.dart';

@freezed
abstract class RevenueStats with _$RevenueStats {
  const factory RevenueStats({
    required String reportedCurrency,
    required List<FinancialDataPoint> annualRevenue,
    required List<FinancialDataPoint> quarterlyRevenue,
  }) = _RevenueStats;
}
