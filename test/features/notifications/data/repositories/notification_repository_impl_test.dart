import 'package:bizzie/features/notifications/data/datasources/fcm_remote_datasource.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFcmRemoteDataSource extends Mock implements FcmRemoteDataSource {}

class MockLocalNotificationDataSource extends Mock
    implements LocalNotificationDataSource {}

void main() {
  late NotificationRepositoryImpl repository;
  late MockFcmRemoteDataSource mockFcmDataSource;
  late MockLocalNotificationDataSource mockLocalDataSource;

  setUp(() {
    mockFcmDataSource = MockFcmRemoteDataSource();
    mockLocalDataSource = MockLocalNotificationDataSource();
    repository = NotificationRepositoryImpl(
      mockFcmDataSource,
      mockLocalDataSource,
    );
  });

  const tToken = 'test_token';
  const tRemoteMessage = RemoteMessage(
    data: {'key': 'value'},
    notification: RemoteNotification(title: 'Test Title', body: 'Test Body'),
    sentTime: null,
  );

  group('requestPermission', () {
    test('requestPermission_called_delegatesToRemoteDataSource', () async {
      // arrange
      when(() => mockFcmDataSource.requestPermission()).thenAnswer(
        (_) async => const NotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
          alert: AppleNotificationSetting.enabled,
          announcement: AppleNotificationSetting.enabled,
          badge: AppleNotificationSetting.enabled,
          carPlay: AppleNotificationSetting.enabled,
          lockScreen: AppleNotificationSetting.enabled,
          notificationCenter: AppleNotificationSetting.enabled,
          showPreviews: AppleShowPreviewSetting.always,
          timeSensitive: AppleNotificationSetting.enabled,
          sound: AppleNotificationSetting.enabled,
          criticalAlert: AppleNotificationSetting.enabled,
          providesAppNotificationSettings: AppleNotificationSetting.enabled,
        ),
      );

      // act
      await repository.requestPermission();

      // assert
      verify(() => mockFcmDataSource.requestPermission()).called(1);
    });

    test('requestPermission_remoteDataSourceThrows_throwsException', () async {
      // arrange
      when(
        () => mockFcmDataSource.requestPermission(),
      ).thenThrow(Exception('Error'));

      // act
      final call = repository.requestPermission;

      // assert
      expect(call, throwsException);
      verify(() => mockFcmDataSource.requestPermission()).called(1);
    });
  });

  group('getFcmToken', () {
    test('getFcmToken_called_returnsTokenFromRemoteDataSource', () async {
      // arrange
      when(() => mockFcmDataSource.getToken()).thenAnswer((_) async => tToken);

      // act
      final result = await repository.getFcmToken();

      // assert
      expect(result, tToken);
      verify(() => mockFcmDataSource.getToken()).called(1);
    });

    test('getFcmToken_remoteDataSourceThrows_throwsException', () async {
      // arrange
      when(() => mockFcmDataSource.getToken()).thenThrow(Exception('Error'));

      // act
      final call = repository.getFcmToken;

      // assert
      expect(call, throwsException);
      verify(() => mockFcmDataSource.getToken()).called(1);
    });
  });

  group('onMessage', () {
    test(
      'onMessage_notificationDataPresent_emitsMessageAndShowsLocalNotification',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.onMessage,
        ).thenAnswer((_) => Stream.value(tRemoteMessage));
        when(
          () => mockLocalDataSource.showNotification(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            payload: any(named: 'payload'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = repository.onMessage;

        // assert
        await expectLater(
          result,
          emits(
            isA<NotificationMessage>()
                .having((m) => m.title, 'title', 'Test Title')
                .having((m) => m.body, 'body', 'Test Body')
                .having((m) => m.data, 'data', {'key': 'value'}),
          ),
        );

        // assert side effect
        verify(
          () => mockLocalDataSource.showNotification(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            payload: any(named: 'payload'),
          ),
        ).called(1);
      },
    );

    test('onMessage_remoteDataSourceEmitsError_emitsError', () {
      // arrange
      when(
        () => mockFcmDataSource.onMessage,
      ).thenAnswer((_) => Stream.error(Exception('Error')));

      // act
      final result = repository.onMessage;

      // assert
      expect(result, emitsError(isA<Exception>()));
    });
  });
}
