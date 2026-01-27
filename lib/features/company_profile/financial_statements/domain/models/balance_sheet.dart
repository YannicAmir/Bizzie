import 'package:equatable/equatable.dart';

class BalanceSheet extends Equatable {
  final String date;
  final String symbol;
  final String reportedCurrency;
  final String period;
  final double totalAssets;
  final double totalLiabilities;
  final double totalEquity;
  final double cashAndShortTermInvestments;
  final double totalDebt;

  final double totalCurrentAssets;
  final double totalNonCurrentAssets;
  final double totalCurrentLiabilities;
  final double totalNonCurrentLiabilities;
  final double longTermDebt;
  final double shortTermDebt;

  const BalanceSheet({
    required this.date,
    required this.symbol,
    required this.reportedCurrency,
    required this.period,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.totalEquity,
    required this.cashAndShortTermInvestments,
    required this.totalDebt,
    required this.totalCurrentAssets,
    required this.totalNonCurrentAssets,
    required this.totalCurrentLiabilities,
    required this.totalNonCurrentLiabilities,
    required this.longTermDebt,
    required this.shortTermDebt,
  });

  @override
  List<Object?> get props => [
    date,
    symbol,
    reportedCurrency,
    period,
    totalAssets,
    totalLiabilities,
    totalEquity,
    cashAndShortTermInvestments,
    totalDebt,
    totalCurrentAssets,
    totalNonCurrentAssets,
    totalCurrentLiabilities,
    totalNonCurrentLiabilities,
    longTermDebt,
    shortTermDebt,
  ];
}
