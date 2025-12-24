import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class UnsubscribeFromTopic {
  final INotificationRepository _repository;

  UnsubscribeFromTopic(this._repository);

  Future<void> call(String topic) => _repository.unsubscribeFromTopic(topic);
}
