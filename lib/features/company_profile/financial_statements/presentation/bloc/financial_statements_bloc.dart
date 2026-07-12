import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/get_financial_statement_params.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_balance_sheets_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_cash_flow_statements_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_income_statements_usecase.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('FinancialStatementsBloc');

@injectable
class FinancialStatementsBloc
    extends Bloc<FinancialStatementsEvent, FinancialStatementsState>
    with FinancialStatementsAnalyticsMixin {
  final GetIncomeStatementsUseCase _getIncomeStatements;
  final GetBalanceSheetsUseCase _getBalanceSheets;
  final GetCashFlowStatementsUseCase _getCashFlowStatements;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  @override
  final IncStmtTabAnalytics incTracker;
  @override
  final BalStmtTabAnalytics balTracker;
  @override
  final CashStmtTabAnalytics cashTracker;

  String? _ticker;
  StreamSubscription<TabActivation>? _tabSubscription;

  FinancialStatementsBloc(
    this._getIncomeStatements,
    this._getBalanceSheets,
    this._getCashFlowStatements,
    this.incTracker,
    this.balTracker,
    this.cashTracker,
    IConfigService configService,
    this._watchActiveTabUseCase,
    this._timeProvider,
  ) : super(
        FinancialStatementsState.initial(
          ticker: '',
          freePlanHistoryCount: configService.freePlanHistoryCount,
        ),
      ) {
    on<LoadIncomeStatements>(_onLoadIncomeStatements, transformer: restartable());
    on<LoadBalanceSheets>(_onLoadBalanceSheets, transformer: restartable());
    on<LoadCashFlows>(_onLoadCashFlows, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<ViewTypeChanged>(_onViewTypeChanged);
    on<IncomeDateSelected>(_onIncomeDateSelected);
    on<BalanceDateSelected>(_onBalanceDateSelected);
    on<CashFlowDateSelected>(_onCashFlowDateSelected);

    on<TabShown>(_onTabShown);
    on<TabHidden>(_onTabHidden);
    on<AppBackgrounded>(_onAppBackgrounded);
    on<AppForegrounded>(_onAppForegrounded);
    on<ViewAllTapped>(_onViewAllTapped);
    on<ChartSwiped>(_onChartSwiped);
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.financialStatements)
        .listen((activation) {
          if (_ticker == null || _ticker == activation.ticker) {
            add(FinancialStatementsEvent.stalenessCheckRequested(
              activation.ticker,
              type: FinancialStatementType.income,
            ));
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadIncomeStatements(
    LoadIncomeStatements e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _ticker = e.ticker;
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

    final stopwatch = Stopwatch()..start();
    final results = await Future.wait([
      _getIncomeStatements(
        GetFinancialStatementParams(ticker: e.ticker, period: 'annual'),
      ),
      _getIncomeStatements(
        GetFinancialStatementParams(ticker: e.ticker, period: 'quarter'),
      ),
    ]);
    stopwatch.stop();
    final loadTime = stopwatch.elapsedMilliseconds;

    final annualResult = results[0];
    final quarterlyResult = results[1];

    List<IncomeStatement> annualData = [];
    List<IncomeStatement> quarterlyData = [];
    CompanyProfileDataOrigin? annualOrigin;
    CompanyProfileDataOrigin? quarterlyOrigin;
    Failure? error;

    annualResult.fold((f) => error = f, (tuple) {
      annualData = tuple.$1;
      annualOrigin = tuple.$2;
    });

    if (error != null) {
      _logger.severe('Failed to load annual income statements', error);
      emit(state.copyWith(isLoadingIncome: false, incomeError: error));
      return;
    }

    quarterlyResult.fold((f) => error = f, (tuple) {
      quarterlyData = tuple.$1;
      quarterlyOrigin = tuple.$2;
    });

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
      'Successfully loaded income statements: annual=${annualData.length}, quarterly=${quarterlyData.length}, origin=$annualOrigin, currency=$currency',
    );
    updateIncAnalytics(
      (inc) => inc.copyWith(
        loadTimeMs: loadTime,
        isSuccess: true,
        dataSource:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
      ),
    );

    emit(
      state.copyWith(
        isLoadingIncome: false,
        incomeLoadTimeMs: loadTime,
        isIncomeSuccess: true,
        annualIncomeStatements: annualData,
        quarterlyIncomeStatements: quarterlyData,
        reportedCurrency: currency,
        lastUpdatedIncome: _timeProvider.nowLocal,
        incomeOrigin:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
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

    final stopwatch = Stopwatch()..start();
    final results = await Future.wait([
      _getBalanceSheets(
        GetFinancialStatementParams(ticker: e.ticker, period: 'annual'),
      ),
      _getBalanceSheets(
        GetFinancialStatementParams(ticker: e.ticker, period: 'quarter'),
      ),
    ]);
    stopwatch.stop();
    final loadTime = stopwatch.elapsedMilliseconds;

    final annualResult = results[0];
    final quarterlyResult = results[1];

    List<BalanceSheet> annualData = [];
    List<BalanceSheet> quarterlyData = [];
    CompanyProfileDataOrigin? annualOrigin;
    CompanyProfileDataOrigin? quarterlyOrigin;
    Failure? error;

    annualResult.fold((f) => error = f, (tuple) {
      annualData = tuple.$1;
      annualOrigin = tuple.$2;
    });
    if (error != null) {
      _logger.severe('Failed to load annual balance sheets', error);
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    quarterlyResult.fold((f) => error = f, (tuple) {
      quarterlyData = tuple.$1;
      quarterlyOrigin = tuple.$2;
    });
    if (error != null) {
      _logger.severe('Failed to load quarterly balance sheets', error);
      emit(state.copyWith(isLoadingBalance: false, balanceError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    _logger.info('Successfully loaded balance sheets, origin=$annualOrigin');
    updateBalAnalytics(
      (bal) => bal.copyWith(
        loadTimeMs: loadTime,
        isSuccess: true,
        dataSource:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
      ),
    );

    emit(
      state.copyWith(
        isLoadingBalance: false,
        balanceLoadTimeMs: loadTime,
        isBalanceSuccess: true,
        annualBalanceSheets: annualData,
        quarterlyBalanceSheets: quarterlyData,
        lastUpdatedBalance: _timeProvider.nowLocal,
        balanceOrigin:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
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

    final stopwatch = Stopwatch()..start();
    final results = await Future.wait([
      _getCashFlowStatements(
        GetFinancialStatementParams(ticker: e.ticker, period: 'annual'),
      ),
      _getCashFlowStatements(
        GetFinancialStatementParams(ticker: e.ticker, period: 'quarter'),
      ),
    ]);
    stopwatch.stop();
    final loadTime = stopwatch.elapsedMilliseconds;

    final annualResult = results[0];
    final quarterlyResult = results[1];

    List<CashFlowStatement> annualData = [];
    List<CashFlowStatement> quarterlyData = [];
    CompanyProfileDataOrigin? annualOrigin;
    CompanyProfileDataOrigin? quarterlyOrigin;
    Failure? error;

    annualResult.fold((f) => error = f, (tuple) {
      annualData = tuple.$1;
      annualOrigin = tuple.$2;
    });
    if (error != null) {
      _logger.severe('Failed to load annual cash flows', error);
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    quarterlyResult.fold((f) => error = f, (tuple) {
      quarterlyData = tuple.$1;
      quarterlyOrigin = tuple.$2;
    });
    if (error != null) {
      _logger.severe('Failed to load quarterly cash flows', error);
      emit(state.copyWith(isLoadingCashFlow: false, cashFlowError: error));
      return;
    }

    annualData.sort((a, b) => b.date.compareTo(a.date));
    quarterlyData.sort((a, b) => b.date.compareTo(a.date));

    _logger.info('Successfully loaded cash flows, origin=$annualOrigin');
    updateCashAnalytics(
      (cash) => cash.copyWith(
        loadTimeMs: loadTime,
        isSuccess: true,
        dataSource:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
      ),
    );

    emit(
      state.copyWith(
        isLoadingCashFlow: false,
        cashFlowLoadTimeMs: loadTime,
        isCashFlowSuccess: true,
        annualCashFlowStatements: annualData,
        quarterlyCashFlowStatements: quarterlyData,
        lastUpdatedCashFlow: _timeProvider.nowLocal,
        cashFlowOrigin:
            annualOrigin ?? quarterlyOrigin ?? CompanyProfileDataOrigin.api,
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
            _timeProvider.nowLocal.difference(state.lastUpdatedIncome!) >
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
        } else if (state.annualIncomeStatements.isEmpty) {
          _logger.info('Income statements empty. Triggering load.');
          add(
            FinancialStatementsEvent.loadIncomeStatements(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else {
          _logger.info(
            'Income statements still fresh (Last updated: ${state.lastUpdatedIncome})',
          );
        }
        break;
      case FinancialStatementType.balance:
        if (state.lastUpdatedBalance != null &&
            _timeProvider.nowLocal.difference(state.lastUpdatedBalance!) >
                const Duration(hours: 24)) {
          _logger.info('Balance sheets stale (TTL expired). Triggering load.');
          add(
            FinancialStatementsEvent.loadBalanceSheets(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else if (state.annualBalanceSheets.isEmpty) {
          _logger.info('Balance sheets empty. Triggering load.');
          add(
            FinancialStatementsEvent.loadBalanceSheets(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else {
          _logger.info(
            'Balance sheets still fresh (Last updated: ${state.lastUpdatedBalance})',
          );
        }
        break;
      case FinancialStatementType.cashFlow:
        if (state.lastUpdatedCashFlow != null &&
            _timeProvider.nowLocal.difference(state.lastUpdatedCashFlow!) >
                const Duration(hours: 24)) {
          _logger.info('Cash flows stale (TTL expired). Triggering load.');
          add(
            FinancialStatementsEvent.loadCashFlows(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else if (state.annualCashFlowStatements.isEmpty) {
          _logger.info('Cash flows empty. Triggering load.');
          add(
            FinancialStatementsEvent.loadCashFlows(
              e.ticker,
              forceRefresh: true,
            ),
          );
        } else {
          _logger.info(
            'Cash flows still fresh (Last updated: ${state.lastUpdatedCashFlow})',
          );
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

    await handleViewTypeChanged(state);

    emit(state.copyWith(selectedType: e.type));

    if (e.type == FinancialStatementType.income) {
      updateIncAnalytics((inc) => inc.copyWith(viewedIncomeTab: true));
    } else if (e.type == FinancialStatementType.balance) {
      updateBalAnalytics(
        (bal) => bal.copyWith(
          viewedBalanceTab: true,
          viewedNetWorthChart: true,
        ),
      );
    } else if (e.type == FinancialStatementType.cashFlow) {
      updateCashAnalytics((cash) => cash.copyWith(viewedCashFlowTab: true));
    }

    add(
      FinancialStatementsEvent.stalenessCheckRequested(e.ticker, type: e.type),
    );
  }

  Future<void> _onIncomeDateSelected(
    IncomeDateSelected e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Income date selected: ${e.date}, annual=${e.isAnnual}');
    updateIncAnalytics(
      (inc) => inc.copyWith(
        switchedIncomeYear: e.isAnnual ? true : inc.switchedIncomeYear,
        switchedIncomeQtr: !e.isAnnual ? true : inc.switchedIncomeQtr,
      ),
    );

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
    updateBalAnalytics((bal) => bal.copyWith(switchedBalancePeriod: true));

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
    updateCashAnalytics(
      (cash) => cash.copyWith(
        switchedCashflYear: e.isAnnual ? true : cash.switchedCashflYear,
        switchedCashflQtr: !e.isAnnual ? true : cash.switchedCashflQtr,
      ),
    );

    if (e.isAnnual) {
      emit(state.copyWith(selectedAnnualCashFlowDate: e.date));
    } else {
      emit(state.copyWith(selectedQuarterlyCashFlowDate: e.date));
    }
  }

  Future<void> _onTabShown(
    TabShown e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    final timestamp = _timeProvider.nowLocal.toIso8601String();
    handleTabShown(
      e.ticker,
      initialInc: IncStmtTabViewState(
        ticker: e.ticker,
        timestamp: timestamp,
        loadTimeMs: state.incomeLoadTimeMs,
        isSuccess: state.isIncomeSuccess,
        dataSource: state.incomeOrigin,
      ),
      initialBal: BalStmtTabViewState(
        ticker: e.ticker,
        timestamp: timestamp,
        loadTimeMs: state.balanceLoadTimeMs,
        isSuccess: state.isBalanceSuccess,
        dataSource: state.balanceOrigin,
      ),
      initialCash: CashStmtTabViewState(
        ticker: e.ticker,
        timestamp: timestamp,
        loadTimeMs: state.cashFlowLoadTimeMs,
        isSuccess: state.isCashFlowSuccess,
        dataSource: state.cashFlowOrigin,
      ),
    );

    if (state.selectedType == FinancialStatementType.income) {
      updateIncAnalytics((inc) => inc.copyWith(viewedIncomeTab: true));
    } else if (state.selectedType == FinancialStatementType.balance) {
      updateBalAnalytics(
        (bal) => bal.copyWith(
          viewedBalanceTab: true,
          viewedNetWorthChart: true,
        ),
      );
    } else if (state.selectedType == FinancialStatementType.cashFlow) {
      updateCashAnalytics((cash) => cash.copyWith(viewedCashFlowTab: true));
    }

    if (state.lastUpdatedIncome != null || state.annualIncomeStatements.isNotEmpty) {
      add(FinancialStatementsEvent.stalenessCheckRequested(
        e.ticker,
        type: FinancialStatementType.income,
      ));
    }
  }

  Future<void> _onTabHidden(
    TabHidden e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    await handleTabHidden(state);
  }

  Future<void> _onAppBackgrounded(
    AppBackgrounded e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    await handleAppBackgrounded(state);
  }

  void _onAppForegrounded(
    AppForegrounded e,
    Emitter<FinancialStatementsState> emit,
  ) {
    handleAppForegrounded();
  }

  void _onViewAllTapped(
    ViewAllTapped e,
    Emitter<FinancialStatementsState> emit,
  ) {
    switch (state.selectedType) {
      case FinancialStatementType.income:
        updateIncAnalytics(
          (inc) => inc.copyWith(
            tappedAllIncomeYrly: e.isAnnual ? true : inc.tappedAllIncomeYrly,
            tappedAllIncomeQtrly: !e.isAnnual
                ? true
                : inc.tappedAllIncomeQtrly,
          ),
        );
        break;
      case FinancialStatementType.balance:
        updateBalAnalytics((bal) => bal.copyWith(tappedAllBalSheet: true));
        break;
      case FinancialStatementType.cashFlow:
        updateCashAnalytics(
          (cash) => cash.copyWith(
            tappedAllCashflYrly: e.isAnnual ? true : cash.tappedAllCashflYrly,
            tappedAllCashflQtrly: !e.isAnnual
                ? true
                : cash.tappedAllCashflQtrly,
          ),
        );
        break;
    }
  }

  void _onChartSwiped(ChartSwiped e, Emitter<FinancialStatementsState> emit) {
    if (state.selectedType == FinancialStatementType.balance) {
      updateBalAnalytics(
        (bal) => bal.copyWith(
          viewedNetWorthChart: e.index == 0 ? true : bal.viewedNetWorthChart,
          viewedCurrChart: e.index == 1 ? true : bal.viewedCurrChart,
          viewedDebteqChart: e.index == 2 ? true : bal.viewedDebteqChart,
        ),
      );
    }
  }
}
