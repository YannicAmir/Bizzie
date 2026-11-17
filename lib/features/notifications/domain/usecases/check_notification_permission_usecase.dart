import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckNotificationPermissionUseCase
    implements UseCase<Either<Failure, bool>, NoParams> {
  final INotificationRepository _repository;

  CheckNotificationPermissionUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      _repository.isSystemAuthorized();
}
