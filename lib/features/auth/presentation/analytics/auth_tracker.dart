import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('AuthTracker');

@lazySingleton
class AuthTracker {
  final IAnalyticsService _analytics;

  static const _kScreenName = 'auth';

  static const String _kEventGuestGateShown = 'guest_gate_shown';
  static const String _kEventGuestAccountLinked = 'guest_account_linked';
  static const String _kEventLoginStarted = 'auth_login_started';
  static const String _kEventLogin = 'login';
  static const String _kEventLoginFailure = 'auth_login_failure';
  static const String _kEventSignUpStarted = 'auth_signup_started';
  static const String _kEventSignUp = 'sign_up';
  static const String _kEventSignUpFailure = 'auth_signup_failure';
  static const String _kEventLogout = 'auth_logout';
  static const String _kEventPasswordResetRequested =
      'auth_password_reset_requested';
  static const String _kEventAccountDeleted = 'auth_account_deleted';
  static const String _kEventLinkClicked = 'auth_link_clicked';

  static const String _kParamScreenName = 'screen_name';
  static const String _kParamTrigger = 'trigger';
  static const String _kParamMethod = 'method';
  static const String _kParamFallbackSignIn = 'fallback_sign_in';
  static const String _kParamSource = 'source';
  static const String _kParamErrorCode = 'error_code';
  static const String _kParamType = 'type';
  static const String _kParamTimestamp = 'timestamp';

  static const String _kPropAccountType = 'account_type';
  static const String _kPropAuthMethod = 'auth_method';
  static const String _kPropLastLoginSource = 'last_login_source';

  static const String _kValueAccountTypeGuest = 'guest';
  static const String _kValueAccountTypeRegistered = 'registered';
  static const String _kValueTriggerSubscribe = 'subscribe';
  static const String _kValueTriggerRestore = 'restore';
  static const String _kValueTriggerSettings = 'settings';

  AuthTracker(this._analytics);

  /// Sets the user ID for all subsequent events.
  Future<void> setUserId(String? id) async {
    try {
      await _analytics.setUserId(id);
    } catch (e, stack) {
      _logger.severe('Failed to set user ID', e, stack);
    }
  }

  Future<void> setAccountType({required bool isGuest}) async {
    await _setUserProperty(
      _kPropAccountType,
      isGuest ? _kValueAccountTypeGuest : _kValueAccountTypeRegistered,
    );
  }

  Future<void> logGuestGateShown({required GuestGateTrigger trigger}) async {
    await _logEvent(_kEventGuestGateShown, {
      _kParamTrigger: _mapTrigger(trigger),
    });
  }

  Future<void> logGuestAccountLinked({
    required AuthMethod method,
    required GuestGateTrigger? trigger,
    required bool fallbackSignIn,
  }) async {
    await _logEvent(_kEventGuestAccountLinked, {
      _kParamMethod: method.name,
      if (trigger != null) _kParamTrigger: _mapTrigger(trigger),
      _kParamFallbackSignIn: fallbackSignIn,
    });
  }

  /// Logs the start of a login process.
  Future<void> logLoginStarted({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _logEvent(_kEventLoginStarted, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
    });
  }

  /// Logs a successful login using the standard GA4 'login' event.
  Future<void> logLoginSuccess({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _setUserProperty(_kPropAuthMethod, method.name);
    await _setUserProperty(_kPropLastLoginSource, _mapSource(source));

    await _logEvent(_kEventLogin, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
    });
  }

  /// Logs a failed login attempt.
  Future<void> logLoginFailure({
    required AuthMethod method,
    required AuthSource source,
    required String error,
  }) async {
    await _logEvent(_kEventLoginFailure, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
      _kParamErrorCode: error,
    });
  }

  /// Logs the start of a sign-up process.
  Future<void> logSignUpStarted({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _logEvent(_kEventSignUpStarted, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
    });
  }

  /// Logs a successful sign-up using the standard GA4 'sign_up' event.
  Future<void> logSignUpSuccess({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _setUserProperty(_kPropAuthMethod, method.name);
    await _setUserProperty(_kPropLastLoginSource, _mapSource(source));

    await _logEvent(_kEventSignUp, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
    });
  }

  /// Logs a failed sign-up attempt.
  Future<void> logSignUpFailure({
    required AuthMethod method,
    required AuthSource source,
    required String error,
  }) async {
    await _logEvent(_kEventSignUpFailure, {
      _kParamMethod: method.name,
      _kParamSource: _mapSource(source),
      _kParamErrorCode: error,
    });
  }

  /// Logs a user logout.
  Future<void> logLogout() async {
    await _logEvent(_kEventLogout);
  }

  /// Logs a password reset request.
  Future<void> logPasswordResetRequested({required AuthSource source}) async {
    await _logEvent(_kEventPasswordResetRequested, {
      _kParamSource: _mapSource(source),
    });
  }

  /// Logs an account deletion.
  Future<void> logAccountDeleted() async {
    await _logEvent(_kEventAccountDeleted);
  }

  /// Logs when a legal link is clicked.
  Future<void> logAuthLinkClicked({required String type}) async {
    await _logEvent(_kEventLinkClicked, {
      _kParamType: type,
      _kParamTimestamp: DateTime.now().toIso8601String(),
    });
  }

  Future<void> _logEvent(String name, [Map<String, Object>? parameters]) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {...?parameters, _kParamScreenName: _kScreenName},
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

  Future<void> _setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e, stack) {
      _logger.severe('Failed to set user property: $name', e, stack);
    }
  }

  String _mapTrigger(GuestGateTrigger trigger) => switch (trigger) {
    GuestGateTrigger.subscribe => _kValueTriggerSubscribe,
    GuestGateTrigger.restore => _kValueTriggerRestore,
    GuestGateTrigger.settings => _kValueTriggerSettings,
  };

  String _mapSource(AuthSource source) {
    return switch (source) {
      AuthSource.landing => 'landing',
      AuthSource.onboarding => 'onboarding',
      AuthSource.settings => 'settings',
      AuthSource.sessionExpired => 'session_expired',
      AuthSource.forgotPassword => 'forgot_password',
      AuthSource.createAccount => 'create_account',
      AuthSource.guestGate => 'guest_gate',
    };
  }
}
