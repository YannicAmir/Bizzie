import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_connectivity_service.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/core/services/app_info_service.dart';
import 'package:bizzie/features/app_status/domain/interfaces/i_local_app_status_data_source.dart';
import 'package:bizzie/features/app_status/domain/interfaces/i_app_status_repository.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('AppStatusRepository');

@Injectable(as: IAppStatusRepository)
class AppStatusRepositoryImpl implements IAppStatusRepository {
  final IConfigService _configService;
  final ILocalAppStatusDataSource _localDataSource;
  final IConnectivityService _connectivityService;
  final IAppInfoService _appInfoService;
  final ILifecycleService _lifecycleService;

  AppStatusRepositoryImpl(
    this._configService,
    this._localDataSource,
    this._connectivityService,
    this._appInfoService,
    this._lifecycleService,
  );

  @override
  Stream<AppStatus> watchStatus() async* {
    _logger.info('Starting watchStatus stream');

    yield await _checkCachedStatus();

    if (await _connectivityService.hasInternetConnection) {
      yield await checkStatus();
    }

    final triggerStream = _buildTriggerStream();

    yield* triggerStream
        .where(_shouldProcessEvent)
        .asyncMap(_processTriggerEvent);
  }

  Stream<String> _buildTriggerStream() {
    final realTimeStream = _configService.onConfigUpdated.map(
      (_) => 'realtime',
    );
    final pollStream = Stream.periodic(
      const Duration(minutes: 30),
    ).map((_) => 'poll');
    final connectivityStream = _connectivityService.onConnectivityChanged
        .debounceTime(const Duration(seconds: 5))
        .map(
          (connected) => connected
              ? 'connectivity:connected'
              : 'connectivity:disconnected',
        );

    return Rx.merge([realTimeStream, pollStream, connectivityStream]);
  }

  bool _shouldProcessEvent(String event) {
    final isForeground = _lifecycleService.isForeground;
    if (!isForeground) {
      _logger.info('Skipping status check (app in background): $event');
    }
    return isForeground;
  }

  Future<AppStatus> _processTriggerEvent(String source) async {
    _logger.info('Refresh triggered by: $source');

    if (source == 'connectivity:disconnected') {
      return const AppStatus.noInternet();
    }

    return await checkStatus(source: source);
  }

  @override
  Future<AppStatus> checkStatus({String source = 'default'}) async {
    _logger.info('Checking app status... ($source)');

    if (!await _connectivityService.hasInternetConnection) {
      _logger.info('No Internet Connection detected during checkStatus');
      return const AppStatus.noInternet();
    }

    try {
      return await _fetchAndValidateRemoteConfig(source);
    } catch (e) {
      _logger.warning('Error checking status, falling back to cache: $e');
      return await _checkCachedStatus();
    }
  }

  Future<AppStatus> _fetchAndValidateRemoteConfig(String source) async {
    final bool activated;
    activated = await _configService.fetchAndActivate();
    _logger.info('Remote Config activated ($source): $activated');

    final minVersion = _configService.minAppVersion.trim();
    final appStoreLink = _configService.appStoreLink.trim();
    final playStoreLink = _configService.playStoreLink.trim();

    _logger.info('Fetched minVersion: "$minVersion"');

    if (_configService.maintenanceMode) {
      _logger.info('Maintenance Mode is ACTIVE');
      return const AppStatus.maintenance();
    }
    await _localDataSource.cacheMinAppVersion(minVersion);
    await _localDataSource.cacheAppStoreLink(appStoreLink);
    await _localDataSource.cachePlayStoreLink(playStoreLink);

    final status = await _determineStatus(
      minVersion,
      appStoreLink,
      playStoreLink,
    );
    _logger.info('Determined status: $status');
    return status;
  }

  Future<AppStatus> _determineStatus(
    String minVersion,
    String appStoreLink,
    String playStoreLink,
  ) async {
    if (minVersion.isEmpty) return const AppStatus.normal();

    final currentVersion = await _appInfoService.getAppVersion();

    _logger.info('Comparing Current: $currentVersion with Min: $minVersion');

    if (_isUpdateRequired(currentVersion, minVersion)) {
      final storeUrl = Platform.isIOS ? appStoreLink : playStoreLink;
      return AppStatus.forceUpgrade(minVersion: minVersion, storeUrl: storeUrl);
    }

    return const AppStatus.normal();
  }

  bool _isUpdateRequired(String currentVersion, String minVersion) {
    try {
      final currentParts = currentVersion.split('.').map(int.parse).toList();
      final minParts = minVersion.split('.').map(int.parse).toList();

      _logger.info('Parsed parts - Current: $currentParts, Min: $minParts');

      for (int i = 0; i < 3; i++) {
        final current = i < currentParts.length ? currentParts[i] : 0;
        final min = i < minParts.length ? minParts[i] : 0;

        if (min > current) return true;
        if (min < current) return false;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<AppStatus> _checkCachedStatus() async {
    try {
      final cachedMinVersion = _localDataSource.getCachedMinAppVersion();
      final cachedAppStoreLink = _localDataSource.getCachedAppStoreLink();
      final cachedPlayStoreLink = _localDataSource.getCachedPlayStoreLink();

      if (cachedMinVersion != null && cachedMinVersion.isNotEmpty) {
        _logger.info(
          'Fast Path: Checking cached minVersion: "$cachedMinVersion"',
        );
        return _determineStatus(
          cachedMinVersion,
          cachedAppStoreLink ?? '',
          cachedPlayStoreLink ?? '',
        );
      }
    } catch (e) {
      _logger.warning('Fast Path: Error checking cache: $e');
    }
    return const AppStatus.normal();
  }
}
