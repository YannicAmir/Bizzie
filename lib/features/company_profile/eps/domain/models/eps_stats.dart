import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:equatable/equatable.dart';

class EpsStats extends Equatable {
  final String reportedCurrency;
  final List<FinancialDataPoint> annualEps;
  final List<FinancialDataPoint> quarterlyEps;

  const EpsStats({
    required this.reportedCurrency,
    required this.annualEps,
    required this.quarterlyEps,
  });

  @override
  List<Object?> get props => [reportedCurrency, annualEps, quarterlyEps];
}
