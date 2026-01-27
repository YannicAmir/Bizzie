import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_cash_flow_stats.freezed.dart';

@freezed
abstract class FreeCashFlowStats with _$FreeCashFlowStats {
  const factory FreeCashFlowStats({
    required String reportedCurrency,
    required List<FinancialDataPoint> annualFcf,
    required List<FinancialDataPoint> quarterlyFcf,
  }) = _FreeCashFlowStats;
}
