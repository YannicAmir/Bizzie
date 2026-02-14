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
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
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

void main() {
  late NotificationBloc bloc;
  late MockRequestNotificationPermission mockRequestPermission;
  late MockGetFcmToken mockGetFcmToken;
  late MockListenToMessages mockListenToMessages;
  late MockSubscribeToTopic mockSubscribeToTopic;
  late MockUnsubscribeFromTopic mockUnsubscribeFromTopic;
  late MockClearCachedToken mockClearCachedToken;

  setUpAll(() {
    registerFallbackValue(NotificationEvent.setupRequested());
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockRequestPermission = MockRequestNotificationPermission();
    mockGetFcmToken = MockGetFcmToken();
    mockListenToMessages = MockListenToMessages();
    mockSubscribeToTopic = MockSubscribeToTopic();
    mockUnsubscribeFromTopic = MockUnsubscribeFromTopic();
    mockClearCachedToken = MockClearCachedToken();
    bloc = NotificationBloc(
      mockRequestPermission,
      mockGetFcmToken,
      mockListenToMessages,
      mockSubscribeToTopic,
      mockUnsubscribeFromTopic,
      mockClearCachedToken,
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
      expect(bloc.state, const NotificationState.initial());
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
          const NotificationState.loading(),
          const NotificationState.success(tToken),
          NotificationState.messageReceivedState(tMessage),
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
          const NotificationState.loading(),
          const NotificationState.failure('Permission Error'),
        ],
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
          const NotificationState.loading(),
          const NotificationState.failure('Token Error'),
        ],
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
        verify: (_) {
          // assert
          verify(() => mockSubscribeToTopic('topic')).called(1);
        },
        expect: () => [
          // assert
          const NotificationState.failure(
            'Failed to subscribe: Subscribe Error',
          ),
        ],
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
        verify: (_) {
          // assert
          verify(() => mockUnsubscribeFromTopic('topic')).called(1);
        },
        expect: () => [
          // assert
          const NotificationState.failure(
            'Failed to unsubscribe: Unsubscribe Error',
          ),
        ],
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
          const NotificationState.initial(),
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
          NotificationState.messageReceivedState(tMessage),
        ],
      );
    });
  });
}
