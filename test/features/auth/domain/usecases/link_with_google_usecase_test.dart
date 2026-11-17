import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_google_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LinkWithGoogleUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LinkWithGoogleUseCase(mockAuthRepository);
  });

  const tUser = UserModel(id: '1', email: 'test@google.com');
  const tFailure = Failure.server('Test Failure');

  test('linkWithGoogle_success_returnsRightUser', () async {
    // arrange
    when(
      () => mockAuthRepository.linkWithGoogle(),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.linkWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('linkWithGoogle_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.linkWithGoogle(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.linkWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
