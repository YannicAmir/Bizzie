import 'dart:async';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/settings/domain/enums/guest_logout_choice.dart';
import 'package:bizzie/features/settings/domain/enums/settings_link_type.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SettingsTracker');

@lazySingleton
class SettingsTracker {
  final IAnalyticsService _analytics;

  SettingsTracker(this._analytics);

  static const String _kScreenName = 'settings';

  static const String _kEventSettingsViewed = 'settings_viewed';
  static const String _kEventNotificationsToggled =
      'settings_notifications_toggled';
  static const String _kEventNotificationsPermissionDenied =
      'settings_notifications_permission_denied';
  static const String _kEventSignOutClicked = 'settings_sign_out_clicked';
  static const String _kEventSignOutSuccess = 'settings_sign_out_success';
  static const String _kEventGuestLogoutChoice = 'settings_guest_logout_choice';
  static const String _kEventLinkClicked = 'settings_link_clicked';
  static const String _kEventSystemSettingsOpened =
      'settings_system_settings_opened';
  static const String _kEventSectorChangeViewed =
      'settings_sector_change_viewed';
  static const String _kEventSectorSelected = 'settings_sector_selected';
  static const String _kEventSectorUpdateSuccess =
      'settings_sector_update_success';
  static const String _kEventSectorUpdateFailure =
      'settings_sector_update_failure';
  static const String _kEventEditProfileClicked =
      'settings_edit_profile_clicked';
  static const String _kEventFeedbackClicked = 'settings_feedback_clicked';
  static const String _kEventMembershipClicked = 'settings_membership_clicked';

  static const String _kParamAccountType = 'account_type';
  static const String _kParamChoice = 'choice';
  static const String _kParamEnabled = 'enabled';
  static const String _kParamType = 'type';
  static const String _kParamSector = 'sector';
  static const String _kParamError = 'error';
  static const String _kParamIsSubscribed = 'is_subscribed';
  static const String _kParamScreenName = 'screen_name';
  static const String _kParamTimestamp = 'timestamp';

  static const String _kUserPropFavoriteSector = 'favorite_sector';

  static const String _kValueAccountTypeGuest = 'guest';
  static const String _kValueAccountTypeRegistered = 'registered';
  static const String _kValueChoiceCreateAccount = 'create_account';
  static const String _kValueChoiceLogOut = 'log_out';
  static const String _kValueChoiceDismissed = 'dismissed';
  static const String _kValueLinkTypePrivacyPolicy = 'privacy_policy';
  static const String _kValueLinkTypeTermsOfService = 'terms_of_service';

  /// Logs when the user views the settings screen.
  Future<void> logSettingsViewed() async {
    await _logEvent(name: _kEventSettingsViewed);
  }

  /// Logs when the user toggles app notifications.
  Future<void> logNotificationsToggled({required bool enabled}) async {
    await _logEvent(
      name: _kEventNotificationsToggled,
      parameters: {_kParamEnabled: enabled},
    );
  }

  /// Logs when notifications are toggled on but system permissions are denied.
  Future<void> logNotificationsPermissionDenied() async {
    await _logEvent(name: _kEventNotificationsPermissionDenied);
  }

  /// Logs when the user initiates sign out.
  Future<void> logSignOutClicked({required bool isGuest}) async {
    await _logEvent(
      name: _kEventSignOutClicked,
      parameters: {_kParamAccountType: _mapAccountType(isGuest: isGuest)},
    );
  }

  /// Logs when sign out is successful.
  Future<void> logSignOutSuccess({required bool isGuest}) async {
    await _logEvent(
      name: _kEventSignOutSuccess,
      parameters: {_kParamAccountType: _mapAccountType(isGuest: isGuest)},
    );
  }

  /// Logs the guest's choice on the log out confirmation sheet.
  Future<void> logGuestLogoutChoice({required GuestLogoutChoice choice}) async {
    await _logEvent(
      name: _kEventGuestLogoutChoice,
      parameters: {_kParamChoice: _mapChoice(choice)},
    );
  }

  /// Logs when a legal or support link is clicked.
  Future<void> logSettingsLinkClicked({required SettingsLinkType type}) async {
    await _logEvent(
      name: _kEventLinkClicked,
      parameters: {_kParamType: _mapLinkType(type)},
    );
  }

  /// Logs when the user opens system settings from the permission modal.
  Future<void> logSystemSettingsOpened() async {
    await _logEvent(name: _kEventSystemSettingsOpened);
  }

  /// Logs when the sector change modal is opened.
  Future<void> logSectorChangeViewed() async {
    await _logEvent(name: _kEventSectorChangeViewed);
  }

  /// Logs when a new sector is selected in the list.
  Future<void> logSectorSelected({required String sector}) async {
    await _logEvent(
      name: _kEventSectorSelected,
      parameters: {_kParamSector: sector},
    );
  }

  /// Logs when the favorite sector is successfully updated.
  Future<void> logSectorUpdateSuccess({required String sector}) async {
    await _logEvent(
      name: _kEventSectorUpdateSuccess,
      parameters: {_kParamSector: sector},
    );
    try {
      await _analytics.setUserProperty(
        name: _kUserPropFavoriteSector,
        value: sector,
      );
    } catch (e, stack) {
      _logger.severe('Failed to set favorite_sector property', e, stack);
    }
  }

  /// Logs when the favorite sector update fails.
  Future<void> logSectorUpdateFailure({
    required String sector,
    required String error,
  }) async {
    await _logEvent(
      name: _kEventSectorUpdateFailure,
      parameters: {_kParamSector: sector, _kParamError: error},
    );
  }

  /// Logs when the user navigates to Edit Profile.
  Future<void> logEditProfileClicked() async {
    await _logEvent(name: _kEventEditProfileClicked);
  }

  /// Logs when the user initiates the feedback flow.
  Future<void> logFeedbackClicked() async {
    await _logEvent(name: _kEventFeedbackClicked);
  }

  /// Logs when the user navigates to the Membership/Paywall screen.
  Future<void> logMembershipClicked({required bool isSubscribed}) async {
    await _logEvent(
      name: _kEventMembershipClicked,
      parameters: {_kParamIsSubscribed: isSubscribed},
    );
  }

  String _mapAccountType({required bool isGuest}) =>
      isGuest ? _kValueAccountTypeGuest : _kValueAccountTypeRegistered;

  String _mapChoice(GuestLogoutChoice choice) => switch (choice) {
    GuestLogoutChoice.createAccount => _kValueChoiceCreateAccount,
    GuestLogoutChoice.logOut => _kValueChoiceLogOut,
    GuestLogoutChoice.dismissed => _kValueChoiceDismissed,
  };

  String _mapLinkType(SettingsLinkType type) => switch (type) {
    SettingsLinkType.privacyPolicy => _kValueLinkTypePrivacyPolicy,
    SettingsLinkType.termsOfService => _kValueLinkTypeTermsOfService,
  };

  /// Helper to log events with standard parameters.
  Future<void> _logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...?parameters,
          _kParamScreenName: _kScreenName,
          _kParamTimestamp: DateTime.now().toIso8601String(),
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }
}
