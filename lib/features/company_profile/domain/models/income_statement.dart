import 'package:equatable/equatable.dart';

class IncomeStatement extends Equatable {
  final String date;
  final String symbol;
  final String reportedCurrency;
  final String period;
  final double revenue;
  final double grossProfit;
  final double operatingIncome;
  final double netIncome;
  final double eps;
  final double ebitda;
  final double costOfRevenue;
  final double operatingExpenses;
  final double costAndExpenses;

  const IncomeStatement({
    required this.date,
    required this.symbol,
    required this.reportedCurrency,
    required this.period,
    required this.revenue,
    required this.grossProfit,
    required this.operatingIncome,
    required this.netIncome,
    required this.eps,
    required this.ebitda,
    required this.costOfRevenue,
    required this.operatingExpenses,
    required this.costAndExpenses,
  });

  @override
  List<Object?> get props => [
    date,
    symbol,
    reportedCurrency,
    period,
    revenue,
    grossProfit,
    operatingIncome,
    netIncome,
    eps,
    ebitda,
    costOfRevenue,
    operatingExpenses,
    costAndExpenses,
  ];
}
