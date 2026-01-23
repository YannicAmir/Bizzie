import 'package:bizzie/features/company_profile/presentation/enums/financial_statement_type.dart';
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

  const factory FinancialStatementsEvent.stalenessCheckRequested(
    String ticker, {
    @Default(FinancialStatementType.income) FinancialStatementType type,
  }) = StalenessCheckRequested;
}
