import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileTracker {
  final IAnalyticsService _analytics;
  final AnalyticsContext _analyticsContext;

  ProfileTracker(this._analytics, this._analyticsContext);

  static const _kScreenName = 'profile';

  Future<void> _logEvent(String name, Map<String, dynamic> params) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...params,
        'screen_name': _kScreenName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Logs when the profile data is successfully loaded.
  /// Also sets the user property for favorite sector.
  Future<void> logProfileLoaded(ProfileDisplayData data) async {
    await _analytics.setUserProperty(
      name: 'favorite_sector',
      value: data.sectorName,
    );
  }

  /// Logs a technical failure fetching profile data.
  Future<void> logProfileLoadFailure({
    required String type,
    required String message,
  }) async {
    await _logEvent('profile_load_failure', {
      'error_type': type,
      'error_message': message,
    });
  }

  /// Logs when the user enters the edit profile flow.
  Future<void> logEditProfileStarted() async {
    await _logEvent('edit_profile_started', {});
  }

  /// Logs a successful profile update with the list of modified fields.
  Future<void> logProfileUpdateSuccess({
    required List<String> updatedFields,
  }) async {
    await _logEvent('profile_update_success', {
      'updated_fields': updatedFields.join(','),
    });
  }

  /// Logs a failure during profile update.
  Future<void> logProfileUpdateFailure({
    required String type,
    required String message,
  }) async {
    await _logEvent('profile_update_failure', {
      'error_type': type,
      'error_message': message,
    });
  }

  /// Logs a successful password change.
  Future<void> logPasswordChangeSuccess() async {
    await _logEvent('password_change_success', {});
  }

  /// Logs a failure during password change.
  Future<void> logPasswordChangeFailure({
    required String type,
    required String message,
  }) async {
    await _logEvent('password_change_failure', {
      'error_type': type,
      'error_message': message,
    });
  }

  /// Logs when the re-authentication modal is displayed.
  Future<void> logReauthStarted({required String reason}) async {
    await _logEvent('reauth_started', {'reason': reason});
  }

  /// Logs the result of a re-authentication attempt.
  Future<void> logReauthResult({
    required String provider,
    required bool success,
    required int attempts,
  }) async {
    await _logEvent('reauth_result', {
      'provider': provider,
      'success': success,
      'attempt_count': attempts,
    });
  }

  /// Logs when the user initiates the account deletion confirmation.
  Future<void> logDeleteAccountInitiated() async {
    await _logEvent('delete_account_initiated', {});
  }

  /// Logs when the account is successfully deleted.
  Future<void> logAccountDeletionSuccess() async {
    _analyticsContext.isPostDeletion = true;
    await _logEvent('account_deletion_success', {});
  }
}
