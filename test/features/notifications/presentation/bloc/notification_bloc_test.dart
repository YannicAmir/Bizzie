import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
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

void main() {
  late NotificationBloc bloc;
  late MockRequestNotificationPermission mockRequestPermission;
  late MockGetFcmToken mockGetFcmToken;
  late MockListenToMessages mockListenToMessages;
  late MockSubscribeToTopic mockSubscribeToTopic;
  late MockUnsubscribeFromTopic mockUnsubscribeFromTopic;

  setUp(() {
    mockRequestPermission = MockRequestNotificationPermission();
    mockGetFcmToken = MockGetFcmToken();
    mockListenToMessages = MockListenToMessages();
    mockSubscribeToTopic = MockSubscribeToTopic();
    mockUnsubscribeFromTopic = MockUnsubscribeFromTopic();
    bloc = NotificationBloc(
      mockRequestPermission,
      mockGetFcmToken,
      mockListenToMessages,
      mockSubscribeToTopic,
      mockUnsubscribeFromTopic,
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
    test('initialState_isInitial', () {
      expect(bloc.state, const NotificationState.initial());
    });

    blocTest<NotificationBloc, NotificationState>(
      'setupRequested_success_emitsLoadingAndSuccess',
      build: () {
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
      'setupRequested_permissionFailure_emitsLoadingAndFailure',
      build: () {
        when(
          () => mockRequestPermission(),
        ).thenAnswer((_) async => Left(Failure.server('Permission Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
      expect: () => [
        const NotificationState.loading(),
        const NotificationState.failure('Permission Error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'setupRequested_tokenFailure_emitsLoadingAndFailure',
      build: () {
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
        const NotificationState.loading(),
        const NotificationState.failure('Token Error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'subscribeToTopicRequested_added_callsSubscribeToTopic',
      build: () {
        when(
          () => mockSubscribeToTopic(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const NotificationEvent.subscribeToTopicRequested('topic')),
      verify: (_) {
        verify(() => mockSubscribeToTopic('topic')).called(1);
      },
      expect: () => [],
    );

    blocTest<NotificationBloc, NotificationState>(
      'subscribeToTopicRequested_failure_emitsFailure',
      build: () {
        when(
          () => mockSubscribeToTopic(any()),
        ).thenAnswer((_) async => Left(Failure.server('Subscribe Error')));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const NotificationEvent.subscribeToTopicRequested('topic')),
      verify: (_) {
        verify(() => mockSubscribeToTopic('topic')).called(1);
      },
      expect: () => [
        const NotificationState.failure('Failed to subscribe: Subscribe Error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'unsubscribeFromTopicRequested_added_callsUnsubscribeFromTopic',
      build: () {
        when(
          () => mockUnsubscribeFromTopic(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const NotificationEvent.unsubscribeFromTopicRequested('topic'),
      ),
      verify: (_) {
        verify(() => mockUnsubscribeFromTopic('topic')).called(1);
      },
      expect: () => [],
    );

    blocTest<NotificationBloc, NotificationState>(
      'unsubscribeFromTopicRequested_failure_emitsFailure',
      build: () {
        when(
          () => mockUnsubscribeFromTopic(any()),
        ).thenAnswer((_) async => Left(Failure.server('Unsubscribe Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const NotificationEvent.unsubscribeFromTopicRequested('topic'),
      ),
      verify: (_) {
        verify(() => mockUnsubscribeFromTopic('topic')).called(1);
      },
      expect: () => [
        const NotificationState.failure(
          'Failed to unsubscribe: Unsubscribe Error',
        ),
      ],
    );
  });
}
