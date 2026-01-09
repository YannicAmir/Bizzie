import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:dartz/dartz.dart';
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
    when(
      () => mockRepository.getFcmToken(),
    ).thenAnswer((_) async => const Right(tToken));

    // act
    final result = await usecase();

    // assert
    expect(result, const Right(tToken));
    verify(() => mockRepository.getFcmToken()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('getFcmToken_repositoryThrows_returnsFailure', () async {
    // arrange
    when(
      () => mockRepository.getFcmToken(),
    ).thenAnswer((_) async => Left(ServerFailure('Error')));

    // act
    final result = await usecase();

    // assert
    expect(result, Left(ServerFailure('Error')));
    verify(() => mockRepository.getFcmToken()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
