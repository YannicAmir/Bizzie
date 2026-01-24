import 'package:equatable/equatable.dart';

class CashFlowStatement extends Equatable {
  final String date;
  final String symbol;
  final String reportedCurrency;
  final String period;
  final double operatingCashFlow;
  final double investingCashFlow;
  final double financingCashFlow;
  final double capitalExpenditure;
  final double freeCashFlow;
  final double dividendsPaid;
  final double cashAtBeginningOfPeriod;
  final double cashAtEndOfPeriod;

  const CashFlowStatement({
    required this.date,
    required this.symbol,
    required this.reportedCurrency,
    required this.period,
    required this.operatingCashFlow,
    required this.investingCashFlow,
    required this.financingCashFlow,
    required this.capitalExpenditure,
    required this.freeCashFlow,
    required this.dividendsPaid,
    required this.cashAtBeginningOfPeriod,
    required this.cashAtEndOfPeriod,
  });

  @override
  List<Object?> get props => [
    date,
    symbol,
    reportedCurrency,
    period,
    operatingCashFlow,
    investingCashFlow,
    financingCashFlow,
    capitalExpenditure,
    freeCashFlow,
    dividendsPaid,
    cashAtBeginningOfPeriod,
    cashAtEndOfPeriod,
  ];
}
