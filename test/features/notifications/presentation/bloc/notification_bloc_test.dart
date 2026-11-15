import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/check_notification_permission_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/clear_cached_token_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission_usecase.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/notifications/domain/usecases/parse_notification_payload_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_notification_interactions_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/setup_notification_interactions_usecase.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRequestNotificationPermissionUseCase extends Mock
    implements RequestNotificationPermissionUseCase {}

class MockGetFcmTokenUseCase extends Mock implements GetFcmTokenUseCase {}

class MockListenToMessagesUseCase extends Mock
    implements ListenToMessagesUseCase {}

class MockClearCachedTokenUseCase extends Mock
    implements ClearCachedTokenUseCase {}

class MockNotificationTracker extends Mock implements NotificationTracker {}

class MockParseNotificationPayloadUseCase extends Mock
    implements ParseNotificationPayloadUseCase {}

class MockCheckNotificationPermissionUseCase extends Mock
    implements CheckNotificationPermissionUseCase {}

class MockSetupNotificationInteractionsUseCase extends Mock
    implements SetupNotificationInteractionsUseCase {}

class MockListenToNotificationInteractionsUseCase extends Mock
    implements ListenToNotificationInteractionsUseCase {}

void main() {
  late NotificationBloc bloc;
  late MockRequestNotificationPermissionUseCase mockRequestPermission;
  late MockGetFcmTokenUseCase mockGetFcmToken;
  late MockListenToMessagesUseCase mockListenToMessages;
  late MockClearCachedTokenUseCase mockClearCachedToken;
  late MockNotificationTracker mockTracker;
  late MockParseNotificationPayloadUseCase mockParseNotificationPayload;
  late MockCheckNotificationPermissionUseCase mockCheckNotificationPermission;
  late MockSetupNotificationInteractionsUseCase mockSetupInteractions;
  late MockListenToNotificationInteractionsUseCase mockListenToInteractions;

  setUpAll(() {
    registerFallbackValue(NotificationEvent.setupRequested());
    registerFallbackValue(NoParams());
    registerFallbackValue(NotificationErrorType.unknown);
  });

  setUp(() {
    mockRequestPermission = MockRequestNotificationPermissionUseCase();
    mockGetFcmToken = MockGetFcmTokenUseCase();
    mockListenToMessages = MockListenToMessagesUseCase();
    mockClearCachedToken = MockClearCachedTokenUseCase();
    mockTracker = MockNotificationTracker();
    mockParseNotificationPayload = MockParseNotificationPayloadUseCase();
    mockCheckNotificationPermission = MockCheckNotificationPermissionUseCase();
    mockSetupInteractions = MockSetupNotificationInteractionsUseCase();
    mockListenToInteractions = MockListenToNotificationInteractionsUseCase();

    when(
      () => mockListenToInteractions(any()),
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockSetupInteractions(any()),
    ).thenAnswer((_) async => const Right(null));

    when(
      () => mockTracker.logPermissionResult(granted: any(named: 'granted')),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.setUserNotificationsEnabled(any()),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logMessageReceived(type: any(named: 'type')),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logError(
        type: any(named: 'type'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async => {});

    bloc = NotificationBloc(
      mockRequestPermission,
      mockGetFcmToken,
      mockListenToMessages,
      mockClearCachedToken,
      mockTracker,
      mockParseNotificationPayload,
      mockCheckNotificationPermission,
      mockSetupInteractions,
      mockListenToInteractions,
    );
  });

  const tToken = 'test_token';
  final tMessage = NotificationMessage(
    title: 'Test',
    body: 'Body',
    data: const {},
    sentTime: DateTime(2023),
  );

  group('NotificationBloc', () {
    test('notificationBloc_initialState_isInitial', () {
      expect(
        bloc.state,
        const NotificationState(
          status: NotificationStatus.initial(),
          isAppReady: false,
        ),
      );
    });

    group('syncRequested', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_syncRequested_permissionGranted_syncsTokenWithoutPrompt',
        build: () {
          // arrange
          when(
            () => mockCheckNotificationPermission(any()),
          ).thenAnswer((_) async => const Right(true));
          when(
            () => mockGetFcmToken(any()),
          ).thenAnswer((_) async => const Right(tToken));
          when(
            () => mockListenToMessages(any()),
          ).thenAnswer((_) => const Stream.empty());
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const NotificationEvent.syncRequested()),
        // assert
        expect: () => [
          const NotificationState(
            status: NotificationStatus.success(tToken),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockRequestPermission(any()));
          verify(() => mockGetFcmToken(any())).called(1);
          verify(() => mockSetupInteractions(any())).called(1);
          verify(() => mockListenToMessages(any())).called(1);
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_syncRequested_permissionNotGranted_doesNothingAndNeverPrompts',
        build: () {
          // arrange
          when(
            () => mockCheckNotificationPermission(any()),
          ).thenAnswer((_) async => const Right(false));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const NotificationEvent.syncRequested()),
        // assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRequestPermission(any()));
          verifyNever(() => mockGetFcmToken(any()));
          verifyNever(() => mockSetupInteractions(any()));
          verifyNever(() => mockListenToMessages(any()));
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_syncRequested_permissionGrantedTokenFails_emitsFailureWithoutPrompt',
        build: () {
          // arrange
          when(
            () => mockCheckNotificationPermission(any()),
          ).thenAnswer((_) async => const Right(true));
          when(
            () => mockGetFcmToken(any()),
          ).thenAnswer((_) async => const Left(Failure.server('Token Error')));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const NotificationEvent.syncRequested()),
        // assert
        expect: () => [
          const NotificationState(
            status: NotificationStatus.failure('Token Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockRequestPermission(any()));
          verifyNever(() => mockSetupInteractions(any()));
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_syncRequested_permissionCheckFails_emitsFailure',
        build: () {
          // arrange
          when(() => mockCheckNotificationPermission(any())).thenAnswer(
            (_) async => const Left(Failure.permission('Check Error')),
          );
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const NotificationEvent.syncRequested()),
        // assert
        expect: () => [
          const NotificationState(
            status: NotificationStatus.failure('Check Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockRequestPermission(any()));
          verify(
            () => mockTracker.logError(
              type: NotificationErrorType.permissionException,
              message: 'Check Error',
            ),
          ).called(1);
        },
      );
    });

    group('setupRequested', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_emitsLoadingAndSuccess',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(any()),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetFcmToken(any()),
          ).thenAnswer((_) async => const Right(tToken));
          when(
            () => mockListenToMessages(any()),
          ).thenAnswer((_) => Stream.value(tMessage));
          return bloc;
        },
        act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
        expect: () => [
          // assert
          const NotificationState(
            status: NotificationStatus.loading(),
            isAppReady: false,
          ),
          const NotificationState(
            status: NotificationStatus.success(tToken),
            isAppReady: false,
          ),
          NotificationState(
            status: NotificationStatus.messageReceived(tMessage),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verify(() => mockRequestPermission(any())).called(1);
          verify(() => mockGetFcmToken(any())).called(1);
          verify(() => mockListenToMessages(any())).called(1);
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_permissionFailure_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(any()),
          ).thenAnswer((_) async => Left(Failure.server('Permission Error')));
          return bloc;
        },
        act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
        expect: () => [
          // assert
          const NotificationState(
            status: NotificationStatus.loading(),
            isAppReady: false,
          ),
          const NotificationState(
            status: NotificationStatus.failure('Permission Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verify(
            () => mockTracker.logError(
              type: NotificationErrorType.permissionException,
              message: 'Permission Error',
            ),
          ).called(1);
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_tokenFailure_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(any()),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetFcmToken(any()),
          ).thenAnswer((_) async => Left(Failure.server('Token Error')));
          return bloc;
        },
        act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
        expect: () => [
          // assert
          const NotificationState(
            status: NotificationStatus.loading(),
            isAppReady: false,
          ),
          const NotificationState(
            status: NotificationStatus.failure('Token Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verify(
            () => mockTracker.logError(
              type: NotificationErrorType.tokenSyncFailure,
              message: 'Token Error',
            ),
          ).called(1);
        },
      );
    });

    group('reset', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_reset_success_clearsCacheAndEmitsInitial',
        build: () {
          // arrange
          when(
            () => mockClearCachedToken(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(const NotificationEvent.reset()),
        expect: () => [
          // assert
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          // assert
          verify(() => mockClearCachedToken(any())).called(1);
        },
      );
    });

    group('reset during setup', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_resetDuringSetup_cancelsSetupAndNeverEnablesNotifications',
        build: () {
          // arrange
          when(() => mockRequestPermission(any())).thenAnswer(
            (_) => Future.delayed(
              const Duration(milliseconds: 10),
              () => const Right(null),
            ),
          );
          when(
            () => mockClearCachedToken(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        // act
        act: (bloc) async {
          bloc.add(const NotificationEvent.setupRequested());
          await Future<void>.delayed(Duration.zero);
          bloc.add(const NotificationEvent.reset());
        },
        wait: const Duration(milliseconds: 20),
        // assert
        expect: () => [
          const NotificationState(status: NotificationStatus.loading()),
          const NotificationState(),
        ],
        verify: (_) {
          verifyNever(() => mockGetFcmToken(any()));
          verifyNever(() => mockSetupInteractions(any()));
          verifyNever(() => mockTracker.setUserNotificationsEnabled(true));
        },
      );
    });

    group('interaction stream', () {
      final tPayload = {'type': 'subscription_drip'};
      const tIntent = NotificationIntent.paywall(PaywallSource.notification);

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_interactionStreamEmits_buffersIntent',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(any()),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetFcmToken(any()),
          ).thenAnswer((_) async => const Right(tToken));
          when(
            () => mockListenToMessages(any()),
          ).thenAnswer((_) => const Stream.empty());
          when(
            () => mockListenToInteractions(any()),
          ).thenAnswer((_) => Stream.value(tPayload));
          when(
            () => mockParseNotificationPayload(tPayload),
          ).thenReturn(tIntent);
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
        // assert
        expect: () => [
          const NotificationState(status: NotificationStatus.loading()),
          const NotificationState(status: NotificationStatus.success(tToken)),
          const NotificationState(
            status: NotificationStatus.success(tToken),
            pendingIntent: tIntent,
          ),
        ],
      );
    });

    group('interactionReceived', () {
      final tPayload = {'type': 'subscription_drip'};
      const tIntent = NotificationIntent.paywall(PaywallSource.notification);

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_interactionReceived_notReady_buffersIntent',
        build: () {
          when(
            () => mockParseNotificationPayload(tPayload),
          ).thenReturn(tIntent);
          return bloc;
        },
        act: (bloc) =>
            bloc.add(NotificationEvent.interactionReceived(tPayload)),
        expect: () => [
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: false,
            pendingIntent: tIntent,
          ),
        ],
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_interactionReceived_ready_emitsNavigationRequested',
        build: () {
          when(
            () => mockParseNotificationPayload(tPayload),
          ).thenReturn(tIntent);
          return bloc;
        },
        seed: () => const NotificationState(
          status: NotificationStatus.initial(),
          isAppReady: true,
        ),
        act: (bloc) =>
            bloc.add(NotificationEvent.interactionReceived(tPayload)),
        expect: () => [
          isA<NotificationState>()
              .having(
                (s) => s.status,
                'status',
                isA<NotificationStatusNavigationRequested>().having(
                  (s) => (s).intent,
                  'intent',
                  tIntent,
                ),
              )
              .having((s) => s.isAppReady, 'isAppReady', true),
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: true,
          ),
        ],
      );
    });

    group('appReadyForNavigation', () {
      const tIntent = NotificationIntent.paywall(PaywallSource.notification);

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_appReadyForNavigation_withPendingIntent_processesIt',
        build: () => bloc,
        seed: () => const NotificationState(
          status: NotificationStatus.initial(),
          isAppReady: false,
          pendingIntent: tIntent,
        ),
        act: (bloc) =>
            bloc.add(const NotificationEvent.appReadyForNavigation()),
        expect: () => [
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: true,
            pendingIntent: null,
          ),
          isA<NotificationState>()
              .having(
                (s) => s.status,
                'status',
                isA<NotificationStatusNavigationRequested>().having(
                  (s) => (s).intent,
                  'intent',
                  tIntent,
                ),
              )
              .having((s) => s.isAppReady, 'isAppReady', true),
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: true,
          ),
        ],
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_appReadyForNavigation_withoutPendingIntent_justSetsReady',
        build: () => bloc,
        act: (bloc) =>
            bloc.add(const NotificationEvent.appReadyForNavigation()),
        expect: () => [
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: true,
          ),
        ],
      );
    });
  });
}
