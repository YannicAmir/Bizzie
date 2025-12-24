import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:bizzie/features/notifications/domain/usecases/subscribe_to_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/unsubscribe_from_topic.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
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
        when(() => mockRequestPermission()).thenAnswer((_) async {});
        when(() => mockGetFcmToken()).thenAnswer((_) async => tToken);
        when(
          () => mockListenToMessages(),
        ).thenAnswer((_) => Stream.value(tMessage));
        return bloc;
      },
      act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
      expect: () => [
        const NotificationState.loading(),
        const NotificationState.success(tToken),
        // Note: The stream listener will emit messageReceived immediately because of Stream.value
        NotificationState.messageReceivedState(tMessage),
      ],
      verify: (_) {
        verify(() => mockRequestPermission()).called(1);
        verify(() => mockGetFcmToken()).called(1);
        verify(() => mockListenToMessages()).called(1);
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'setupRequested_failure_emitsLoadingAndFailure',
      build: () {
        when(() => mockRequestPermission()).thenThrow(Exception('Error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const NotificationEvent.setupRequested()),
      expect: () => [
        const NotificationState.loading(),
        const NotificationState.failure('Exception: Error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'subscribeToTopicRequested_added_callsSubscribeToTopic',
      build: () {
        when(() => mockSubscribeToTopic(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const NotificationEvent.subscribeToTopicRequested('topic')),
      verify: (_) {
        verify(() => mockSubscribeToTopic('topic')).called(1);
      },
      expect: () => [], // No state change on success
    );

    blocTest<NotificationBloc, NotificationState>(
      'subscribeToTopicRequested_failure_emitsFailure',
      build: () {
        when(
          () => mockSubscribeToTopic(any()),
        ).thenThrow(Exception('Subscribe Error'));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const NotificationEvent.subscribeToTopicRequested('topic')),
      verify: (_) {
        verify(() => mockSubscribeToTopic('topic')).called(1);
      },
      expect: () => [
        const NotificationState.failure(
          'Failed to subscribe: Exception: Subscribe Error',
        ),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'unsubscribeFromTopicRequested_added_callsUnsubscribeFromTopic',
      build: () {
        when(() => mockUnsubscribeFromTopic(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(
        const NotificationEvent.unsubscribeFromTopicRequested('topic'),
      ),
      verify: (_) {
        verify(() => mockUnsubscribeFromTopic('topic')).called(1);
      },
      expect: () => [], // No state change on success
    );

    blocTest<NotificationBloc, NotificationState>(
      'unsubscribeFromTopicRequested_failure_emitsFailure',
      build: () {
        when(
          () => mockUnsubscribeFromTopic(any()),
        ).thenThrow(Exception('Unsubscribe Error'));
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
          'Failed to unsubscribe: Exception: Unsubscribe Error',
        ),
      ],
    );
  });
}
