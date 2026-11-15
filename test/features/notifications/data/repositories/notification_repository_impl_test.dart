import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/data/datasources/fcm_remote_datasource.dart';
import 'package:bizzie/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFcmRemoteDataSource extends Mock implements FcmRemoteDataSource {}

void main() {
  late NotificationRepositoryImpl repository;
  late MockFcmRemoteDataSource mockFcmDataSource;

  setUp(() {
    mockFcmDataSource = MockFcmRemoteDataSource();
    repository = NotificationRepositoryImpl(mockFcmDataSource);
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
      final result = await repository.requestPermission();

      // assert
      expect(result, const Right(null));
      verify(() => mockFcmDataSource.requestPermission()).called(1);
    });

    test(
      'requestPermission_remoteDataSourceThrows_returnsServerFailure',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.requestPermission(),
        ).thenThrow(Exception('Error'));

        // act
        final result = await repository.requestPermission();

        // assert
        expect(result, Left(Failure.server('Exception: Error')));
        verify(() => mockFcmDataSource.requestPermission()).called(1);
      },
    );
  });

  group('isSystemAuthorized', () {
    NotificationSettings settingsWith(AuthorizationStatus status) =>
        NotificationSettings(
          authorizationStatus: status,
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
        );

    for (final (status, expected) in [
      (AuthorizationStatus.authorized, true),
      (AuthorizationStatus.provisional, true),
      (AuthorizationStatus.denied, false),
      (AuthorizationStatus.notDetermined, false),
    ]) {
      test('isSystemAuthorized_${status.name}_returnsRight$expected', () async {
        // arrange
        when(
          () => mockFcmDataSource.getNotificationSettings(),
        ).thenAnswer((_) async => settingsWith(status));

        // act
        final result = await repository.isSystemAuthorized();

        // assert
        expect(result, Right<Failure, bool>(expected));
        verify(() => mockFcmDataSource.getNotificationSettings()).called(1);
      });
    }

    test(
      'isSystemAuthorized_remoteDataSourceThrows_returnsPermissionFailure',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.getNotificationSettings(),
        ).thenThrow(Exception('Error'));

        // act
        final result = await repository.isSystemAuthorized();

        // assert
        expect(
          result,
          const Left<Failure, bool>(Failure.permission('Exception: Error')),
        );
      },
    );
  });

  group('getFcmToken', () {
    test('getFcmToken_called_returnsTokenFromRemoteDataSource', () async {
      // arrange
      when(() => mockFcmDataSource.getToken()).thenAnswer((_) async => tToken);

      // act
      final result = await repository.getFcmToken();

      // assert
      expect(result, const Right(tToken));
      verify(() => mockFcmDataSource.getToken()).called(1);
    });

    test('getFcmToken_remoteDataSourceThrows_returnsServerFailure', () async {
      // arrange
      when(() => mockFcmDataSource.getToken()).thenThrow(Exception('Error'));

      // act
      final result = await repository.getFcmToken();

      // assert
      expect(result, Left(Failure.server('Exception: Error')));
      verify(() => mockFcmDataSource.getToken()).called(1);
    });
  });

  group('onMessage', () {
    test('onMessage_notificationDataPresent_emitsMessageOnly', () async {
      // arrange
      when(
        () => mockFcmDataSource.onMessage,
      ).thenAnswer((_) => Stream.value(tRemoteMessage));

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

      // NOTE: Side effect verification removed as logic was moved to Service.
    });

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
  group('subscribeToSectorTopic', () {
    test(
      'subscribeToSectorTopic_validSector_subscribesSanitizedTopic',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.subscribeToTopic(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.subscribeToSectorTopic(
          'Information Technology',
        );

        // assert
        expect(result, const Right(null));
        verify(
          () => mockFcmDataSource.subscribeToTopic('information_technology'),
        ).called(1);
      },
    );

    test(
      'subscribeToSectorTopic_emptyAfterSanitizing_skipsAndReturnsRight',
      () async {
        // act
        final result = await repository.subscribeToSectorTopic(' & ');

        // assert
        expect(result, const Right(null));
        verifyNever(() => mockFcmDataSource.subscribeToTopic(any()));
      },
    );

    test(
      'subscribeToSectorTopic_remoteDataSourceThrows_returnsServerFailure',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.subscribeToTopic(any()),
        ).thenThrow(Exception('Error'));

        // act
        final result = await repository.subscribeToSectorTopic('Energy');

        // assert
        expect(result, const Left(Failure.server('Exception: Error')));
      },
    );
  });

  group('subscribeToTickerTopic', () {
    test(
      'subscribeToTickerTopic_validTicker_subscribesSanitizedTopic',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.subscribeToTopic(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.subscribeToTickerTopic('brk.b');

        // assert
        expect(result, const Right(null));
        verify(() => mockFcmDataSource.subscribeToTopic('BRKB')).called(1);
      },
    );

    test('subscribeToTickerTopic_emptyTicker_skipsAndReturnsRight', () async {
      // act
      final result = await repository.subscribeToTickerTopic('');

      // assert
      expect(result, const Right(null));
      verifyNever(() => mockFcmDataSource.subscribeToTopic(any()));
    });

    test(
      'subscribeToTickerTopic_remoteDataSourceThrows_returnsServerFailure',
      () async {
        // arrange
        when(
          () => mockFcmDataSource.subscribeToTopic(any()),
        ).thenThrow(Exception('Error'));

        // act
        final result = await repository.subscribeToTickerTopic('AAPL');

        // assert
        expect(result, const Left(Failure.server('Exception: Error')));
      },
    );
  });
}
