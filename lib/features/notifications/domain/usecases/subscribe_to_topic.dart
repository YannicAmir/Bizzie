import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class SubscribeToTopic {
  final INotificationRepository _repository;

  SubscribeToTopic(this._repository);

  Future<Either<Failure, void>> call(String topic) =>
      _repository.subscribeToTopic(topic);
}
