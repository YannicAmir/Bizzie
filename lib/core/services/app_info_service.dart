import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

final _logger = BizzieLogger('AppInfoService');

abstract class IAppInfoService {
  Future<String> getAppVersion();
}

@LazySingleton(as: IAppInfoService)
class AppInfoServiceImpl implements IAppInfoService {
  @override
  Future<String> getAppVersion() async {
    try {
      _logger.info('Getting app version');
      final packageInfo = await PackageInfo.fromPlatform();
      _logger.info(
        'Successfully retrieved app version: ${packageInfo.version}',
      );
      return packageInfo.version;
    } catch (e, s) {
      _logger.severe('Failed to get app version', e, s);
      rethrow;
    }
  }
}
