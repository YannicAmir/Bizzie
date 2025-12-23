import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class RequestNotificationPermission {
  final INotificationRepository _repository;

  RequestNotificationPermission(this._repository);

  Future<void> call() => _repository.requestPermission();
}
