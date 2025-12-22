import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late DeleteAccount usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = DeleteAccount(mockAuthRepository);
  });

  test('deleteAccount_success_callsRepository', () async {
    // arrange
    when(() => mockAuthRepository.deleteAccount()).thenAnswer((_) async {});

    // act
    await usecase(NoParams());

    // assert
    verify(() => mockAuthRepository.deleteAccount());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('deleteAccount_failure_throwsException', () async {
    // arrange
    when(() => mockAuthRepository.deleteAccount()).thenThrow(Exception());

    // act
    final call = usecase.call;

    // assert
    expect(() => call(NoParams()), throwsException);
    verify(() => mockAuthRepository.deleteAccount());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
