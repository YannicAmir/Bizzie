import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignInWithApple usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithApple(mockAuthRepository);
  });

  const tUser = UserModel(id: '1', email: 'test@apple.com');
  const tFailure = ServerFailure('Test Failure');

  test('signInWithApple_success_returnsRightUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithApple(),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.signInWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signInWithApple_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithApple(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.signInWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
