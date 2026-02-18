import 'package:bizzie/features/app_status/domain/enums/app_status_type.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppStatusTracker {
  final IAnalyticsService _analytics;

  static const _kScreenName = 'app_status';

  AppStatusTracker(this._analytics);

  /// Logs when the app is blocked by a specific state (maintenance, force_upgrade, etc.)
  Future<void> logStatusBlocked({
    required String type,
    String? minVersion,
  }) async {
    await _analytics.logEvent(
      name: 'app_status_blocked',
      parameters: {
        'screen_name': _kScreenName,
        'block_type': type,
        if (minVersion != null) 'min_version': minVersion,
      },
    );
  }

  /// Logs when the app status is successfully validated as normal.
  Future<void> logStatusNormal({required bool isManualRefresh}) async {
    await _analytics.logEvent(
      name: 'app_status_normal',
      parameters: {
        'screen_name': _kScreenName,
        'is_manual_refresh': isManualRefresh,
      },
    );
  }

  /// Logs when a user initiates a manual refresh of the app status.
  Future<void> logStatusRefresh() async {
    await _analytics.logEvent(
      name: 'app_status_refresh',
      parameters: {'screen_name': _kScreenName},
    );
  }

  /// Updates the global app_status user property.
  Future<void> updateStatusProperty(AppStatusType status) async {
    final statusValue = switch (status) {
      AppStatusType.normal => 'normal',
      AppStatusType.forceUpgrade => 'force_upgrade',
      AppStatusType.noInternet => 'no_internet',
      AppStatusType.maintenance => 'maintenance',
    };

    await _analytics.setUserProperty(name: 'app_status', value: statusValue);
  }
}
