import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequestNotificationPermissionUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final INotificationRepository _repository;

  RequestNotificationPermissionUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      _repository.requestPermission();
}
