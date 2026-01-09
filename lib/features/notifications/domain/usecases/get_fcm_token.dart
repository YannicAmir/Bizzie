import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class GetFcmToken {
  final INotificationRepository _repository;

  GetFcmToken(this._repository);

  Future<Either<Failure, String?>> call() => _repository.getFcmToken();
}
