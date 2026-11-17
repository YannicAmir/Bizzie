import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/setup_notification_interactions_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationService extends Mock implements INotificationService {}

void main() {
  late SetupNotificationInteractionsUseCase usecase;
  late MockNotificationService mockNotificationService;

  setUp(() {
    mockNotificationService = MockNotificationService();
    usecase = SetupNotificationInteractionsUseCase(mockNotificationService);
  });

  test('setupNotificationInteractions_called_setsUpInteractions', () async {
    // arrange
    when(
      () => mockNotificationService.setupInteractions(),
    ).thenAnswer((_) async {});

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right<dynamic, void>(null));
    verify(() => mockNotificationService.setupInteractions()).called(1);
    verifyNoMoreInteractions(mockNotificationService);
  });
}
