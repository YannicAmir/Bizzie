import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class FinancialStatementsBloc
    extends Bloc<FinancialStatementsEvent, FinancialStatementsState> {
  final IFinancialRepository _repository;

  FinancialStatementsBloc(this._repository)
    : super(FinancialStatementsState.initial()) {
    on<LoadIncomeStatements>(_onLoadIncomeStatements, transformer: droppable());
    on<LoadBalanceSheets>(_onLoadBalanceSheets, transformer: droppable());
    on<LoadCashFlows>(_onLoadCashFlows, transformer: droppable());
  }

  Future<void> _onLoadIncomeStatements(
    LoadIncomeStatements e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (!e.forceRefresh &&
        (state.isLoadingIncome || state.annualIncomeStatements.isNotEmpty)) {
      return;
    }

    emit(state.copyWith(isLoadingIncome: true, incomeError: null));

    final results = await Future.wait([
      _repository.getIncomeStatements(e.ticker, period: 'annual'),
      _repository.getIncomeStatements(e.ticker, period: 'quarter'),
    ]);

    final annualEither = results[0];
    final quarterlyEither = results[1];

    List<IncomeStatement> annualData = [];
    List<IncomeStatement> quarterlyData = [];
    Failure? error;

    annualEither.fold((f) => error = f, (data) => annualData = data);

    if (error != null) {
      emit(state.copyWith(isLoadingIncome: false, incomeError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);

    if (error != null) {
      emit(state.copyWith(isLoadingIncome: false, incomeError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    final currency = annualData.isNotEmpty
        ? annualData.first.reportedCurrency
        : (quarterlyData.isNotEmpty
              ? quarterlyData.first.reportedCurrency
              : 'USD');

    emit(
      state.copyWith(
        isLoadingIncome: false,
        annualIncomeStatements: annualData,
        quarterlyIncomeStatements: quarterlyData,
        reportedCurrency: currency,
        lastUpdatedIncome: DateTime.now(),
      ),
    );
  }

  Future<void> _onLoadBalanceSheets(
    LoadBalanceSheets e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (!e.forceRefresh &&
        (state.isLoadingBalance || state.annualBalanceSheets.isNotEmpty)) {
      return;
    }
    emit(state.copyWith(isLoadingBalance: true, balanceError: null));

    final results = await Future.wait([
      _repository.getBalanceSheets(e.ticker, period: 'annual'),
      _repository.getBalanceSheets(e.ticker, period: 'quarter'),
    ]);

    final annualEither = results[0];
    final quarterlyEither = results[1];

    List<BalanceSheet> annualData = [];
    List<BalanceSheet> quarterlyData = [];
    Failure? error;

    annualEither.fold((f) => error = f, (data) => annualData = data);
    if (error != null) {
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);
    if (error != null) {
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        isLoadingBalance: false,
        annualBalanceSheets: annualData,
        quarterlyBalanceSheets: quarterlyData,
        lastUpdatedBalance: DateTime.now(),
      ),
    );
  }

  Future<void> _onLoadCashFlows(
    LoadCashFlows e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (!e.forceRefresh &&
        (state.isLoadingCashFlow ||
            state.annualCashFlowStatements.isNotEmpty)) {
      return;
    }
    emit(state.copyWith(isLoadingCashFlow: true, cashFlowError: null));

    final results = await Future.wait([
      _repository.getCashFlowStatements(e.ticker, period: 'annual'),
      _repository.getCashFlowStatements(e.ticker, period: 'quarter'),
    ]);

    final annualEither = results[0];
    final quarterlyEither = results[1];

    List<CashFlowStatement> annualData = [];
    List<CashFlowStatement> quarterlyData = [];
    Failure? error;

    annualEither.fold((f) => error = f, (data) => annualData = data);
    if (error != null) {
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);
    if (error != null) {
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        isLoadingCashFlow: false,
        annualCashFlowStatements: annualData,
        quarterlyCashFlowStatements: quarterlyData,
        lastUpdatedCashFlow: DateTime.now(),
      ),
    );
  }

  void checkIncomeStaleness(String ticker) {
    if (state.lastUpdatedIncome != null &&
        DateTime.now().difference(state.lastUpdatedIncome!) >
            const Duration(hours: 24)) {
      add(
        FinancialStatementsEvent.loadIncomeStatements(
          ticker,
          forceRefresh: true,
        ),
      );
    } else if (state.annualIncomeStatements.isEmpty && !state.isLoadingIncome) {
      add(FinancialStatementsEvent.loadIncomeStatements(ticker));
    }
  }

  void checkBalanceStaleness(String ticker) {
    if (state.lastUpdatedBalance != null &&
        DateTime.now().difference(state.lastUpdatedBalance!) >
            const Duration(hours: 24)) {
      add(
        FinancialStatementsEvent.loadBalanceSheets(ticker, forceRefresh: true),
      );
    } else if (state.annualBalanceSheets.isEmpty && !state.isLoadingBalance) {
      add(FinancialStatementsEvent.loadBalanceSheets(ticker));
    }
  }

  void checkCashFlowStaleness(String ticker) {
    if (state.lastUpdatedCashFlow != null &&
        DateTime.now().difference(state.lastUpdatedCashFlow!) >
            const Duration(hours: 24)) {
      add(FinancialStatementsEvent.loadCashFlows(ticker, forceRefresh: true));
    } else if (state.annualCashFlowStatements.isEmpty &&
        !state.isLoadingCashFlow) {
      add(FinancialStatementsEvent.loadCashFlows(ticker));
    }
  }
}
