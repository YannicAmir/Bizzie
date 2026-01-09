import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/data/datasources/fcm_remote_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepositoryImpl implements INotificationRepository {
  final FcmRemoteDataSource _fcmRemoteDataSource;

  NotificationRepositoryImpl(this._fcmRemoteDataSource);

  @override
  Future<Either<Failure, void>> requestPermission() async {
    try {
      await _fcmRemoteDataSource.requestPermission();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getFcmToken() async {
    try {
      final token = await _fcmRemoteDataSource.getToken();
      return Right(token);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<NotificationMessage> get onMessage {
    return _fcmRemoteDataSource.onMessage.map((remoteMessage) {
      final notification = remoteMessage.notification;

      return NotificationMessage(
        title: notification?.title ?? 'No Title',
        body: notification?.body ?? 'No Body',
        data: remoteMessage.data,
        sentTime: remoteMessage.sentTime,
      );
    });
  }

  @override
  Future<Either<Failure, void>> subscribeToTopic(String topic) async {
    try {
      await _fcmRemoteDataSource.subscribeToTopic(topic);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unsubscribeFromTopic(String topic) async {
    try {
      await _fcmRemoteDataSource.unsubscribeFromTopic(topic);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
