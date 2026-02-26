import 'dart:async';
import 'package:bizzie/core/error/failures.dart';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_app_state.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_trigger_source.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/models/notification_route.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
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

class MockNotificationTracker extends Mock implements NotificationTracker {}

void main() {
  late NotificationService service;
  late MockINotificationRepository mockRepository;
  late MockLocalNotificationDataSource mockLocalDataSource;
  late MockDeviceInfoPlugin mockDeviceInfo;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockILocalStorageService mockLocalStorage;
  late MockIUserRepository mockUserRepository;
  late MockNotificationTracker mockTracker;

  const tToken = 'token_123';
  const tDeviceId = 'device_456';

  setUpAll(() {
    registerFallbackValue(const NotificationRoute(''));
    registerFallbackValue(NotificationTriggerSource.remote);
    registerFallbackValue(NotificationAppState.background);
  });

  setUp(() {
    mockRepository = MockINotificationRepository();
    mockLocalDataSource = MockLocalNotificationDataSource();
    mockDeviceInfo = MockDeviceInfoPlugin();
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockLocalStorage = MockILocalStorageService();
    mockUserRepository = MockIUserRepository();
    mockTracker = MockNotificationTracker();

    when(
      () => mockTracker.logNotificationOpened(
        notificationType: any(named: 'notificationType'),
        triggerSource: any(named: 'triggerSource'),
        appState: any(named: 'appState'),
        route: any(named: 'route'),
        ticker: any(named: 'ticker'),
      ),
    ).thenAnswer((_) async => {});

    when(
      () => mockTracker.logSyncFailure(message: any(named: 'message')),
    ).thenAnswer((_) async => {});

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
      mockTracker,
    );
  });

  group('initialize', () {
    test(
      'notificationService_initialize_setsUpHandlersAndSyncsToken',
      () async {
        // ACT
        await service.initialize();

        // ASSERT
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
        // ARRANGE
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

        // ACT
        controller.add(
          const NotificationMessage(
            title: 'T',
            body: 'B',
            data: {'key': 'val'},
            sentTime: null,
          ),
        );
        await Future.delayed(Duration.zero);

        // ASSERT
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
        // ARRANGE
        when(() => mockLocalStorage.getString(any())).thenReturn('old_token');
        when(
          () => mockUserRepository.updateFcmToken(any(), any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockLocalStorage.setString(any(), any()),
        ).thenAnswer((_) async {});

        // ACT
        await service.syncFcmToken();

        // ASSERT
        verify(
          () => mockLocalStorage.setString('last_synced_fcm_token', tToken),
        ).called(1);
      },
    );

    test('notificationService_syncFcmToken_failure_logsSyncFailure', () async {
      // ARRANGE
      when(() => mockLocalStorage.getString(any())).thenReturn('old_token');
      when(
        () => mockUserRepository.updateFcmToken(any(), any()),
      ).thenAnswer((_) async => Left(Failure.server('Sync Failed')));

      // ACT
      await service.syncFcmToken();

      // ASSERT
      verify(
        () => mockTracker.logSyncFailure(message: 'Sync Failed'),
      ).called(1);
    });

    test(
      'notificationService_syncFcmToken_forced_updatesRegardlessOfCache',
      () async {
        // ARRANGE
        when(() => mockLocalStorage.getString(any())).thenReturn(tToken);
        when(
          () => mockUserRepository.updateFcmToken(any(), any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockLocalStorage.setString(any(), any()),
        ).thenAnswer((_) async {});

        // ACT
        await service.syncFcmToken(force: true);

        // ASSERT
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
        // ARRANGE
        final settings = MockNotificationSettings();
        when(
          () => settings.authorizationStatus,
        ).thenReturn(AuthorizationStatus.authorized);
        when(
          () => mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer((_) async => settings);

        // ACT
        final result = await service.isSystemAuthorized();

        // ASSERT
        expect(result, isTrue);
      },
    );
  });

  group('Routing', () {
    test(
      'notificationService_getInitialRoute_parsedMessage_returnsRouteAndLogsAnalytics',
      () async {
        // ARRANGE
        final message = MockRemoteMessage();
        when(() => message.data).thenReturn({'type': 'subscription_drip'});
        when(
          () => mockFirebaseMessaging.getInitialMessage(),
        ).thenAnswer((_) async => message);

        // ACT
        final result = await service.getInitialRoute();

        // ASSERT
        expect(
          result?.path,
          '${AppRoutes.discountedPaywall}?source=notification',
        );
        verify(
          () => mockTracker.logNotificationOpened(
            notificationType: 'subscription_drip',
            triggerSource: NotificationTriggerSource.remote,
            appState: NotificationAppState.terminated,
            route: result?.path,
            ticker: any(named: 'ticker'),
          ),
        ).called(1);
      },
    );

    test(
      'notificationService_onNotificationTap_emitsRouteFromPayloadAndLogsAnalytics',
      () async {
        // ARRANGE
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

        // ACT & assert
        final expectEmit = expectLater(
          service.routeStream,
          emits(const NotificationRoute(AppRoutes.reports)),
        );

        tapHandler?.call('earnings_notification');
        await expectEmit;

        verify(
          () => mockTracker.logNotificationOpened(
            notificationType: 'earnings_notification',
            triggerSource: NotificationTriggerSource.local,
            appState: NotificationAppState.foreground,
            route: AppRoutes.reports,
            ticker: any(named: 'ticker'),
          ),
        ).called(1);
      },
    );

    test(
      'notificationService_onNotificationTap_withTicker_extractsTickerAndLogsAnalytics',
      () async {
        // ARRANGE
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

        // ACT
        tapHandler?.call('{type: sec_filing, ticker: TSLA}');
        await Future.delayed(Duration.zero);

        // ASSERT
        verify(
          () => mockTracker.logNotificationOpened(
            notificationType: 'sec_filing',
            triggerSource: NotificationTriggerSource.local,
            appState: NotificationAppState.foreground,
            route: AppRoutes.reports,
            ticker: 'TSLA',
          ),
        ).called(1);
      },
    );
  });
}
