import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/settings/domain/enums/sign_out_mode.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockSubscriptionRepository extends Mock
    implements ISubscriptionRepository {}

void main() {
  late SignOutUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockSubscriptionRepository mockSubscriptionRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockSubscriptionRepository = MockSubscriptionRepository();
    useCase = SignOutUseCase(mockAuthRepository, mockSubscriptionRepository);
  });

  group('SignOutUseCase', () {
    test('call_allSuccess_returnsRight', () async {
      // arrange
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockSubscriptionRepository.logOut(),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await useCase(SignOutMode.standard);

      // assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.signOut()).called(1);
      verify(() => mockSubscriptionRepository.logOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockSubscriptionRepository);
    });

    test('call_authSignOutFails_returnsLeft', () async {
      // arrange
      const tFailure = Failure.server('Sign out failed');
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(SignOutMode.standard);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockAuthRepository.signOut()).called(1);
      verifyZeroInteractions(mockSubscriptionRepository);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('call_subLogOutFails_returnsRightDueToResiliency', () async {
      // arrange
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockSubscriptionRepository.logOut(),
      ).thenThrow(Exception('Sub logOut failed'));

      // act
      final result = await useCase(SignOutMode.standard);

      // assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.signOut()).called(1);
      verify(() => mockSubscriptionRepository.logOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockSubscriptionRepository);
    });

    test('call_subLogOutReturnsLeft_returnsRightDueToResiliency', () async {
      // arrange
      const tFailure = Failure.server('Sub logOut failed');
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockSubscriptionRepository.logOut(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(SignOutMode.standard);

      // assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.signOut()).called(1);
      verify(() => mockSubscriptionRepository.logOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockSubscriptionRepository);
    });

    test(
      'call_deleteGuestAccountMode_deletesAnonymousUserAndSignsOutWithoutPlainSignOut',
      () async {
        // arrange
        when(
          () => mockAuthRepository.deleteAnonymousUserAndSignOut(),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockSubscriptionRepository.logOut(),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await useCase(SignOutMode.deleteGuestAccount);

        // assert
        expect(result, const Right(null));
        verify(
          () => mockAuthRepository.deleteAnonymousUserAndSignOut(),
        ).called(1);
        verifyNever(() => mockAuthRepository.signOut());
        verify(() => mockSubscriptionRepository.logOut()).called(1);
      },
    );

    test('call_standardMode_neverDeletesAnonymousUser', () async {
      // arrange
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockSubscriptionRepository.logOut(),
      ).thenAnswer((_) async => const Right(null));

      // act
      await useCase(SignOutMode.standard);

      // assert
      verifyNever(() => mockAuthRepository.deleteAnonymousUserAndSignOut());
    });

    test('call_deleteGuestAccountModeFails_returnsLeft', () async {
      // arrange
      const tFailure = Failure.server('Sign out failed');
      when(
        () => mockAuthRepository.deleteAnonymousUserAndSignOut(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(SignOutMode.deleteGuestAccount);

      // assert
      expect(result, const Left(tFailure));
      verifyZeroInteractions(mockSubscriptionRepository);
    });
  });
}
