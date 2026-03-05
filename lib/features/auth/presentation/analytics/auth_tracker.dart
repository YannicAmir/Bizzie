import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthTracker {
  final IAnalyticsService _analytics;

  static const _kScreenName = 'auth';

  AuthTracker(this._analytics);

  /// Sets the user ID for all subsequent events.
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id);
  }

  /// Logs the start of a login process.
  Future<void> logLoginStarted({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _analytics.logEvent(
      name: 'auth_login_started',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs a successful login using the standard GA4 'login' event.
  Future<void> logLoginSuccess({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _analytics.setUserProperty(name: 'auth_method', value: method.name);
    await _analytics.setUserProperty(
      name: 'last_login_source',
      value: _mapSource(source),
    );

    await _analytics.logEvent(
      name: 'login',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs a failed login attempt.
  Future<void> logLoginFailure({
    required AuthMethod method,
    required AuthSource source,
    required String error,
  }) async {
    await _analytics.logEvent(
      name: 'auth_login_failure',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'error_code': error,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs the start of a sign-up process.
  Future<void> logSignUpStarted({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _analytics.logEvent(
      name: 'auth_signup_started',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs a successful sign-up using the standard GA4 'sign_up' event.
  Future<void> logSignUpSuccess({
    required AuthMethod method,
    required AuthSource source,
  }) async {
    await _analytics.setUserProperty(name: 'auth_method', value: method.name);
    await _analytics.setUserProperty(
      name: 'last_login_source',
      value: _mapSource(source),
    );

    await _analytics.logEvent(
      name: 'sign_up',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs a failed sign-up attempt.
  Future<void> logSignUpFailure({
    required AuthMethod method,
    required AuthSource source,
    required String error,
  }) async {
    await _analytics.logEvent(
      name: 'auth_signup_failure',
      parameters: {
        'method': method.name,
        'source': _mapSource(source),
        'error_code': error,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs a user logout.
  Future<void> logLogout() async {
    await _analytics.logEvent(
      name: 'auth_logout',
      parameters: {'screen_name': _kScreenName},
    );
  }

  /// Logs a password reset request.
  Future<void> logPasswordResetRequested({required AuthSource source}) async {
    await _analytics.logEvent(
      name: 'auth_password_reset_requested',
      parameters: {'source': _mapSource(source), 'screen_name': _kScreenName},
    );
  }

  /// Logs an account deletion.
  Future<void> logAccountDeleted() async {
    await _analytics.logEvent(
      name: 'auth_account_deleted',
      parameters: {'screen_name': _kScreenName},
    );
  }

  String _mapSource(AuthSource source) {
    return switch (source) {
      AuthSource.landing => 'landing',
      AuthSource.onboarding => 'onboarding',
      AuthSource.settings => 'settings',
      AuthSource.sessionExpired => 'session_expired',
      AuthSource.forgotPassword => 'forgot_password',
      AuthSource.createAccount => 'create_account',
    };
  }
}
