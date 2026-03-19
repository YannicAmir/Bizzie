import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/clear_cached_token.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:bizzie/features/notifications/domain/usecases/subscribe_to_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/unsubscribe_from_topic.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/notifications/domain/usecases/parse_notification_payload.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRequestNotificationPermission extends Mock
    implements RequestNotificationPermission {}

class MockGetFcmToken extends Mock implements GetFcmToken {}

class MockListenToMessages extends Mock implements ListenToMessages {}

class MockSubscribeToTopic extends Mock implements SubscribeToTopic {}

class MockUnsubscribeFromTopic extends Mock implements UnsubscribeFromTopic {}

class MockClearCachedToken extends Mock implements ClearCachedToken {}

class MockNotificationTracker extends Mock implements NotificationTracker {}

class MockParseNotificationPayload extends Mock
    implements ParseNotificationPayload {}

class MockINotificationService extends Mock implements INotificationService {}

void main() {
  late NotificationBloc bloc;
  late MockRequestNotificationPermission mockRequestPermission;
  late MockGetFcmToken mockGetFcmToken;
  late MockListenToMessages mockListenToMessages;
  late MockSubscribeToTopic mockSubscribeToTopic;
  late MockUnsubscribeFromTopic mockUnsubscribeFromTopic;
  late MockClearCachedToken mockClearCachedToken;
  late MockNotificationTracker mockTracker;
  late MockParseNotificationPayload mockParseNotificationPayload;
  late MockINotificationService mockNotificationService;

  setUpAll(() {
    registerFallbackValue(NotificationEvent.setupRequested());
    registerFallbackValue(NoParams());
    registerFallbackValue(NotificationErrorType.unknown);
  });

  setUp(() {
    mockRequestPermission = MockRequestNotificationPermission();
    mockGetFcmToken = MockGetFcmToken();
    mockListenToMessages = MockListenToMessages();
    mockSubscribeToTopic = MockSubscribeToTopic();
    mockUnsubscribeFromTopic = MockUnsubscribeFromTopic();
    mockClearCachedToken = MockClearCachedToken();
    mockTracker = MockNotificationTracker();
    mockParseNotificationPayload = MockParseNotificationPayload();
    mockNotificationService = MockINotificationService();

    when(
      () => mockNotificationService.payloadStream,
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => mockNotificationService.setupInteractions(),
    ).thenAnswer((_) async {});

    when(
      () => mockTracker.logPermissionResult(granted: any(named: 'granted')),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.setUserNotificationsEnabled(any()),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logTopicSubscribed(topic: any(named: 'topic')),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logTopicUnsubscribed(topic: any(named: 'topic')),
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
      mockSubscribeToTopic,
      mockUnsubscribeFromTopic,
      mockClearCachedToken,
      mockTracker,
      mockParseNotificationPayload,
      mockNotificationService,
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

    group('setupRequested', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_emitsLoadingAndSuccess',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetFcmToken(),
          ).thenAnswer((_) async => const Right(tToken));
          when(
            () => mockListenToMessages(),
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
          verify(() => mockRequestPermission()).called(1);
          verify(() => mockGetFcmToken()).called(1);
          verify(() => mockListenToMessages()).called(1);
        },
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_setupRequested_permissionFailure_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(
            () => mockRequestPermission(),
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
            () => mockRequestPermission(),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetFcmToken(),
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

    group('subscribeToTopicRequested', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_subscribeToTopicRequested_success_emitsNothingButCallsUseCase',
        build: () {
          // arrange
          when(
            () => mockSubscribeToTopic(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(
          const NotificationEvent.subscribeToTopicRequested('topic'),
        ),
        verify: (_) {
          // assert
          verify(() => mockSubscribeToTopic('topic')).called(1);
        },
        expect: () => [],
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_subscribeToTopicRequested_failure_emitsFailure',
        build: () {
          // arrange
          when(
            () => mockSubscribeToTopic(any()),
          ).thenAnswer((_) async => Left(Failure.server('Subscribe Error')));
          return bloc;
        },
        act: (bloc) => bloc.add(
          const NotificationEvent.subscribeToTopicRequested('topic'),
        ),
        expect: () => [
          const NotificationState(
            status: NotificationStatus.failure('Subscribe Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verify(
            () => mockTracker.logError(
              type: NotificationErrorType.subscriptionFailure,
              message: 'Subscribe Error',
            ),
          ).called(1);
        },
      );
    });

    group('unsubscribeFromTopicRequested', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_unsubscribeFromTopicRequested_success_emitsNothingButCallsUseCase',
        build: () {
          // arrange
          when(
            () => mockUnsubscribeFromTopic(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(
          const NotificationEvent.unsubscribeFromTopicRequested('topic'),
        ),
        verify: (_) {
          // assert
          verify(() => mockUnsubscribeFromTopic('topic')).called(1);
        },
        expect: () => [],
      );

      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_unsubscribeFromTopicRequested_failure_emitsFailure',
        build: () {
          // arrange
          when(
            () => mockUnsubscribeFromTopic(any()),
          ).thenAnswer((_) async => Left(Failure.server('Unsubscribe Error')));
          return bloc;
        },
        act: (bloc) => bloc.add(
          const NotificationEvent.unsubscribeFromTopicRequested('topic'),
        ),
        expect: () => [
          const NotificationState(
            status: NotificationStatus.failure('Unsubscribe Error'),
            isAppReady: false,
          ),
        ],
        verify: (_) {
          verify(
            () => mockTracker.logError(
              type: NotificationErrorType.unsubscriptionFailure,
              message: 'Unsubscribe Error',
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

    group('messageReceived', () {
      blocTest<NotificationBloc, NotificationState>(
        'notificationBloc_messageReceived_emitsMessageReceivedState',
        build: () => bloc,
        act: (bloc) => bloc.add(NotificationEvent.messageReceived(tMessage)),
        expect: () => [
          // assert
          NotificationState(
            status: NotificationStatus.messageReceived(tMessage),
            isAppReady: false,
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
