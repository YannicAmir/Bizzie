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

  test('resetPassword_success_callsRepository', () async {
    // arrange
    when(
      () => mockAuthRepository.resetPassword(email: any(named: 'email')),
    ).thenAnswer((_) async {});

    // act
    await usecase(tEmail);

    // assert
    verify(() => mockAuthRepository.resetPassword(email: tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('resetPassword_failure_throwsException', () async {
    // arrange
    when(
      () => mockAuthRepository.resetPassword(email: any(named: 'email')),
    ).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(() => call(tEmail), throwsException);
    verify(() => mockAuthRepository.resetPassword(email: tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
