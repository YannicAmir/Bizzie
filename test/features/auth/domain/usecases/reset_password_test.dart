import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late ResetPassword usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = ResetPassword(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tFailure = ServerFailure('Test Failure');

  test('resetPassword_success_returnsRightVoid', () async {
    // arrange
    when(
      () => mockAuthRepository.resetPassword(email: any(named: 'email')),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(ResetPasswordParams(email: tEmail));

    // assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.resetPassword(email: tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('resetPassword_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.resetPassword(email: any(named: 'email')),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(ResetPasswordParams(email: tEmail));

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.resetPassword(email: tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
