import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_permission_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OpenAppSettingsUseCase');

@lazySingleton
class OpenAppSettingsUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final IPermissionService _permissionService;

  OpenAppSettingsUseCase(this._permissionService);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    _logger.info(
      'Executing OpenAppSettingsUseCase: Requesting to open OS settings',
    );

    return _launchAppSettings();
  }

  Future<Either<Failure, void>> _launchAppSettings() async {
    try {
      final success = await _permissionService.openAppSettings();

      if (success) {
        _logger.info('Successfully opened app settings');
        return const Right(null);
      } else {
        _logger.warning(
          'Permission service reported failure while opening settings',
        );
        return const Left(Failure.permission('Failed to open app settings'));
      }
    } catch (e) {
      _logger.severe('Unexpected error while opening app settings', e);
      return const Left(
        Failure.permission(
          'An unexpected error occurred while accessing settings',
        ),
      );
    }
  }
}
