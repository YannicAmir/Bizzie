import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ClearCachedTokenUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final INotificationService _notificationService;

  ClearCachedTokenUseCase(this._notificationService);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    await _notificationService.clearCachedToken();
    return const Right(null);
  }
}
