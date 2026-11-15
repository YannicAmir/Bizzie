import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late DeleteAccountUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = DeleteAccountUseCase(mockAuthRepository);
  });

  const tFailure = Failure.server('Test Failure');

  test('deleteAccount_success_returnsRightVoid', () async {
    // arrange
    when(
      () => mockAuthRepository.deleteAccount(),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.deleteAccount());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('deleteAccount_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.deleteAccount(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.deleteAccount());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
