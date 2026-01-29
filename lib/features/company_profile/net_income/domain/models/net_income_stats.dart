import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'net_income_stats.freezed.dart';

@freezed
abstract class NetIncomeStats with _$NetIncomeStats {
  const factory NetIncomeStats({
    required String reportedCurrency,
    required List<FinancialDataPoint> annualNetIncome,
    required List<FinancialDataPoint> quarterlyNetIncome,
  }) = _NetIncomeStats;
}
