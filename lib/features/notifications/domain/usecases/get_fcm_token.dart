import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';

@injectable
class GetFcmToken {
  final INotificationRepository _repository;

  GetFcmToken(this._repository);

  Future<String?> call() => _repository.getFcmToken();
}
