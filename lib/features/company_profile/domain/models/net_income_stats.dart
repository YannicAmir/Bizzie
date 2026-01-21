import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:equatable/equatable.dart';

class NetIncomeStats extends Equatable {
  final String reportedCurrency;
  final List<FinancialDataPoint> annualNetIncome;
  final List<FinancialDataPoint> quarterlyNetIncome;

  const NetIncomeStats({
    required this.reportedCurrency,
    required this.annualNetIncome,
    required this.quarterlyNetIncome,
  });

  @override
  List<Object?> get props => [
    reportedCurrency,
    annualNetIncome,
    quarterlyNetIncome,
  ];
}
