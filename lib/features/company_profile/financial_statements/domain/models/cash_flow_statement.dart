import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_flow_statement.freezed.dart';

@freezed
abstract class CashFlowStatement with _$CashFlowStatement {
  const factory CashFlowStatement({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String period,
    required double operatingCashFlow,
    required double investingCashFlow,
    required double financingCashFlow,
    required double capitalExpenditure,
    required double freeCashFlow,
    required double dividendsPaid,
    required double cashAtBeginningOfPeriod,
    required double cashAtEndOfPeriod,
  }) = _CashFlowStatement;
}
