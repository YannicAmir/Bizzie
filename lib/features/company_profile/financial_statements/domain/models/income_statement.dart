import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_statement.freezed.dart';

@freezed
abstract class IncomeStatement with _$IncomeStatement {
  const factory IncomeStatement({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String period,
    required double revenue,
    required double grossProfit,
    required double operatingIncome,
    required double netIncome,
    required double eps,
    required double ebitda,
    required double costOfRevenue,
    required double operatingExpenses,
    required double costAndExpenses,
  }) = _IncomeStatement;
}
