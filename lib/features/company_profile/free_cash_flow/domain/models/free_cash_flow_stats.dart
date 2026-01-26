import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:equatable/equatable.dart';

class FreeCashFlowStats extends Equatable {
  final String reportedCurrency;
  final List<FinancialDataPoint> annualFcf;
  final List<FinancialDataPoint> quarterlyFcf;

  const FreeCashFlowStats({
    required this.reportedCurrency,
    required this.annualFcf,
    required this.quarterlyFcf,
  });

  @override
  List<Object?> get props => [reportedCurrency, annualFcf, quarterlyFcf];
}
