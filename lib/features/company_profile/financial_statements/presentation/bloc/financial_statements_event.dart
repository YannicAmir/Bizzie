import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
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

  const factory FinancialStatementsEvent.viewTypeChanged(
    String ticker,
    FinancialStatementType type,
  ) = ViewTypeChanged;

  const factory FinancialStatementsEvent.incomeDateSelected(
    String date, {
    required bool isAnnual,
  }) = IncomeDateSelected;
  const factory FinancialStatementsEvent.balanceDateSelected(
    String date, {
    required bool isAnnual,
  }) = BalanceDateSelected;
  const factory FinancialStatementsEvent.cashFlowDateSelected(
    String date, {
    required bool isAnnual,
  }) = CashFlowDateSelected;

  const factory FinancialStatementsEvent.tabShown(String ticker) = TabShown;
  const factory FinancialStatementsEvent.tabHidden() = TabHidden;
  const factory FinancialStatementsEvent.appBackgrounded() = AppBackgrounded;
  const factory FinancialStatementsEvent.appForegrounded() = AppForegrounded;
  const factory FinancialStatementsEvent.viewAllTapped({
    required bool isAnnual,
  }) = ViewAllTapped;
  const factory FinancialStatementsEvent.chartSwiped(int index) = ChartSwiped;
}
