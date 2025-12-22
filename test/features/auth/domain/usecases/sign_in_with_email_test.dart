import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignInWithEmail usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithEmail(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserModel(id: '1', email: tEmail);

  test('signInWithEmail_success_returnsUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => tUser);

    // act
    final result = await usecase(
      SignInWithEmailParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, tUser);
    verify(
      () => mockAuthRepository.signInWithEmail(
        email: tEmail,
        password: tPassword,
      ),
    );
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signInWithEmail_failure_throwsException', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(
      () => call(SignInWithEmailParams(email: tEmail, password: tPassword)),
      throwsException,
    );
    verify(
      () => mockAuthRepository.signInWithEmail(
        email: tEmail,
        password: tPassword,
      ),
    );
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
