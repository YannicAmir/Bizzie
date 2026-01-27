import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignUpWithEmail usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignUpWithEmail(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserModel(id: '1', email: tEmail);
  const tFailure = Failure.server('Test Failure');

  test('signUpWithEmail_success_returnsRightUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signUpWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(
      SignUpWithEmailParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, const Right(tUser));
    verify(
      () => mockAuthRepository.signUpWithEmail(
        email: tEmail,
        password: tPassword,
      ),
    );
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signUpWithEmail_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.signUpWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(
      SignUpWithEmailParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, const Left(tFailure));
    verify(
      () => mockAuthRepository.signUpWithEmail(
        email: tEmail,
        password: tPassword,
      ),
    );
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
