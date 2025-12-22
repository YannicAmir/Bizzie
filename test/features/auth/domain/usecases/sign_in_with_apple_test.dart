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

  test('signInWithApple_success_returnsUser', () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithApple(),
    ).thenAnswer((_) async => tUser);

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, tUser);
    verify(() => mockAuthRepository.signInWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signInWithApple_failure_throwsException', () async {
    // arrange
    when(() => mockAuthRepository.signInWithApple()).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(() => call(NoParams()), throwsException);
    verify(() => mockAuthRepository.signInWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
