import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/presentation/enums/financial_statement_type.dart';
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

final _logger = BizzieLogger('FinancialStatementsBloc');

@injectable
class FinancialStatementsBloc
    extends Bloc<FinancialStatementsEvent, FinancialStatementsState> {
  final IFinancialRepository _repository;

  FinancialStatementsBloc(this._repository)
    : super(FinancialStatementsState.initial()) {
    on<FinancialStatementsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    FinancialStatementsEvent event,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadIncomeStatements: (e) async => _onLoadIncomeStatements(e, emit),
      loadBalanceSheets: (e) async => _onLoadBalanceSheets(e, emit),
      loadCashFlows: (e) async => _onLoadCashFlows(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e, emit),
      viewTypeChanged: (e) async => _onViewTypeChanged(e, emit),
      incomeDateSelected: (e) async => _onIncomeDateSelected(e, emit),
      balanceDateSelected: (e) async => _onBalanceDateSelected(e, emit),
      cashFlowDateSelected: (e) async => _onCashFlowDateSelected(e, emit),
    );
  }

  Future<void> _onLoadIncomeStatements(
    LoadIncomeStatements e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (!e.forceRefresh &&
        (state.isLoadingIncome || state.annualIncomeStatements.isNotEmpty)) {
      _logger.info(
        'Skip loading income statements: force=${e.forceRefresh}, loading=${state.isLoadingIncome}, hasData=${state.annualIncomeStatements.isNotEmpty}',
      );
      return;
    }

    _logger.info(
      'Loading income statements for ${e.ticker} (force=${e.forceRefresh})',
    );
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
      _logger.severe('Failed to load annual income statements', error);
      emit(state.copyWith(isLoadingIncome: false, incomeError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);

    if (error != null) {
      _logger.severe('Failed to load quarterly income statements', error);
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

    _logger.info(
      'Successfully loaded income statements: annual=${annualData.length}, quarterly=${quarterlyData.length}, currency=$currency',
    );
    emit(
      state.copyWith(
        isLoadingIncome: false,
        annualIncomeStatements: annualData,
        quarterlyIncomeStatements: quarterlyData,
        reportedCurrency: currency,
        lastUpdatedIncome: DateTime.now(),
        selectedAnnualIncomeDate:
            state.selectedAnnualIncomeDate ??
            (annualData.isNotEmpty ? annualData.first.date : null),
        selectedQuarterlyIncomeDate:
            state.selectedQuarterlyIncomeDate ??
            (quarterlyData.isNotEmpty ? quarterlyData.first.date : null),
      ),
    );
  }

  Future<void> _onLoadBalanceSheets(
    LoadBalanceSheets e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (!e.forceRefresh &&
        (state.isLoadingBalance || state.annualBalanceSheets.isNotEmpty)) {
      _logger.info('Skip loading balance sheets');
      return;
    }
    _logger.info('Loading balance sheets for ${e.ticker}');
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
      _logger.severe('Failed to load annual balance sheets', error);
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);
    if (error != null) {
      _logger.severe('Failed to load quarterly balance sheets', error);
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    _logger.info('Successfully loaded balance sheets');
    emit(
      state.copyWith(
        isLoadingBalance: false,
        annualBalanceSheets: annualData,
        quarterlyBalanceSheets: quarterlyData,
        lastUpdatedBalance: DateTime.now(),
        selectedAnnualBalanceDate:
            state.selectedAnnualBalanceDate ??
            (annualData.isNotEmpty ? annualData.first.date : null),
        selectedQuarterlyBalanceDate:
            state.selectedQuarterlyBalanceDate ??
            (quarterlyData.isNotEmpty ? quarterlyData.first.date : null),
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
      _logger.info('Skip loading cash flows');
      return;
    }
    _logger.info('Loading cash flows for ${e.ticker}');
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
      _logger.severe('Failed to load annual cash flows', error);
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    quarterlyEither.fold((f) => error = f, (data) => quarterlyData = data);
    if (error != null) {
      _logger.severe('Failed to load quarterly cash flows', error);
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    _logger.info('Successfully loaded cash flows');
    emit(
      state.copyWith(
        isLoadingCashFlow: false,
        annualCashFlowStatements: annualData,
        quarterlyCashFlowStatements: quarterlyData,
        lastUpdatedCashFlow: DateTime.now(),
        selectedAnnualCashFlowDate:
            state.selectedAnnualCashFlowDate ??
            (annualData.isNotEmpty ? annualData.first.date : null),
        selectedQuarterlyCashFlowDate:
            state.selectedQuarterlyCashFlowDate ??
            (quarterlyData.isNotEmpty ? quarterlyData.first.date : null),
      ),
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${e.type}');
    switch (e.type) {
      case FinancialStatementType.income:
        if (state.lastUpdatedIncome != null &&
            DateTime.now().difference(state.lastUpdatedIncome!) >
                const Duration(hours: 24)) {
          _logger.info(
            'Income statements stale (TTL expired). Triggering load.',
          );
          add(
            FinancialStatementsEvent.loadIncomeStatements(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else if (state.annualIncomeStatements.isEmpty &&
            !state.isLoadingIncome) {
          _logger.info('Income statements empty. Triggering load.');
          add(FinancialStatementsEvent.loadIncomeStatements(e.ticker));
        } else {
          _logger.info('Income statements still fresh.');
        }
        break;
      case FinancialStatementType.balance:
        if (state.lastUpdatedBalance != null &&
            DateTime.now().difference(state.lastUpdatedBalance!) >
                const Duration(hours: 24)) {
          _logger.info('Balance sheets stale (TTL expired). Triggering load.');
          add(
            FinancialStatementsEvent.loadBalanceSheets(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else if (state.annualBalanceSheets.isEmpty &&
            !state.isLoadingBalance) {
          _logger.info('Balance sheets empty. Triggering load.');
          add(FinancialStatementsEvent.loadBalanceSheets(e.ticker));
        } else {
          _logger.info('Balance sheets still fresh.');
        }
        break;
      case FinancialStatementType.cashFlow:
        if (state.lastUpdatedCashFlow != null &&
            DateTime.now().difference(state.lastUpdatedCashFlow!) >
                const Duration(hours: 24)) {
          _logger.info('Cash flows stale (TTL expired). Triggering load.');
          add(
            FinancialStatementsEvent.loadCashFlows(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else if (state.annualCashFlowStatements.isEmpty &&
            !state.isLoadingCashFlow) {
          _logger.info('Cash flows empty. Triggering load.');
          add(FinancialStatementsEvent.loadCashFlows(e.ticker));
        } else {
          _logger.info('Cash flows still fresh.');
        }
        break;
    }
  }

  Future<void> _onViewTypeChanged(
    ViewTypeChanged e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('View type changed to ${e.type}');
    if (state.selectedType == e.type) return;

    emit(state.copyWith(selectedType: e.type));

    add(
      FinancialStatementsEvent.stalenessCheckRequested(e.ticker, type: e.type),
    );
  }

  Future<void> _onIncomeDateSelected(
    IncomeDateSelected e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Income date selected: ${e.date}, annual=${e.isAnnual}');
    if (e.isAnnual) {
      emit(state.copyWith(selectedAnnualIncomeDate: e.date));
    } else {
      emit(state.copyWith(selectedQuarterlyIncomeDate: e.date));
    }
  }

  Future<void> _onBalanceDateSelected(
    BalanceDateSelected e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Balance date selected: ${e.date}, annual=${e.isAnnual}');
    if (e.isAnnual) {
      emit(state.copyWith(selectedAnnualBalanceDate: e.date));
    } else {
      emit(state.copyWith(selectedQuarterlyBalanceDate: e.date));
    }
  }

  Future<void> _onCashFlowDateSelected(
    CashFlowDateSelected e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Cash flow date selected: ${e.date}, annual=${e.isAnnual}');
    if (e.isAnnual) {
      emit(state.copyWith(selectedAnnualCashFlowDate: e.date));
    } else {
      emit(state.copyWith(selectedQuarterlyCashFlowDate: e.date));
    }
  }
}
