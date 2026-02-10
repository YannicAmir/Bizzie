import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ChangePasswordUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      const ChangePasswordParams(
        oldPassword: '',
        newPassword: '',
        confirmPassword: '',
      ),
    );
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = ChangePasswordUseCase(mockAuthRepository);
  });

  const tOldPassword = 'oldPassword';
  const tNewPassword = 'newPassword';
  const tConfirmPassword = 'newPassword';

  group('ChangePasswordUseCase', () {
    test(
      'given_passwordsMatchAndRepoSucceeds_when_call_then_returnsRightNull',
      () async {
        // arrange
        when(
          () => mockAuthRepository.updatePassword(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await useCase(
          const ChangePasswordParams(
            oldPassword: tOldPassword,
            newPassword: tNewPassword,
            confirmPassword: tConfirmPassword,
          ),
        );

        // assert
        expect(result, const Right(null));
        verify(
          () => mockAuthRepository.updatePassword(
            oldPassword: tOldPassword,
            newPassword: tNewPassword,
          ),
        ).called(1);
      },
    );

    test(
      'given_passwordsDoNotMatch_when_call_then_returnsLeftPasswordMismatchFailure',
      () async {
        // act
        final result = await useCase(
          const ChangePasswordParams(
            oldPassword: tOldPassword,
            newPassword: tNewPassword,
            confirmPassword: 'differentPassword',
          ),
        );

        // assert
        expect(result, const Left(Failure.passwordMismatch()));
        verifyZeroInteractions(mockAuthRepository);
      },
    );

    test(
      'given_repositoryCallFails_when_call_then_returnsLeftFailure',
      () async {
        // arrange
        const tFailure = Failure.server('Server Error');
        when(
          () => mockAuthRepository.updatePassword(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await useCase(
          const ChangePasswordParams(
            oldPassword: tOldPassword,
            newPassword: tNewPassword,
            confirmPassword: tConfirmPassword,
          ),
        );

        // assert
        expect(result, const Left(tFailure));
        verify(
          () => mockAuthRepository.updatePassword(
            oldPassword: tOldPassword,
            newPassword: tNewPassword,
          ),
        ).called(1);
      },
    );
  });
}
