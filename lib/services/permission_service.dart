import 'package:bizzie/core/interfaces/i_permission_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

final _logger = BizzieLogger('PermissionService');

@LazySingleton(as: IPermissionService)
class PermissionServiceImpl implements IPermissionService {
  @override
  Future<bool> openAppSettings() async {
    _logger.info('Opening app settings');
    final result = await ph.openAppSettings();
    if (result) {
      _logger.info('Successfully opened app settings');
    } else {
      _logger.warning('Failed to open app settings');
    }
    return result;
  }
}
