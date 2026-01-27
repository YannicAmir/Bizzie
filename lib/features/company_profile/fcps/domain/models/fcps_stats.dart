import 'package:equatable/equatable.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';

class FcpsStats extends Equatable {
  final List<FinancialDataPoint> annualFcps;
  final List<FinancialDataPoint> quarterlyFcps;
  final String reportedCurrency;

  const FcpsStats({
    required this.annualFcps,
    required this.quarterlyFcps,
    required this.reportedCurrency,
  });

  @override
  List<Object?> get props => [annualFcps, quarterlyFcps, reportedCurrency];
}
