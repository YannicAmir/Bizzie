import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

abstract class INotificationRepository {
  Future<Either<Failure, void>> requestPermission();
  Future<Either<Failure, String?>> getFcmToken();
  Stream<NotificationMessage> get onMessage;
  Future<Either<Failure, void>> subscribeToTopic(String topic);
  Future<Either<Failure, void>> unsubscribeFromTopic(String topic);
}
