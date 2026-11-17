import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_apple_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LinkWithAppleUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LinkWithAppleUseCase(mockAuthRepository);
  });

  const tUser = UserModel(id: '1', email: 'test@apple.com');
  const tFailure = Failure.server('Test Failure');

  test('linkWithApple_success_returnsRightUser', () async {
    // arrange
    when(
      () => mockAuthRepository.linkWithApple(),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.linkWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('linkWithApple_failure_returnsLeftFailure', () async {
    // arrange
    when(
      () => mockAuthRepository.linkWithApple(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.linkWithApple());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
