import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late ListenToMessages usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = ListenToMessages(mockRepository);
  });

  final tNotificationMessage = NotificationMessage(
    title: 'Test Title',
    body: 'Test Body',
    data: const {},
    sentTime: DateTime(2023, 1, 1),
  );

  test('listenToMessages_called_returnsNotificationMessageStream', () {
    // arrange
    when(
      () => mockRepository.onMessage,
    ).thenAnswer((_) => Stream.value(tNotificationMessage));

    // act
    final result = usecase();

    // assert
    expect(result, emits(tNotificationMessage));
    verify(() => mockRepository.onMessage).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('listenToMessages_repositoryEmitsError_emitsError', () {
    // arrange
    when(
      () => mockRepository.onMessage,
    ).thenAnswer((_) => Stream.error(Exception('Error')));

    // act
    final result = usecase();

    // assert
    expect(result, emitsError(isA<Exception>()));
    verify(() => mockRepository.onMessage).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
