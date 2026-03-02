import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';

final _mixinLogger = BizzieLogger('FinancialStatementsAnalyticsMixin');

mixin FinancialStatementsAnalyticsMixin {
  IncStmtTabAnalytics get incTracker;
  BalStmtTabAnalytics get balTracker;
  CashStmtTabAnalytics get cashTracker;

  final Stopwatch _subSessionStopwatch = Stopwatch();

  String? _currentTicker;

  void handleTabShown(String ticker) {
    _mixinLogger.info('handleTabShown for $ticker');
    _currentTicker = ticker;
    _subSessionStopwatch.start();
  }

  Future<void> handleTabHidden(FinancialStatementsState state) async {
    _mixinLogger.info('handleTabHidden');
    if (_currentTicker != null) {
      await _logCurrentSubSession(state, isFinal: true);
    }
    _subSessionStopwatch.stop();
    _subSessionStopwatch.reset();
    _currentTicker = null;
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
    if (_currentTicker != null) {
      await _logCurrentSubSession(state, isFinal: true);
    }
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

    try {
      switch (state.selectedType) {
        case FinancialStatementType.income:
          if (state.incAnalytics != null) {
            final updated = state.incAnalytics!.copyWith(
              viewDurationSec: duration,
            );
            await incTracker.logViewSummary(updated, isFinal: isFinal);
          }
          break;
        case FinancialStatementType.balance:
          if (state.balAnalytics != null) {
            final updated = state.balAnalytics!.copyWith(
              viewDurationSec: duration,
            );
            await balTracker.logViewSummary(updated, isFinal: isFinal);
          }
          break;
        case FinancialStatementType.cashFlow:
          if (state.cashAnalytics != null) {
            final updated = state.cashAnalytics!.copyWith(
              viewDurationSec: duration,
            );
            await cashTracker.logViewSummary(updated, isFinal: isFinal);
          }
          break;
      }
    } catch (e, stack) {
      _mixinLogger.severe('Error logging sub session', e, stack);
    }
  }
}
