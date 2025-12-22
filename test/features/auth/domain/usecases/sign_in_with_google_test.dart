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

  test('signInWithGoogle_success_returnsUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithGoogle(),
    ).thenAnswer((_) async => tUser);

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, tUser);
    verify(() => mockAuthRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signInWithGoogle_failure_throwsException', () async {
    // arrange
    when(() => mockAuthRepository.signInWithGoogle()).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(() => call(NoParams()), throwsException);
    verify(() => mockAuthRepository.signInWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
