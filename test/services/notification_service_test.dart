import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/services/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockINotificationRepository extends Mock
    implements INotificationRepository {}

class MockLocalNotificationDataSource extends Mock
    implements LocalNotificationDataSource {}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

void main() {
  late NotificationService service;
  late MockINotificationRepository mockRepository;
  late MockLocalNotificationDataSource mockLocalDataSource;
  late MockDeviceInfoPlugin mockDeviceInfo;

  setUp(() {
    mockRepository = MockINotificationRepository();
    mockLocalDataSource = MockLocalNotificationDataSource();
    mockDeviceInfo = MockDeviceInfoPlugin();

    // Stub onMessage to prevent null pointer in init()
    when(
      () => mockRepository.onMessage,
    ).thenAnswer((_) => const Stream.empty());

    service = NotificationService(
      mockRepository,
      mockLocalDataSource,
      mockDeviceInfo,
    );
  });

  group('NotificationService', () {
    test('getFcmToken_returnsToken_whenSuccessful', () async {
      when(
        () => mockRepository.getFcmToken(),
      ).thenAnswer((_) async => const Right('token'));

      final result = await service.getFcmToken();

      expect(result, 'token');
      verify(() => mockRepository.getFcmToken()).called(1);
    });

    test('getFcmToken_returnsNull_whenFailure', () async {
      when(
        () => mockRepository.getFcmToken(),
      ).thenAnswer((_) async => const Left(ServerFailure('Error')));

      final result = await service.getFcmToken();

      expect(result, isNull);
    });

    test('subscribeToTopic_callsSubscribe', () async {
      when(
        () => mockRepository.subscribeToTopic(any()),
      ).thenAnswer((_) async => const Right(null));

      await service.subscribeToTopic('test_topic');

      verify(() => mockRepository.subscribeToTopic('test_topic')).called(1);
    });

    test('unsubscribeFromTopic_callsUnsubscribe', () async {
      when(
        () => mockRepository.unsubscribeFromTopic(any()),
      ).thenAnswer((_) async => const Right(null));

      await service.unsubscribeFromTopic('test_topic');

      verify(() => mockRepository.unsubscribeFromTopic('test_topic')).called(1);
    });

    test('onMessage_triggersLocalNotification', () async {
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

      // Re-instantiate service to trigger listener attached to new stream
      service = NotificationService(
        mockRepository,
        mockLocalDataSource,
        mockDeviceInfo,
      );

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
