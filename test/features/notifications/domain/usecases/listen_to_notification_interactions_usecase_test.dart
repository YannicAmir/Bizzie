import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_notification_interactions_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationService extends Mock implements INotificationService {}

void main() {
  late ListenToNotificationInteractionsUseCase usecase;
  late MockNotificationService mockNotificationService;

  setUp(() {
    mockNotificationService = MockNotificationService();
    usecase = ListenToNotificationInteractionsUseCase(mockNotificationService);
  });

  final tPayload = {'type': 'weekly_summary'};

  test('listenToNotificationInteractions_called_returnsPayloadStream', () {
    // arrange
    when(
      () => mockNotificationService.payloadStream,
    ).thenAnswer((_) => Stream.value(tPayload));

    // act
    final result = usecase(NoParams());

    // assert
    expect(result, emits(tPayload));
    verify(() => mockNotificationService.payloadStream).called(1);
    verifyNoMoreInteractions(mockNotificationService);
  });
}
