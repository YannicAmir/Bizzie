import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFcmTokenUseCase
    implements UseCase<Either<Failure, String?>, NoParams> {
  final INotificationRepository _repository;

  GetFcmTokenUseCase(this._repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) =>
      _repository.getFcmToken();
}
