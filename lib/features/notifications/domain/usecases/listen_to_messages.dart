import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class ListenToMessages {
  final INotificationRepository _repository;

  ListenToMessages(this._repository);

  Stream<NotificationMessage> call() => _repository.onMessage;
}
