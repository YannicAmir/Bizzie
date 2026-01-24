import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:equatable/equatable.dart';

class RevenueStats extends Equatable {
  final String reportedCurrency;
  final List<FinancialDataPoint> annualRevenue;
  final List<FinancialDataPoint> quarterlyRevenue;

  const RevenueStats({
    required this.reportedCurrency,
    required this.annualRevenue,
    required this.quarterlyRevenue,
  });

  @override
  List<Object?> get props => [
    reportedCurrency,
    annualRevenue,
    quarterlyRevenue,
  ];
}
