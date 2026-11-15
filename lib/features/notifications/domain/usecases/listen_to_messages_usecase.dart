import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListenToMessagesUseCase
    implements StreamUseCase<NotificationMessage, NoParams> {
  final INotificationRepository _repository;

  ListenToMessagesUseCase(this._repository);

  @override
  Stream<NotificationMessage> call(NoParams params) => _repository.onMessage;
}
