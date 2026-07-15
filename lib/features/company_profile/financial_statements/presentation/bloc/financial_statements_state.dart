import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_statements_state.freezed.dart';

@freezed
abstract class StatementFlow<T> with _$StatementFlow<T> {
  const factory StatementFlow.initial() = StatementFlowInitial<T>;
  const factory StatementFlow.loading() = StatementFlowLoading<T>;
  const factory StatementFlow.loaded({
    required List<T> annual,
    required List<T> quarterly,
    required CompanyProfileDataOrigin origin,
    DateTime? lastUpdated,
    int? loadTimeMs,
    String? selectedAnnualDate,
    String? selectedQuarterlyDate,
  }) = StatementFlowLoaded<T>;
  const factory StatementFlow.failure(Failure failure) =
      StatementFlowFailure<T>;
}

@freezed
abstract class FinancialStatementsState with _$FinancialStatementsState {
  const FinancialStatementsState._();

  const factory FinancialStatementsState.initial({
    @Default(StatementFlow<IncomeStatement>.initial())
    StatementFlow<IncomeStatement> income,
    @Default(StatementFlow<BalanceSheet>.initial())
    StatementFlow<BalanceSheet> balance,
    @Default(StatementFlow<CashFlowStatement>.initial())
    StatementFlow<CashFlowStatement> cashFlow,
    @Default(FinancialStatementType.income) FinancialStatementType selectedType,
    @Default('USD') String reportedCurrency,
    String? ticker,
    required int freePlanHistoryCount,
  }) = _FinancialStatementsState;

  bool get isLoadingIncome =>
      income.maybeMap(loading: (_) => true, orElse: () => false);
  bool get isLoadingBalance =>
      balance.maybeMap(loading: (_) => true, orElse: () => false);
  bool get isLoadingCashFlow =>
      cashFlow.maybeMap(loading: (_) => true, orElse: () => false);

  bool get isIncomeSuccess =>
      income.maybeMap(loaded: (_) => true, orElse: () => false);
  bool get isBalanceSuccess =>
      balance.maybeMap(loaded: (_) => true, orElse: () => false);
  bool get isCashFlowSuccess =>
      cashFlow.maybeMap(loaded: (_) => true, orElse: () => false);

  Failure? get incomeError => income.mapOrNull(failure: (f) => f.failure);
  Failure? get balanceError => balance.mapOrNull(failure: (f) => f.failure);
  Failure? get cashFlowError => cashFlow.mapOrNull(failure: (f) => f.failure);

  List<IncomeStatement> get annualIncomeStatements =>
      income.maybeMap(loaded: (s) => s.annual, orElse: () => const []);
  List<IncomeStatement> get quarterlyIncomeStatements =>
      income.maybeMap(loaded: (s) => s.quarterly, orElse: () => const []);
  List<BalanceSheet> get annualBalanceSheets =>
      balance.maybeMap(loaded: (s) => s.annual, orElse: () => const []);
  List<BalanceSheet> get quarterlyBalanceSheets =>
      balance.maybeMap(loaded: (s) => s.quarterly, orElse: () => const []);
  List<CashFlowStatement> get annualCashFlowStatements =>
      cashFlow.maybeMap(loaded: (s) => s.annual, orElse: () => const []);
  List<CashFlowStatement> get quarterlyCashFlowStatements =>
      cashFlow.maybeMap(loaded: (s) => s.quarterly, orElse: () => const []);

  String? get selectedAnnualIncomeDate =>
      income.mapOrNull(loaded: (s) => s.selectedAnnualDate);
  String? get selectedQuarterlyIncomeDate =>
      income.mapOrNull(loaded: (s) => s.selectedQuarterlyDate);
  String? get selectedAnnualBalanceDate =>
      balance.mapOrNull(loaded: (s) => s.selectedAnnualDate);
  String? get selectedQuarterlyBalanceDate =>
      balance.mapOrNull(loaded: (s) => s.selectedQuarterlyDate);
  String? get selectedAnnualCashFlowDate =>
      cashFlow.mapOrNull(loaded: (s) => s.selectedAnnualDate);
  String? get selectedQuarterlyCashFlowDate =>
      cashFlow.mapOrNull(loaded: (s) => s.selectedQuarterlyDate);

  DateTime? get lastUpdatedIncome =>
      income.mapOrNull(loaded: (s) => s.lastUpdated);
  DateTime? get lastUpdatedBalance =>
      balance.mapOrNull(loaded: (s) => s.lastUpdated);
  DateTime? get lastUpdatedCashFlow =>
      cashFlow.mapOrNull(loaded: (s) => s.lastUpdated);

  CompanyProfileDataOrigin? get incomeOrigin =>
      income.mapOrNull(loaded: (s) => s.origin);
  CompanyProfileDataOrigin? get balanceOrigin =>
      balance.mapOrNull(loaded: (s) => s.origin);
  CompanyProfileDataOrigin? get cashFlowOrigin =>
      cashFlow.mapOrNull(loaded: (s) => s.origin);

  int? get incomeLoadTimeMs => income.mapOrNull(loaded: (s) => s.loadTimeMs);
  int? get balanceLoadTimeMs => balance.mapOrNull(loaded: (s) => s.loadTimeMs);
  int? get cashFlowLoadTimeMs =>
      cashFlow.mapOrNull(loaded: (s) => s.loadTimeMs);
}
