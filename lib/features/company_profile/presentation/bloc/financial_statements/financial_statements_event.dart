import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_statements_event.freezed.dart';

@freezed
abstract class FinancialStatementsEvent with _$FinancialStatementsEvent {
  const factory FinancialStatementsEvent.loadIncomeStatements(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadIncomeStatements;
  const factory FinancialStatementsEvent.loadBalanceSheets(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadBalanceSheets;
  const factory FinancialStatementsEvent.loadCashFlows(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadCashFlows;
}
