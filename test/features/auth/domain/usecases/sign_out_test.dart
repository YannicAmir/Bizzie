import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignOut usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignOut(mockAuthRepository);
  });

  const tFailure = ServerFailure('Test Failure');

  test('signOut_success_returnsRightVoid', () async {
    // arrange
    when(
      () => mockAuthRepository.signOut(),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signOut_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.signOut(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
