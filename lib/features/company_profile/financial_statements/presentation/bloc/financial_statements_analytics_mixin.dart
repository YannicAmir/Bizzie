import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';

final _mixinLogger = BizzieLogger('FinancialStatementsAnalyticsMixin');

mixin FinancialStatementsAnalyticsMixin {
  IncStmtTabAnalytics get incTracker;
  BalStmtTabAnalytics get balTracker;
  CashStmtTabAnalytics get cashTracker;

  IncStmtTabViewState? _incAnalytics;
  BalStmtTabViewState? _balAnalytics;
  CashStmtTabViewState? _cashAnalytics;

  IncStmtTabViewState? get incAnalytics => _incAnalytics;
  BalStmtTabViewState? get balAnalytics => _balAnalytics;
  CashStmtTabViewState? get cashAnalytics => _cashAnalytics;

  final Stopwatch _subSessionStopwatch = Stopwatch();

  String? _currentTicker;

  void handleTabShown(
    String ticker, {
    required IncStmtTabViewState initialInc,
    required BalStmtTabViewState initialBal,
    required CashStmtTabViewState initialCash,
  }) {
    _mixinLogger.info('handleTabShown for $ticker');
    _currentTicker = ticker;
    _incAnalytics ??= initialInc;
    _balAnalytics ??= initialBal;
    _cashAnalytics ??= initialCash;
    _subSessionStopwatch.start();
  }

  void updateIncAnalytics(
    IncStmtTabViewState Function(IncStmtTabViewState current) update,
  ) {
    final current = _incAnalytics;
    if (current != null) {
      _incAnalytics = update(current);
    }
  }

  void updateBalAnalytics(
    BalStmtTabViewState Function(BalStmtTabViewState current) update,
  ) {
    final current = _balAnalytics;
    if (current != null) {
      _balAnalytics = update(current);
    }
  }

  void updateCashAnalytics(
    CashStmtTabViewState Function(CashStmtTabViewState current) update,
  ) {
    final current = _cashAnalytics;
    if (current != null) {
      _cashAnalytics = update(current);
    }
  }

  Future<void> handleTabHidden(FinancialStatementsState state) async {
    _mixinLogger.info('handleTabHidden');
    if (_currentTicker != null) {
      await _logCurrentSubSession(state, isFinal: true);
    }
    _subSessionStopwatch.stop();
    _subSessionStopwatch.reset();
    _currentTicker = null;
    _incAnalytics = null;
    _balAnalytics = null;
    _cashAnalytics = null;
  }

  Future<void> handleAppBackgrounded(FinancialStatementsState state) async {
    _mixinLogger.info('handleAppBackgrounded');
    if (_subSessionStopwatch.isRunning) {
      await _logCurrentSubSession(state, isFinal: false);
      _subSessionStopwatch.stop();
    }
  }

  void handleAppForegrounded() {
    _mixinLogger.info('handleAppForegrounded');
    if (_currentTicker != null) {
      _subSessionStopwatch.start();
    }
  }

  Future<void> handleViewTypeChanged(FinancialStatementsState state) async {
    _mixinLogger.info('handleViewTypeChanged - logging previous sub session');
    if (_currentTicker == null) return;
    await _logCurrentSubSession(state, isFinal: true);
    _subSessionStopwatch.reset();
    _subSessionStopwatch.start();
  }

  Future<void> _logCurrentSubSession(
    FinancialStatementsState state, {
    required bool isFinal,
  }) async {
    if (_currentTicker == null) return;

    final duration = _subSessionStopwatch.elapsed.inSeconds;
    _mixinLogger.info(
      'Logging sub session for ${state.selectedType}, duration=$duration, isFinal=$isFinal',
    );

    switch (state.selectedType) {
      case FinancialStatementType.income:
        final inc = _incAnalytics;
        if (inc != null) {
          await incTracker.logViewSummary(
            inc.copyWith(viewDurationSec: duration),
            isFinal: isFinal,
          );
        }
        break;
      case FinancialStatementType.balance:
        final bal = _balAnalytics;
        if (bal != null) {
          await balTracker.logViewSummary(
            bal.copyWith(viewDurationSec: duration),
            isFinal: isFinal,
          );
        }
        break;
      case FinancialStatementType.cashFlow:
        final cash = _cashAnalytics;
        if (cash != null) {
          await cashTracker.logViewSummary(
            cash.copyWith(viewDurationSec: duration),
            isFinal: isFinal,
          );
        }
        break;
    }
  }
}
