import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bloc/bloc.dart';

final _mixinLogger = BizzieLogger('CompanyProfileAnalyticsMixin');

mixin CompanyProfileAnalyticsMixin<
  E,
  S,
  T extends CompanyProfileTabAnalyticsState
>
    on Bloc<E, S> {
  final Stopwatch _sessionStopwatch = Stopwatch();

  T? _analyticsSession;
  CompanyProfileTabTracker<T> get analyticsTracker;

  T? get analyticsSession => _analyticsSession;

  void startTracking(String ticker, T initialState) {
    _mixinLogger.info('startTracking for $ticker');
    _analyticsSession = initialState;
    _sessionStopwatch.start();
  }

  void onTabShown(String ticker, T initialState) {
    if (_analyticsSession == null) {
      startTracking(ticker, initialState);
    } else {
      _sessionStopwatch.start();
    }
  }

  Future<void> onTabHidden() async {
    await logSummary(isFinal: true);
    _sessionStopwatch.stop();
    _sessionStopwatch.reset();
    _analyticsSession = null;
  }

  Future<void> onAppBackgrounded() async {
    if (_sessionStopwatch.isRunning) {
      await logSummary(isFinal: false);
      _sessionStopwatch.stop();
    }
  }

  void onAppForegrounded() {
    if (_analyticsSession != null) {
      _sessionStopwatch.start();
    }
  }

  void updateAnalyticsState(T Function(T current) update) {
    if (_analyticsSession != null) {
      _analyticsSession = update(_analyticsSession!);
    }
  }

  Future<void> logSummary({required bool isFinal}) async {
    _mixinLogger.info(
      'logSummary isFinal=$isFinal, sessionActive=${_analyticsSession != null}',
    );
    if (_analyticsSession == null) return;

    final duration = _sessionStopwatch.elapsed.inSeconds;
    _mixinLogger.info(
      'Logging summary for ${_analyticsSession!.ticker}, duration=$duration',
    );

    final updated = _analyticsSession!.copyWithDuration(duration) as T;

    await analyticsTracker.logViewSummary(updated, isFinal: isFinal);
  }
}
