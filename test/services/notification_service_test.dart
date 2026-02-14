import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/models/notification_route.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/services/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockINotificationRepository extends Mock
    implements INotificationRepository {}

class MockLocalNotificationDataSource extends Mock
    implements LocalNotificationDataSource {}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockILocalStorageService extends Mock implements ILocalStorageService {}

class MockIUserRepository extends Mock implements IUserRepository {}

class MockNotificationSettings extends Mock implements NotificationSettings {}

class MockRemoteMessage extends Mock implements RemoteMessage {}

void main() {
  late NotificationService service;
  late MockINotificationRepository mockRepository;
  late MockLocalNotificationDataSource mockLocalDataSource;
  late MockDeviceInfoPlugin mockDeviceInfo;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockILocalStorageService mockLocalStorage;
  late MockIUserRepository mockUserRepository;

  const tToken = 'token_123';
  const tDeviceId = 'device_456';

  setUpAll(() {
    registerFallbackValue(const NotificationRoute(''));
  });

  setUp(() {
    mockRepository = MockINotificationRepository();
    mockLocalDataSource = MockLocalNotificationDataSource();
    mockDeviceInfo = MockDeviceInfoPlugin();
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockLocalStorage = MockILocalStorageService();
    mockUserRepository = MockIUserRepository();

    when(
      () => mockRepository.onMessage,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockFirebaseMessaging.onTokenRefresh,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockFirebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: any(named: 'alert'),
        badge: any(named: 'badge'),
        sound: any(named: 'sound'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockLocalDataSource.init(
        onNotificationTap: any(named: 'onNotificationTap'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockRepository.getFcmToken(),
    ).thenAnswer((_) async => const Right(tToken));
    when(() => mockLocalStorage.getString(any())).thenReturn(tToken);
    when(() => mockDeviceInfo.iosInfo).thenAnswer(
      (_) async => IosDeviceInfo.fromMap({'identifierForVendor': tDeviceId}),
    );
    when(
      () => mockDeviceInfo.androidInfo,
    ).thenAnswer((_) async => AndroidDeviceInfo.fromMap({'id': tDeviceId}));

    service = NotificationService(
      mockRepository,
      mockLocalDataSource,
      mockDeviceInfo,
      mockFirebaseMessaging,
      mockLocalStorage,
      mockUserRepository,
    );
  });

  group('initialize', () {
    test(
      'notificationService_initialize_setsUpHandlersAndSyncsToken',
      () async {
        // act
        await service.initialize();

        // assert
        verify(
          () => mockLocalDataSource.init(
            onNotificationTap: any(named: 'onNotificationTap'),
          ),
        ).called(1);
        verify(
          () => mockFirebaseMessaging
              .setForegroundNotificationPresentationOptions(
                alert: false,
                badge: true,
                sound: true,
              ),
        ).called(1);
      },
    );

    test(
      'notificationService_initialize_triggersLocalNotificationOnForegroundMessage',
      () async {
        // arrange
        final controller = StreamController<NotificationMessage>();
        when(
          () => mockRepository.onMessage,
        ).thenAnswer((_) => controller.stream);
        when(
          () => mockLocalDataSource.showNotification(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            payload: any(named: 'payload'),
          ),
        ).thenAnswer((_) async {});

        await service.initialize();

        // act
        controller.add(
          const NotificationMessage(
            title: 'T',
            body: 'B',
            data: {'key': 'val'},
            sentTime: null,
          ),
        );
        await Future.delayed(Duration.zero);

        // assert
        verify(
          () => mockLocalDataSource.showNotification(
            id: any(named: 'id'),
            title: 'T',
            body: 'B',
            payload: '{key: val}',
          ),
        ).called(1);

        controller.close();
      },
    );
  });

  group('syncFcmToken', () {
    test(
      'notificationService_syncFcmToken_differentToken_updatesBackendAndCache',
      () async {
        // arrange
        when(() => mockLocalStorage.getString(any())).thenReturn('old_token');
        when(
          () => mockUserRepository.updateFcmToken(any(), any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockLocalStorage.setString(any(), any()),
        ).thenAnswer((_) async {});

        // act
        await service.syncFcmToken();

        // assert
        verify(
          () => mockUserRepository.updateFcmToken(any(), tToken),
        ).called(1);
        verify(
          () => mockLocalStorage.setString('last_synced_fcm_token', tToken),
        ).called(1);
      },
    );

    test(
      'notificationService_syncFcmToken_forced_updatesRegardlessOfCache',
      () async {
        // arrange
        when(() => mockLocalStorage.getString(any())).thenReturn(tToken);
        when(
          () => mockUserRepository.updateFcmToken(any(), any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockLocalStorage.setString(any(), any()),
        ).thenAnswer((_) async {});

        // act
        await service.syncFcmToken(force: true);

        // assert
        verify(
          () => mockUserRepository.updateFcmToken(any(), tToken),
        ).called(1);
      },
    );
  });

  group('isSystemAuthorized', () {
    test(
      'notificationService_isSystemAuthorized_authorized_returnsTrue',
      () async {
        // arrange
        final settings = MockNotificationSettings();
        when(
          () => settings.authorizationStatus,
        ).thenReturn(AuthorizationStatus.authorized);
        when(
          () => mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer((_) async => settings);

        // act
        final result = await service.isSystemAuthorized();

        // assert
        expect(result, isTrue);
      },
    );
  });

  group('Routing', () {
    test(
      'notificationService_getInitialRoute_parsedMessage_returnsRoute',
      () async {
        // arrange
        final message = MockRemoteMessage();
        when(() => message.data).thenReturn({'type': 'subscription_drip'});
        when(
          () => mockFirebaseMessaging.getInitialMessage(),
        ).thenAnswer((_) async => message);

        // act
        final result = await service.getInitialRoute();

        // assert
        expect(result?.path, AppRoutes.discountedPaywall);
      },
    );

    test(
      'notificationService_onNotificationTap_emitsRouteFromPayload',
      () async {
        // arrange
        void Function(String?)? tapHandler;
        when(
          () => mockLocalDataSource.init(
            onNotificationTap: any(named: 'onNotificationTap'),
          ),
        ).thenAnswer((invocation) async {
          tapHandler =
              invocation.namedArguments[#onNotificationTap]
                  as void Function(String?)?;
        });

        await service.initialize();

        // act & assert
        expectLater(
          service.routeStream,
          emits(const NotificationRoute(AppRoutes.reports)),
        );

        tapHandler?.call('earnings_notification');
      },
    );
  });
}
