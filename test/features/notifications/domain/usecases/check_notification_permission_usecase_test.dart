import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/check_notification_permission_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late CheckNotificationPermissionUseCase sut;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    sut = CheckNotificationPermissionUseCase(mockRepository);
  });

  group('CheckNotificationPermissionUseCase', () {
    test('call_systemAuthorized_returnsRightTrue', () async {
      // arrange
      when(
        () => mockRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(true));
      // act
      final result = await sut(NoParams());
      // assert
      expect(result, const Right<Failure, bool>(true));
      verify(() => mockRepository.isSystemAuthorized()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_systemNotAuthorized_returnsRightFalse', () async {
      // arrange
      when(
        () => mockRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(false));
      // act
      final result = await sut(NoParams());
      // assert
      expect(result, const Right<Failure, bool>(false));
    });

    test('call_repositoryFails_returnsLeftFailure', () async {
      // arrange
      when(() => mockRepository.isSystemAuthorized()).thenAnswer(
        (_) async => const Left(Failure.permission('Exception: boom')),
      );
      // act
      final result = await sut(NoParams());
      // assert
      expect(
        result,
        const Left<Failure, bool>(Failure.permission('Exception: boom')),
      );
    });
  });
}
