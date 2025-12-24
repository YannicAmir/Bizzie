import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late RequestNotificationPermission usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = RequestNotificationPermission(mockRepository);
  });

  test('requestNotificationPermission_called_delegatesToRepository', () async {
    // arrange
    when(() => mockRepository.requestPermission()).thenAnswer((_) async {});

    // act
    await usecase();

    // assert
    verify(() => mockRepository.requestPermission()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'requestNotificationPermission_repositoryThrows_throwsException',
    () async {
      // arrange
      when(
        () => mockRepository.requestPermission(),
      ).thenThrow(Exception('Error'));

      // act
      final call = usecase.call;

      // assert
      expect(call, throwsException);
      verify(() => mockRepository.requestPermission()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
