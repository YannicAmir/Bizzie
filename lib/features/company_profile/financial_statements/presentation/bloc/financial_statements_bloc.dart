import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
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
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('FinancialStatementsBloc');

const _statementsTtl = Duration(hours: 24);

typedef _FetchedStatements<T> = ({
  List<T> annual,
  List<T> quarterly,
  CompanyProfileDataOrigin origin,
  int loadTimeMs,
});

@injectable
class FinancialStatementsBloc
    extends Bloc<FinancialStatementsEvent, FinancialStatementsState>
    with
        FinancialStatementsAnalyticsMixin,
        AuthSessionResetMixin<FinancialStatementsEvent,
            FinancialStatementsState> {
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
    GetAuthStream getAuthStream,
  ) : super(
        FinancialStatementsState.initial(
          ticker: '',
          freePlanHistoryCount: configService.freePlanHistoryCount,
        ),
      ) {
    on<LoadIncomeStatements>(
      _onLoadIncomeStatements,
      transformer: restartable(),
    );
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
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const FinancialStatementsEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where(
          (activation) =>
              activation.tab == CompanyProfileTab.financialStatements,
        )
        .listen((activation) {
          if (_ticker == null || _ticker == activation.ticker) {
            add(
              FinancialStatementsEvent.stalenessCheckRequested(
                activation.ticker,
                type: FinancialStatementType.income,
              ),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  void _onReset(Reset e, Emitter<FinancialStatementsState> emit) {
    _ticker = null;
    emit(
      FinancialStatementsState.initial(
        ticker: '',
        freePlanHistoryCount: state.freePlanHistoryCount,
      ),
    );
  }

  Future<void> _onLoadIncomeStatements(
    LoadIncomeStatements e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _ticker = e.ticker;
    if (_shouldSkipLoad(
      state.income,
      forceRefresh: e.forceRefresh,
      label: 'income statements',
    )) {
      return;
    }
    _logger.info(
      'Loading income statements for ${e.ticker} (force=${e.forceRefresh})',
    );
    final previous = state.income.mapOrNull(loaded: (s) => s);
    emit(state.copyWith(income: const StatementFlow.loading()));

    final result = await _fetchStatements(
      useCase: _getIncomeStatements,
      ticker: e.ticker,
      label: 'income statements',
      dateOf: (s) => s.date,
    );
    result.fold(
      (failure) => emit(state.copyWith(income: StatementFlow.failure(failure))),
      (data) => _emitIncomeLoaded(data, previous: previous, emit: emit),
    );
  }

  void _emitIncomeLoaded(
    _FetchedStatements<IncomeStatement> data, {
    required StatementFlowLoaded<IncomeStatement>? previous,
    required Emitter<FinancialStatementsState> emit,
  }) {
    updateIncAnalytics(
      (inc) => inc.copyWith(
        loadTimeMs: data.loadTimeMs,
        isSuccess: true,
        dataSource: data.origin,
      ),
    );
    emit(
      state.copyWith(
        income: _loadedFlowFrom(data, previous: previous, dateOf: (s) => s.date),
        reportedCurrency: _deriveReportedCurrency(data),
      ),
    );
  }

  Future<void> _onLoadBalanceSheets(
    LoadBalanceSheets e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (_shouldSkipLoad(
      state.balance,
      forceRefresh: e.forceRefresh,
      label: 'balance sheets',
    )) {
      return;
    }
    _logger.info('Loading balance sheets for ${e.ticker}');
    final previous = state.balance.mapOrNull(loaded: (s) => s);
    emit(state.copyWith(balance: const StatementFlow.loading()));

    final result = await _fetchStatements(
      useCase: _getBalanceSheets,
      ticker: e.ticker,
      label: 'balance sheets',
      dateOf: (s) => s.date,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(balance: StatementFlow.failure(failure))),
      (data) => _emitBalanceLoaded(data, previous: previous, emit: emit),
    );
  }

  void _emitBalanceLoaded(
    _FetchedStatements<BalanceSheet> data, {
    required StatementFlowLoaded<BalanceSheet>? previous,
    required Emitter<FinancialStatementsState> emit,
  }) {
    updateBalAnalytics(
      (bal) => bal.copyWith(
        loadTimeMs: data.loadTimeMs,
        isSuccess: true,
        dataSource: data.origin,
      ),
    );
    emit(
      state.copyWith(
        balance: _loadedFlowFrom(data, previous: previous, dateOf: (s) => s.date),
      ),
    );
  }

  Future<void> _onLoadCashFlows(
    LoadCashFlows e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    if (_shouldSkipLoad(
      state.cashFlow,
      forceRefresh: e.forceRefresh,
      label: 'cash flows',
    )) {
      return;
    }
    _logger.info('Loading cash flows for ${e.ticker}');
    final previous = state.cashFlow.mapOrNull(loaded: (s) => s);
    emit(state.copyWith(cashFlow: const StatementFlow.loading()));

    final result = await _fetchStatements(
      useCase: _getCashFlowStatements,
      ticker: e.ticker,
      label: 'cash flows',
      dateOf: (s) => s.date,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(cashFlow: StatementFlow.failure(failure))),
      (data) => _emitCashFlowLoaded(data, previous: previous, emit: emit),
    );
  }

  void _emitCashFlowLoaded(
    _FetchedStatements<CashFlowStatement> data, {
    required StatementFlowLoaded<CashFlowStatement>? previous,
    required Emitter<FinancialStatementsState> emit,
  }) {
    updateCashAnalytics(
      (cash) => cash.copyWith(
        loadTimeMs: data.loadTimeMs,
        isSuccess: true,
        dataSource: data.origin,
      ),
    );
    emit(
      state.copyWith(
        cashFlow: _loadedFlowFrom(data, previous: previous, dateOf: (s) => s.date),
      ),
    );
  }

  bool _shouldSkipLoad<T>(
    StatementFlow<T> flow, {
    required bool forceRefresh,
    required String label,
  }) {
    if (forceRefresh) return false;
    final skip = flow.maybeMap(
      loading: (_) => true,
      loaded: (s) => s.annual.isNotEmpty,
      orElse: () => false,
    );
    if (skip) {
      _logger.info('Skip loading $label: already loading or data present');
    }
    return skip;
  }

  Future<Either<Failure, _FetchedStatements<T>>> _fetchStatements<T>({
    required UseCase<
      Either<Failure, (List<T>, CompanyProfileDataOrigin)>,
      GetFinancialStatementParams
    >
    useCase,
    required String ticker,
    required String label,
    required String Function(T) dateOf,
  }) async {
    final stopwatch = Stopwatch()..start();
    final results = await Future.wait([
      useCase(GetFinancialStatementParams(ticker: ticker, period: 'annual')),
      useCase(GetFinancialStatementParams(ticker: ticker, period: 'quarter')),
    ]);
    stopwatch.stop();

    return results[0].fold(
      (failure) {
        _logger.severe('Failed to load annual $label', failure);
        return Left(failure);
      },
      (annual) => results[1].fold(
        (failure) {
          _logger.severe('Failed to load quarterly $label', failure);
          return Left(failure);
        },
        (quarterly) {
          _logger.info(
            'Successfully loaded $label: annual=${annual.$1.length}, '
            'quarterly=${quarterly.$1.length}, origin=${annual.$2}',
          );
          return Right((
            annual: _sortedByDateDesc(annual.$1, dateOf),
            quarterly: _sortedByDateDesc(quarterly.$1, dateOf),
            origin: annual.$2,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ));
        },
      ),
    );
  }

  List<T> _sortedByDateDesc<T>(List<T> items, String Function(T) dateOf) =>
      [...items]..sort((a, b) => dateOf(b).compareTo(dateOf(a)));

  StatementFlow<T> _loadedFlowFrom<T>(
    _FetchedStatements<T> data, {
    required StatementFlowLoaded<T>? previous,
    required String Function(T) dateOf,
  }) => StatementFlow.loaded(
    annual: data.annual,
    quarterly: data.quarterly,
    origin: data.origin,
    loadTimeMs: data.loadTimeMs,
    lastUpdated: _timeProvider.nowLocal,
    selectedAnnualDate:
        previous?.selectedAnnualDate ??
        (data.annual.isNotEmpty ? dateOf(data.annual.first) : null),
    selectedQuarterlyDate:
        previous?.selectedQuarterlyDate ??
        (data.quarterly.isNotEmpty ? dateOf(data.quarterly.first) : null),
  );

  String _deriveReportedCurrency(_FetchedStatements<IncomeStatement> data) =>
      data.annual.isNotEmpty
      ? data.annual.first.reportedCurrency
      : (data.quarterly.isNotEmpty
            ? data.quarterly.first.reportedCurrency
            : 'USD');

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${e.type}');
    switch (e.type) {
      case FinancialStatementType.income:
        _checkFlowFreshness(
          state.income,
          label: 'Income statements',
          refresh: () => add(
            FinancialStatementsEvent.loadIncomeStatements(
              e.ticker,
              forceRefresh: true,
            ),
          ),
        );
      case FinancialStatementType.balance:
        _checkFlowFreshness(
          state.balance,
          label: 'Balance sheets',
          refresh: () => add(
            FinancialStatementsEvent.loadBalanceSheets(
              e.ticker,
              forceRefresh: true,
            ),
          ),
        );
      case FinancialStatementType.cashFlow:
        _checkFlowFreshness(
          state.cashFlow,
          label: 'Cash flows',
          refresh: () => add(
            FinancialStatementsEvent.loadCashFlows(
              e.ticker,
              forceRefresh: true,
            ),
          ),
        );
    }
  }

  void _checkFlowFreshness<T>(
    StatementFlow<T> flow, {
    required String label,
    required void Function() refresh,
  }) {
    flow.map(
      initial: (_) => _triggerRefresh(refresh, '$label empty. Triggering load.'),
      loading: (_) =>
          _logger.info('$label already loading. Skipping staleness check.'),
      failure: (_) =>
          _triggerRefresh(refresh, '$label in failure state. Triggering retry.'),
      loaded: (s) {
        final isStale =
            s.lastUpdated != null &&
            _timeProvider.nowLocal.difference(s.lastUpdated!) > _statementsTtl;
        if (isStale || s.annual.isEmpty) {
          _triggerRefresh(
            refresh,
            '$label stale or empty (Last updated: ${s.lastUpdated}). '
            'Triggering load.',
          );
        } else {
          _logger.info('$label still fresh (Last updated: ${s.lastUpdated})');
        }
      },
    );
  }

  void _triggerRefresh(void Function() refresh, String reason) {
    _logger.info(reason);
    refresh();
  }

  Future<void> _onViewTypeChanged(
    ViewTypeChanged e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('View type changed to ${e.type}');
    if (state.selectedType == e.type) return;

    await handleViewTypeChanged(state);
    emit(state.copyWith(selectedType: e.type));
    _markStatementTypeViewed(e.type);
    add(
      FinancialStatementsEvent.stalenessCheckRequested(e.ticker, type: e.type),
    );
  }

  void _markStatementTypeViewed(FinancialStatementType type) {
    switch (type) {
      case FinancialStatementType.income:
        updateIncAnalytics((inc) => inc.copyWith(viewedIncomeTab: true));
      case FinancialStatementType.balance:
        updateBalAnalytics(
          (bal) =>
              bal.copyWith(viewedBalanceTab: true, viewedNetWorthChart: true),
        );
      case FinancialStatementType.cashFlow:
        updateCashAnalytics((cash) => cash.copyWith(viewedCashFlowTab: true));
    }
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
    state.income.mapOrNull(
      loaded: (s) => emit(
        state.copyWith(income: _withSelectedDate(s, e.date, isAnnual: e.isAnnual)),
      ),
    );
  }

  Future<void> _onBalanceDateSelected(
    BalanceDateSelected e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    _logger.info('Balance date selected: ${e.date}, annual=${e.isAnnual}');
    updateBalAnalytics((bal) => bal.copyWith(switchedBalancePeriod: true));
    state.balance.mapOrNull(
      loaded: (s) => emit(
        state.copyWith(balance: _withSelectedDate(s, e.date, isAnnual: e.isAnnual)),
      ),
    );
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
    state.cashFlow.mapOrNull(
      loaded: (s) => emit(
        state.copyWith(cashFlow: _withSelectedDate(s, e.date, isAnnual: e.isAnnual)),
      ),
    );
  }

  StatementFlow<T> _withSelectedDate<T>(
    StatementFlowLoaded<T> flow,
    String date, {
    required bool isAnnual,
  }) => isAnnual
      ? flow.copyWith(selectedAnnualDate: date)
      : flow.copyWith(selectedQuarterlyDate: date);

  Future<void> _onTabShown(
    TabShown e,
    Emitter<FinancialStatementsState> emit,
  ) async {
    final timestamp = _timeProvider.nowLocal.toIso8601String();
    handleTabShown(
      e.ticker,
      initialInc: _buildIncTabShownViewState(e.ticker, timestamp),
      initialBal: _buildBalTabShownViewState(e.ticker, timestamp),
      initialCash: _buildCashTabShownViewState(e.ticker, timestamp),
    );
    _markStatementTypeViewed(state.selectedType);

    if (state.lastUpdatedIncome != null ||
        state.annualIncomeStatements.isNotEmpty) {
      add(
        FinancialStatementsEvent.stalenessCheckRequested(
          e.ticker,
          type: FinancialStatementType.income,
        ),
      );
    }
  }

  IncStmtTabViewState _buildIncTabShownViewState(
    String ticker,
    String timestamp,
  ) => IncStmtTabViewState(
    ticker: ticker,
    timestamp: timestamp,
    loadTimeMs: state.incomeLoadTimeMs,
    isSuccess: state.isIncomeSuccess,
    dataSource: state.incomeOrigin,
  );

  BalStmtTabViewState _buildBalTabShownViewState(
    String ticker,
    String timestamp,
  ) => BalStmtTabViewState(
    ticker: ticker,
    timestamp: timestamp,
    loadTimeMs: state.balanceLoadTimeMs,
    isSuccess: state.isBalanceSuccess,
    dataSource: state.balanceOrigin,
  );

  CashStmtTabViewState _buildCashTabShownViewState(
    String ticker,
    String timestamp,
  ) => CashStmtTabViewState(
    ticker: ticker,
    timestamp: timestamp,
    loadTimeMs: state.cashFlowLoadTimeMs,
    isSuccess: state.isCashFlowSuccess,
    dataSource: state.cashFlowOrigin,
  );

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
            tappedAllIncomeQtrly: !e.isAnnual ? true : inc.tappedAllIncomeQtrly,
          ),
        );
      case FinancialStatementType.balance:
        updateBalAnalytics((bal) => bal.copyWith(tappedAllBalSheet: true));
      case FinancialStatementType.cashFlow:
        updateCashAnalytics(
          (cash) => cash.copyWith(
            tappedAllCashflYrly: e.isAnnual ? true : cash.tappedAllCashflYrly,
            tappedAllCashflQtrly: !e.isAnnual
                ? true
                : cash.tappedAllCashflQtrly,
          ),
        );
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
