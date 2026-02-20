import 'dart:async';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

final _logger = Logger('SettingsTracker');

@injectable
class SettingsTracker {
  final IAnalyticsService _analytics;

  SettingsTracker(this._analytics);

  static const String _kScreenName = 'settings';

  /// Logs when the user views the settings screen.
  Future<void> logSettingsViewed() async {
    await _logEvent(name: 'settings_viewed');
  }

  /// Logs when the user toggles app notifications.
  Future<void> logNotificationsToggled({required bool enabled}) async {
    await _logEvent(
      name: 'settings_notifications_toggled',
      parameters: {'enabled': enabled},
    );
  }

  /// Logs when notifications are toggled on but system permissions are denied.
  Future<void> logNotificationsPermissionDenied() async {
    await _logEvent(name: 'settings_notifications_permission_denied');
  }

  /// Logs when the user initiates a password reset.
  Future<void> logPasswordResetClicked() async {
    await _logEvent(name: 'settings_password_reset_clicked');
  }

  /// Logs when the user initiates sign out.
  Future<void> logSignOutClicked() async {
    await _logEvent(name: 'settings_sign_out_clicked');
  }

  /// Logs when sign out is successful.
  Future<void> logSignOutSuccess() async {
    await _logEvent(name: 'settings_sign_out_success');
  }

  /// Logs when a legal or support link is clicked.
  Future<void> logSettingsLinkClicked({required String type}) async {
    await _logEvent(name: 'settings_link_clicked', parameters: {'type': type});
  }

  /// Logs when the user opens system settings from the permission modal.
  Future<void> logSystemSettingsOpened() async {
    await _logEvent(name: 'settings_system_settings_opened');
  }

  /// Logs when the sector change modal is opened.
  Future<void> logSectorChangeViewed() async {
    await _logEvent(name: 'settings_sector_change_viewed');
  }

  /// Logs when a new sector is selected in the list.
  Future<void> logSectorSelected({required String sector}) async {
    await _logEvent(
      name: 'settings_sector_selected',
      parameters: {'sector': sector},
    );
  }

  /// Logs when the favorite sector is successfully updated.
  Future<void> logSectorUpdateSuccess({required String sector}) async {
    await _logEvent(
      name: 'settings_sector_update_success',
      parameters: {'sector': sector},
    );
    try {
      await _analytics.setUserProperty(name: 'favorite_sector', value: sector);
    } catch (e, stack) {
      _logger.warning('Failed to set favorite_sector property', e, stack);
    }
  }

  /// Logs when the favorite sector update fails.
  Future<void> logSectorUpdateFailure({
    required String sector,
    required String error,
  }) async {
    await _logEvent(
      name: 'settings_sector_update_failure',
      parameters: {'sector': sector, 'error': error},
    );
  }

  /// Logs when the user navigates to Edit Profile.
  Future<void> logEditProfileClicked() async {
    await _logEvent(name: 'settings_edit_profile_clicked');
  }

  /// Logs when the user initiates the feedback flow.
  Future<void> logFeedbackClicked() async {
    await _logEvent(name: 'settings_feedback_clicked');
  }

  /// Logs when the user navigates to the Membership/Paywall screen.
  Future<void> logMembershipClicked({required bool isSubscribed}) async {
    await _logEvent(
      name: 'settings_membership_clicked',
      parameters: {'is_subscribed': isSubscribed},
    );
  }

  /// Helper to log events with standard parameters.
  Future<void> _logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      final params = (parameters ?? <String, Object>{})
        ..addAll({
          'screen_name': _kScreenName,
          'timestamp': DateTime.now().toIso8601String(),
        });

      await _analytics.logEvent(name: name, parameters: params);
    } catch (e, stack) {
      _logger.warning('Failed to log event: $name', e, stack);
    }
  }
}
