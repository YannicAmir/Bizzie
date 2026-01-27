import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:equatable/equatable.dart';

class ShareStats extends Equatable {
  final double currentSharesOutstanding;
  final List<FinancialDataPoint> annualWeightedAverageShares;
  final List<FinancialDataPoint> quarterlyWeightedAverageShares;

  const ShareStats({
    required this.currentSharesOutstanding,
    required this.annualWeightedAverageShares,
    required this.quarterlyWeightedAverageShares,
  });

  @override
  List<Object?> get props => [
    currentSharesOutstanding,
    annualWeightedAverageShares,
    quarterlyWeightedAverageShares,
  ];
}
