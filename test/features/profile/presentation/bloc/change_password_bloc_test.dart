import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_bloc.dart';
import 'package:bizzie/features/profile/presentation/analytics/profile_tracker.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChangePasswordUseCase extends Mock implements ChangePasswordUseCase {}

class MockProfileTracker extends Mock implements ProfileTracker {}

void main() {
  late MockChangePasswordUseCase mockUseCase;
  late MockProfileTracker mockTracker;
  late ChangePasswordBloc bloc;

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
    mockUseCase = MockChangePasswordUseCase();
    mockTracker = MockProfileTracker();

    when(() => mockTracker.logPasswordChangeSuccess()).thenAnswer((_) async {});
    when(
      () => mockTracker.logPasswordChangeFailure(
        type: any(named: 'type'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async {});

    bloc = ChangePasswordBloc(mockUseCase, mockTracker);
  });

  tearDown(() {
    bloc.close();
  });

  group('ChangePasswordBloc', () {
    test('given_nothing_when_initialized_then_stateIsInitial', () {
      // assert
      expect(bloc.state, const ChangePasswordState.initial());
    });

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'given_blocInitialized_when_startedEventAdded_then_emitsFormState',
      build: () => bloc,
      act: (bloc) => bloc.add(const ChangePasswordEvent.started()),
      expect: () => [const ChangePasswordState.form()],
    );

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'given_formState_when_passwordFieldsChange_then_emitsUpdatedFormStates',
      build: () => bloc,
      seed: () => const ChangePasswordState.form(),
      act: (bloc) {
        bloc.add(const ChangePasswordEvent.oldPasswordChanged('old'));
        bloc.add(const ChangePasswordEvent.newPasswordChanged('new'));
        bloc.add(const ChangePasswordEvent.confirmPasswordChanged('new'));
      },
      expect: () => [
        const ChangePasswordState.form(oldPassword: 'old'),
        const ChangePasswordState.form(oldPassword: 'old', newPassword: 'new'),
        const ChangePasswordState.form(
          oldPassword: 'old',
          newPassword: 'new',
          confirmPassword: 'new',
        ),
      ],
    );

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'given_formFilled_when_saveRequestedAndUseCaseSucceeds_then_emitsLoadingThenSuccess',
      build: () => bloc,
      seed: () => const ChangePasswordState.form(
        oldPassword: 'old',
        newPassword: 'new',
        confirmPassword: 'new',
      ),
      setUp: () {
        // arrange
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
      },
      act: (bloc) => bloc.add(const ChangePasswordEvent.saveRequested()),
      expect: () => [
        const ChangePasswordState.form(
          oldPassword: 'old',
          newPassword: 'new',
          confirmPassword: 'new',
          isSubmitting: true,
        ),
        const ChangePasswordState.success(),
      ],
      verify: (_) {
        verify(() => mockTracker.logPasswordChangeSuccess()).called(1);
      },
    );

    blocTest<ChangePasswordBloc, ChangePasswordState>(
      'given_formFilled_when_saveRequestedAndUseCaseFails_then_emitsLoadingThenFormWithFailure',
      build: () => bloc,
      seed: () => const ChangePasswordState.form(
        oldPassword: 'old',
        newPassword: 'new',
        confirmPassword: 'new',
      ),
      setUp: () {
        // arrange
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.passwordMismatch()));
      },
      act: (bloc) => bloc.add(const ChangePasswordEvent.saveRequested()),
      expect: () => [
        const ChangePasswordState.form(
          oldPassword: 'old',
          newPassword: 'new',
          confirmPassword: 'new',
          isSubmitting: true,
        ),
        const ChangePasswordState.form(
          oldPassword: 'old',
          newPassword: 'new',
          confirmPassword: 'new',
          isSubmitting: false,
          failure: Failure.passwordMismatch(),
        ),
      ],
      verify: (_) {
        verify(
          () => mockTracker.logPasswordChangeFailure(
            type: any(named: 'type'),
            message: any(named: 'message'),
          ),
        ).called(1);
      },
    );
  });
}
