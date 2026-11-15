import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

const tCurrentUser = UserModel(id: 'current-uid', email: 'jane@test.com');
const tAnonymousUser = UserModel(id: 'anon-uid', email: '', isAnonymous: true);
const tFailure = Failure.server('Test Failure');

void main() {
  late ResolveOnboardingUserUseCase sut;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    sut = ResolveOnboardingUserUseCase(mockAuthRepository);
  });

  group('ResolveOnboardingUserUseCase', () {
    test('call_currentUserExists_returnsCurrentUserWithoutSigningIn', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tCurrentUser);

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Right(tCurrentUser));
      verifyNever(() => mockAuthRepository.signInAnonymously());
    });

    test('call_noCurrentUser_signsInAnonymously', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);
      when(
        () => mockAuthRepository.signInAnonymously(),
      ).thenAnswer((_) async => const Right(tAnonymousUser));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Right(tAnonymousUser));
      verify(() => mockAuthRepository.signInAnonymously()).called(1);
    });

    test('call_anonymousSignInFails_returnsLeftFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);
      when(
        () => mockAuthRepository.signInAnonymously(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
