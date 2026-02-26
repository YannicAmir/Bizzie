import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_statements_state.freezed.dart';

@freezed
abstract class FinancialStatementsState with _$FinancialStatementsState {
  const factory FinancialStatementsState({
    @Default(false) bool isLoadingIncome,
    @Default(false) bool isLoadingBalance,
    @Default(false) bool isLoadingCashFlow,
    Failure? incomeError,
    Failure? balanceError,
    Failure? cashFlowError,
    DateTime? lastUpdatedIncome,
    DateTime? lastUpdatedBalance,
    DateTime? lastUpdatedCashFlow,
    @Default(CompanyProfileDataOrigin.api)
    CompanyProfileDataOrigin incomeOrigin,
    @Default(CompanyProfileDataOrigin.api)
    CompanyProfileDataOrigin balanceOrigin,
    @Default(CompanyProfileDataOrigin.api)
    CompanyProfileDataOrigin cashFlowOrigin,
    @Default([]) List<IncomeStatement> annualIncomeStatements,
    @Default([]) List<IncomeStatement> quarterlyIncomeStatements,
    @Default([]) List<BalanceSheet> annualBalanceSheets,
    @Default([]) List<BalanceSheet> quarterlyBalanceSheets,
    @Default([]) List<CashFlowStatement> annualCashFlowStatements,
    @Default([]) List<CashFlowStatement> quarterlyCashFlowStatements,
    @Default('USD') String reportedCurrency,
    @Default(FinancialStatementType.income) FinancialStatementType selectedType,
    String? ticker,
    String? selectedAnnualIncomeDate,
    String? selectedQuarterlyIncomeDate,
    String? selectedAnnualBalanceDate,
    String? selectedQuarterlyBalanceDate,
    String? selectedAnnualCashFlowDate,
    String? selectedQuarterlyCashFlowDate,
    required int freePlanHistoryCount,
  }) = _FinancialStatementsState;

  factory FinancialStatementsState.initial({
    required String ticker,
    required int freePlanHistoryCount,
  }) => FinancialStatementsState(
    ticker: ticker,
    freePlanHistoryCount: freePlanHistoryCount,
  );
}
