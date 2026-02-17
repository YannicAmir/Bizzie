import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/core/config/flavor_config.dart';
import 'package:freerasp/freerasp.dart';
import 'package:logging/logging.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/core/constants/security_constants.dart';

final _logger = Logger('SecurityService');

class SecurityService {
  final AppEnv _env;
  final IConfigService _configService;
  final IAuthRepository? _authRepository;

  final ValueNotifier<bool> isThreatDetected = ValueNotifier(false);

  SecurityService(this._env, this._configService, [this._authRepository]);

  Future<void> init() async {
    if (!Platform.isIOS) {
      _logger.info('Skipping SecurityService init on non-iOS platform');
      return;
    }

    final config = TalsecConfig(
      androidConfig: null, // Android skipped for now
      iosConfig: IOSConfig(
        bundleIds: [_env.bundleId],
        teamId: _env.appleTeamId,
      ),
      watcherMail: _configService.securityWatcherMail,
      isProd: FlavorConfig.isProd,
      killOnBypass: true,
    );

    final callback = ThreatCallback(
      onAppIntegrity: () => handleThreat(SecurityConstants.appIntegrity),
      onObfuscationIssues: () =>
          handleThreat(SecurityConstants.obfuscationIssues),
      onDebug: () => handleThreat(SecurityConstants.debugging),
      onDeviceBinding: () => handleThreat(SecurityConstants.deviceBinding),
      onDeviceID: () => handleThreat(SecurityConstants.deviceID),
      onHooks: () => handleThreat(SecurityConstants.hooks, isCritical: true),
      onPrivilegedAccess: () =>
          handleThreat(SecurityConstants.privilegedAccess, isCritical: true),
      onSecureHardwareNotAvailable: () =>
          handleThreat(SecurityConstants.secureHardwareNotAvailable),
      onSimulator: () => handleThreat(SecurityConstants.simulator),
      onUnofficialStore: () => handleThreat(SecurityConstants.unofficialStore),
    );

    Talsec.instance.attachListener(callback);

    _logger.info('Talsec.start called at ${DateTime.now()}');
    await Talsec.instance.start(config);
    _logger.info('Talsec.start returned at ${DateTime.now()}');
    _logger.info('SecurityService started (Prod: ${FlavorConfig.isProd})');
    if (Platform.isIOS && FlavorConfig.isProd) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      if (!iosInfo.isPhysicalDevice) {
        handleThreat(SecurityConstants.simulatorDeviceInfo);
      }
    }
  }

  @visibleForTesting
  Future<void> handleThreat(
    String threatType, {
    bool isCritical = false,
  }) async {
    final message = 'Security Threat Detected: $threatType';

    if (FlavorConfig.isProd) {
      _logger.severe(message);
      await _gracefulShutdown();
      isThreatDetected.value = true;
    } else {
      if (threatType == SecurityConstants.unofficialStore) {
        _logger.warning('$message (Whitelisted for Non-Prod)');
        return;
      }

      _logger.warning('$message (Lockout skipped for non-Prod)');
    }
  }

  Future<void> _gracefulShutdown() async {
    _logger.severe('Initiating graceful shutdown due to security threat...');

    try {
      final authRepo = _authRepository ?? getIt<IAuthRepository>();
      await authRepo.signOut();
      _logger.info('User forcefully signed out due to security threat.');
    } catch (e) {
      _logger.warning('Failed to sign out during graceful shutdown: $e');
    }
  }
}
