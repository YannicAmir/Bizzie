import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late GetFcmToken usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = GetFcmToken(mockRepository);
  });

  const tToken = 'test_token';

  test('getFcmToken_called_returnsTokenFromRepository', () async {
    // arrange
    when(() => mockRepository.getFcmToken()).thenAnswer((_) async => tToken);

    // act
    final result = await usecase();

    // assert
    expect(result, tToken);
    verify(() => mockRepository.getFcmToken()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('getFcmToken_repositoryThrows_throwsException', () async {
    // arrange
    when(() => mockRepository.getFcmToken()).thenThrow(Exception('Error'));

    // act
    final call = usecase.call;

    // assert
    expect(call, throwsException);
    verify(() => mockRepository.getFcmToken()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
