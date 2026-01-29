import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/notifications/data/datasources/fcm_remote_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

final _logger = BizzieLogger('NotificationRepositoryImpl');

@LazySingleton(as: INotificationRepository)
class NotificationRepositoryImpl implements INotificationRepository {
  final FcmRemoteDataSource _fcmRemoteDataSource;

  NotificationRepositoryImpl(this._fcmRemoteDataSource);

  @override
  Future<Either<Failure, void>> requestPermission() async {
    _logger.info('Requesting notification permissions');
    try {
      await _fcmRemoteDataSource.requestPermission();
      _logger.info('Notification permission request completed');
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Failed to request notification permissions', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getFcmToken() async {
    _logger.info('Retrieving FCM token');
    try {
      final token = await _fcmRemoteDataSource.getToken();
      if (token != null) {
        _logger.info('FCM token retrieved successfully');
      } else {
        _logger.warning('FCM token is null');
      }
      return Right(token);
    } catch (e, s) {
      _logger.severe('Failed to get FCM token', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Stream<NotificationMessage> get onMessage {
    return _fcmRemoteDataSource.onMessage.map((remoteMessage) {
      final notification = remoteMessage.notification;
      _logger.info(
        'Incoming notification: ${notification?.title ?? 'No Title'} - ${notification?.body ?? 'No Body'}',
      );
      _logger.info('Notification Data: ${remoteMessage.data}');

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
    _logger.info('Subscribing to topic: $topic');
    try {
      await _fcmRemoteDataSource.subscribeToTopic(topic);
      _logger.info('Successfully subscribed to topic: $topic');
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Failed to subscribe to topic: $topic', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unsubscribeFromTopic(String topic) async {
    _logger.info('Unsubscribing from topic: $topic');
    try {
      await _fcmRemoteDataSource.unsubscribeFromTopic(topic);
      _logger.info('Successfully unsubscribed from topic: $topic');
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Failed to unsubscribe from topic: $topic', e, s);
      return Left(Failure.server(e.toString()));
    }
  }
}
