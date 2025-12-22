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

  test('signOut_success_callsRepository', () async {
    // arrange
    when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});

    // act
    await usecase(NoParams());

    // assert
    verify(() => mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('signOut_failure_throwsException', () async {
    // arrange
    when(() => mockAuthRepository.signOut()).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(() => call(NoParams()), throwsException);
    verify(() => mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
