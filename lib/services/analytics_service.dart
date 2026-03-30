import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('AnalyticsService');

@LazySingleton(as: IAnalyticsService)
class AnalyticsService implements IAnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    final Map<String, Object> allParams = {
      'timestamp': DateTime.now().toIso8601String(),
    };
    if (parameters != null) {
      parameters.forEach((key, value) {
        if (value != null) {
          if (value is bool) {
            allParams[key] = value.toString();
          } else {
            allParams[key] = value;
          }
        }
      });
    }

    _logger.info('Params: $allParams');
    try {
      await _analytics.logEvent(name: name, parameters: allParams);
      _logger.info('Successfully called Firebase logEvent');
    } catch (e, stack) {
      _logger.severe('Error logging event: $e', e, stack);
    }
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClassOverride,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClassOverride ?? 'Flutter',
    );
  }

  @override
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }
}
