import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class RequestNotificationPermission {
  final INotificationRepository _repository;

  RequestNotificationPermission(this._repository);

  Future<Either<Failure, void>> call() => _repository.requestPermission();
}
