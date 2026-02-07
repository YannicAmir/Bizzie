import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_permission_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OpenAppSettingsUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final IPermissionService _permissionService;

  OpenAppSettingsUseCase(this._permissionService);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final success = await _permissionService.openAppSettings();
    if (success) {
      return const Right(null);
    } else {
      return const Left(Failure.permission('Failed to open app settings'));
    }
  }
}
