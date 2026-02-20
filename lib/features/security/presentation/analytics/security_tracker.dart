import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/security/domain/enums/security_analytics_enums.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

final _logger = Logger('SecurityTracker');

@injectable
class SecurityTracker {
  final IAnalyticsService _analytics;

  SecurityTracker(this._analytics);

  /// Logs when a security threat is detected with its type and criticality.
  Future<void> logThreatDetected({
    required SecurityThreatType type,
    required bool isCritical,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'security_threat_detected',
        parameters: {
          'threat_type': type.analyticsValue,
          'is_critical': isCritical,
          'timestamp': DateTime.now().toIso8601String(),
          'screen_name': 'security_lockout',
        },
      );
    } catch (e, stack) {
      _logger.warning('Failed to log security_threat_detected', e, stack);
    }
  }

  /// Logs when the security lockout screen is displayed to the user.
  Future<void> logLockoutViewed() async {
    try {
      await _analytics.logEvent(
        name: 'security_lockout_viewed',
        parameters: {
          'timestamp': DateTime.now().toIso8601String(),
          'screen_name': 'security_lockout',
        },
      );
    } catch (e, stack) {
      _logger.warning('Failed to log security_lockout_viewed', e, stack);
    }
  }

  /// Logs user interactions on the lockout screen (e.g., closing the app).
  Future<void> logLockoutAction(SecurityLockoutAction action) async {
    try {
      await _analytics.logEvent(
        name: 'security_lockout_action',
        parameters: {
          'action': action.analyticsValue,
          'timestamp': DateTime.now().toIso8601String(),
          'screen_name': 'security_lockout',
        },
      );
    } catch (e, stack) {
      _logger.warning('Failed to log security_lockout_action', e, stack);
    }
  }

  /// Sets the persistent device security threat user property.
  Future<void> setSecurityThreatProperty(SecurityThreatType? type) async {
    try {
      await _analytics.setUserProperty(
        name: 'device_security_threat',
        value: type?.analyticsValue,
      );
    } catch (e, stack) {
      _logger.warning(
        'Failed to set device_security_threat property',
        e,
        stack,
      );
    }
  }
}
