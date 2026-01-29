import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignInWithGoogle usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithGoogle(mockAuthRepository);
  });

  const tUser = UserModel(id: '1', email: 'test@gmail.com');
  const tFailure = Failure.server('Test Failure');

  test('signInWithGoogle_success_returnsRightUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithGoogle(),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signInWithGoogle_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithGoogle(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
