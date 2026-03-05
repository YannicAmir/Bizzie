import 'package:bizzie/features/app_status/domain/enums/app_status_type.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppStatusTracker {
  final IAnalyticsService _analytics;
  final _logger = BizzieLogger('AppStatusTracker');

  // Event Names
  static const _kEventBlocked = 'app_status_blocked';

  // Parameter Keys
  static const _kParamScreenName = 'screen_name';
  static const _kParamBlockType = 'block_type';
  static const _kParamMinVersion = 'min_version';
  static const _kParamAppStatusKey = 'app_status';

  // Fixed Values
  static const _kScreenName = 'app_status';

  AppStatusTracker(this._analytics);

  /// High-level tracking policy that handles both user property updates
  /// and "blocked" event logging while ignoring redundant "normal" events.
  Future<void> trackStatus(AppStatus status) async {
    try {
      final statusType = status.map(
        normal: (_) => AppStatusType.normal,
        forceUpgrade: (_) => AppStatusType.forceUpgrade,
        noInternet: (_) => AppStatusType.noInternet,
        maintenance: (_) => AppStatusType.maintenance,
      );
      await updateStatusProperty(statusType);

      await status.maybeWhen(
        forceUpgrade: (version, url) =>
            logStatusBlocked(type: 'force_upgrade', minVersion: version),
        noInternet: () => logStatusBlocked(type: 'no_internet'),
        maintenance: () => logStatusBlocked(type: 'maintenance'),
        orElse: () {},
      );
    } catch (e, stack) {
      _logger.severe('Failed to track app status', e, stack);
    }
  }

  /// Logs when the app is blocked by a specific state (maintenance, force_upgrade, etc.)
  Future<void> logStatusBlocked({
    required String type,
    String? minVersion,
  }) async {
    try {
      await _analytics.logEvent(
        name: _kEventBlocked,
        parameters: {
          _kParamScreenName: _kScreenName,
          _kParamBlockType: type,
          if (minVersion != null) _kParamMinVersion: minVersion,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log app_status_blocked', e, stack);
    }
  }

  /// Updates the global app_status user property.
  Future<void> updateStatusProperty(AppStatusType status) async {
    try {
      final statusValue = switch (status) {
        AppStatusType.normal => 'normal',
        AppStatusType.forceUpgrade => 'force_upgrade',
        AppStatusType.noInternet => 'no_internet',
        AppStatusType.maintenance => 'maintenance',
      };

      await _analytics.setUserProperty(
        name: _kParamAppStatusKey,
        value: statusValue,
      );
    } catch (e, stack) {
      _logger.severe('Failed to update app_status user property', e, stack);
    }
  }
}
