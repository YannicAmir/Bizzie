import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockINotificationRepository extends Mock
    implements INotificationRepository {}

class MockLocalNotificationDataSource extends Mock
    implements LocalNotificationDataSource {}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() {
  late NotificationService service;
  late MockINotificationRepository mockRepository;
  late MockLocalNotificationDataSource mockLocalDataSource;
  late MockDeviceInfoPlugin mockDeviceInfo;
  late MockFirebaseMessaging mockFirebaseMessaging;

  setUp(() {
    mockRepository = MockINotificationRepository();
    mockLocalDataSource = MockLocalNotificationDataSource();
    mockDeviceInfo = MockDeviceInfoPlugin();
    mockFirebaseMessaging = MockFirebaseMessaging();

    // Stub onMessage to prevent null pointer in init()
    when(
      () => mockRepository.onMessage,
    ).thenAnswer((_) => const Stream.empty());

    // Stub FirebaseMessaging methods
    when(
      () => mockFirebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: any(named: 'badge'),
        sound: any(named: 'sound'),
      ),
    ).thenAnswer((_) async {});

    service = NotificationService(
      mockRepository,
      mockLocalDataSource,
      mockDeviceInfo,
      mockFirebaseMessaging,
    );
  });

  group('NotificationService', () {
    test('getFcmToken_success_returnsToken', () async {
      // arrange
      when(
        () => mockRepository.getFcmToken(),
      ).thenAnswer((_) async => const Right('token'));

      // act
      final result = await service.getFcmToken();

      // assert
      expect(result, 'token');
      verify(() => mockRepository.getFcmToken()).called(1);
    });

    test('getFcmToken_failure_returnsNull', () async {
      // arrange
      when(
        () => mockRepository.getFcmToken(),
      ).thenAnswer((_) async => const Left(Failure.server('Error')));

      // act
      final result = await service.getFcmToken();

      // assert
      expect(result, isNull);
    });

    test('subscribeToTopic_validTopic_callsRepository', () async {
      // arrange
      when(
        () => mockRepository.subscribeToTopic(any()),
      ).thenAnswer((_) async => const Right(null));

      // act
      await service.subscribeToTopic('test_topic');

      // assert
      verify(() => mockRepository.subscribeToTopic('test_topic')).called(1);
    });

    test('unsubscribeFromTopic_validTopic_callsRepository', () async {
      // arrange
      when(
        () => mockRepository.unsubscribeFromTopic(any()),
      ).thenAnswer((_) async => const Right(null));

      // act
      await service.unsubscribeFromTopic('test_topic');

      // assert
      verify(() => mockRepository.unsubscribeFromTopic('test_topic')).called(1);
    });

    test('onMessage_receivedMessage_triggersLocalNotification', () async {
      // arrange
      final tMessage = const NotificationMessage(
        title: 'Title',
        body: 'Body',
        data: {},
        sentTime: null,
      );
      final controller = StreamController<NotificationMessage>();
      when(() => mockRepository.onMessage).thenAnswer((_) => controller.stream);
      when(
        () => mockLocalDataSource.showNotification(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          payload: any(named: 'payload'),
        ),
      ).thenAnswer((_) async {});

      when(
        () => mockLocalDataSource.init(
          onNotificationTap: any(named: 'onNotificationTap'),
        ),
      ).thenAnswer((_) async {});

      // Re-instantiate service to trigger listener attached to new stream
      service = NotificationService(
        mockRepository,
        mockLocalDataSource,
        mockDeviceInfo,
        mockFirebaseMessaging,
      );

      await service.initialize();

      // act
      controller.add(tMessage);
      await Future.delayed(Duration.zero); // Wait for stream listener

      // assert
      verify(
        () => mockLocalDataSource.showNotification(
          id: any(named: 'id'),
          title: 'Title',
          body: 'Body',
          payload: any(named: 'payload'),
        ),
      ).called(1);

      await controller.close();
    });
  });
}
