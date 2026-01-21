import 'package:equatable/equatable.dart';

class CompanyRatios extends Equatable {
  final String symbol;
  final String date;
  final String period;
  final double priceToEarningsRatio;
  final double priceToFreeCashFlowRatio;

  const CompanyRatios({
    required this.symbol,
    required this.date,
    required this.period,
    required this.priceToEarningsRatio,
    required this.priceToFreeCashFlowRatio,
  });

  @override
  List<Object?> get props => [
    symbol,
    date,
    period,
    priceToEarningsRatio,
    priceToFreeCashFlowRatio,
  ];
}
