import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late RequestNotificationPermissionUseCase usecase;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    usecase = RequestNotificationPermissionUseCase(mockRepository);
  });

  test('requestNotificationPermission_called_delegatesToRepository', () async {
    // arrange
    when(
      () => mockRepository.requestPermission(),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.requestPermission()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'requestNotificationPermission_repositoryThrows_returnsFailure',
    () async {
      // arrange
      when(
        () => mockRepository.requestPermission(),
      ).thenAnswer((_) async => Left(Failure.server('Error')));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, Left(Failure.server('Error')));
      verify(() => mockRepository.requestPermission()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
