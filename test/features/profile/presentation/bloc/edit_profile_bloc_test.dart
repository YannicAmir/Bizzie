import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/enums/auth_provider.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_model;
import 'package:bizzie/features/auth/domain/usecases/get_current_user.dart';
import 'package:bizzie/features/auth/domain/usecases/reauthenticate_usecase.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';
import 'package:bizzie/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:bizzie/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_state.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart'
    as domain_model;
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/features/profile/presentation/analytics/profile_tracker.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}

class MockReauthenticateUseCase extends Mock implements ReauthenticateUseCase {}

class MockAnalyticsContext extends Mock implements AnalyticsContext {}

class MockProfileTracker extends Mock implements ProfileTracker {}

void main() {
  late EditProfileBloc bloc;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockDeleteAccountUseCase mockDeleteAccountUseCase;
  late MockReauthenticateUseCase mockReauthenticateUseCase;
  late MockProfileTracker mockTracker;

  setUpAll(() {
    registerFallbackValue(
      const ReauthenticateParams(provider: AuthProvider.password),
    );
    registerFallbackValue(const UpdateProfileParams());
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();
    mockGetUserUseCase = MockGetUserUseCase();
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    mockDeleteAccountUseCase = MockDeleteAccountUseCase();
    mockReauthenticateUseCase = MockReauthenticateUseCase();
    mockTracker = MockProfileTracker();

    when(() => mockTracker.logEditProfileStarted()).thenAnswer((_) async {});
    when(
      () => mockTracker.logProfileUpdateSuccess(
        updatedFields: any(named: 'updatedFields'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logProfileUpdateFailure(
        type: any(named: 'type'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logReauthStarted(reason: any(named: 'reason')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logReauthResult(
        provider: any(named: 'provider'),
        success: any(named: 'success'),
        attempts: any(named: 'attempts'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logDeleteAccountInitiated(),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logAccountDeletionSuccess(),
    ).thenAnswer((_) async {});

    when(() => mockGetUserUseCase.cachedSector).thenReturn('Technology');

    bloc = EditProfileBloc(
      mockGetCurrentUser,
      mockGetUserUseCase,
      mockUpdateProfileUseCase,
      mockDeleteAccountUseCase,
      mockReauthenticateUseCase,
      mockTracker,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tUserModel = domain_model.UserModel(
    uid: '123',
    name: 'Test User',
    favoriteSector: 'Technology',
    watchlist: [],
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime.now(),
    isSubscribed: false,
  );

  const tCurrentUser = auth_model.UserModel(
    id: '123',
    email: 'test@example.com',
    providers: ['password'],
  );

  group('EditProfileBloc', () {
    test('initialState_is_correct', () {
      // assert
      expect(
        bloc.state,
        const EditProfileState.initial(favoriteSector: 'Technology'),
      );
    });

    blocTest<EditProfileBloc, EditProfileState>(
      'givenUserIsSignedIn_whenStartedAdded_thenEmitLoadingAndForm',
      build: () {
        // arrange
        when(() => mockGetCurrentUser()).thenReturn(tCurrentUser);
        when(
          () => mockGetUserUseCase(any()),
        ).thenAnswer((_) async => Right(tUserModel));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const EditProfileEvent.started()),
      // assert
      expect: () => [
        const EditProfileState.loading(favoriteSector: 'Technology'),
        const EditProfileState.form(
          firstName: 'Test User',
          email: 'test@example.com',
          originalFirstName: 'Test User',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['password'],
        ),
      ],
      verify: (_) {
        verify(() => mockTracker.logEditProfileStarted()).called(1);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenUserNotSignedIn_whenStartedAdded_thenEmitFailure',
      build: () {
        // arrange
        when(() => mockGetCurrentUser()).thenReturn(null);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const EditProfileEvent.started()),
      // assert
      expect: () => [
        const EditProfileState.loading(favoriteSector: 'Technology'),
        const EditProfileState.failure(
          Failure.userNotFound(),
          favoriteSector: 'Technology',
        ),
      ],
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenPendingSave_whenPasswordReauthSucceeds_thenEmitSuccessFollowingSaveAction',
      seed: () => const EditProfileState.form(
        firstName: 'New Name',
        email: 'test@example.com',
        originalFirstName: 'Old Name',
        originalEmail: 'test@example.com',
        favoriteSector: 'Technology',
        providers: ['password'],
        isSubmitting: false,
        pendingReauthAction: ReauthAction.save,
      ),
      build: () {
        // arrange
        when(
          () => mockReauthenticateUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockUpdateProfileUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(
        const EditProfileEvent.reauthenticateWithPassword('password123'),
      ),
      // assert
      expect: () => [
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['password'],
          isSubmitting: false,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: true,
        ),
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['password'],
          isSubmitting: false,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: false,
          isShowReauthModal: false,
          reauthAttempts: 0,
        ),
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['password'],
          isSubmitting: true,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: false,
          isShowReauthModal: false,
          reauthAttempts: 0,
        ),
        const EditProfileState.success(favoriteSector: 'Technology'),
      ],
      verify: (_) {
        verify(
          () => mockTracker.logProfileUpdateSuccess(
            updatedFields: any(named: 'updatedFields'),
          ),
        ).called(1);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenValidForm_whenSaveRequestedFails_thenEmitFailure',
      seed: () => const EditProfileState.form(
        firstName: 'New Name',
        email: 'test@example.com',
        originalFirstName: 'Old Name',
        originalEmail: 'test@example.com',
        favoriteSector: 'Technology',
      ),
      build: () {
        // arrange
        when(
          () => mockUpdateProfileUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Save failed')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const EditProfileEvent.saveRequested()),
      // assert
      expect: () => [
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          isSubmitting: true,
        ),
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          isSubmitting: false,
          saveFailure: Failure.server('Save failed'),
        ),
      ],
      verify: (_) {
        verify(
          () => mockTracker.logProfileUpdateFailure(
            type: any(named: 'type'),
            message: any(named: 'message'),
          ),
        ).called(1);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenPendingSave_whenAppleReauthSucceeds_thenEmitSuccessFollowingSaveAction',
      seed: () => const EditProfileState.form(
        firstName: 'New Name',
        email: 'test@example.com',
        originalFirstName: 'Old Name',
        originalEmail: 'test@example.com',
        favoriteSector: 'Technology',
        providers: ['apple.com'],
        isSubmitting: false,
        pendingReauthAction: ReauthAction.save,
      ),
      build: () {
        // arrange
        when(
          () => mockReauthenticateUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockUpdateProfileUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const EditProfileEvent.reauthenticateWithApple()),
      // assert
      expect: () => [
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['apple.com'],
          isSubmitting: false,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: true,
        ),
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['apple.com'],
          isSubmitting: false,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: false,
          isShowReauthModal: false,
          reauthAttempts: 0,
        ),
        const EditProfileState.form(
          firstName: 'New Name',
          email: 'test@example.com',
          originalFirstName: 'Old Name',
          originalEmail: 'test@example.com',
          favoriteSector: 'Technology',
          providers: ['apple.com'],
          isSubmitting: true,
          pendingReauthAction: ReauthAction.save,
          isReauthSubmitting: false,
          isShowReauthModal: false,
          reauthAttempts: 0,
        ),
        const EditProfileState.success(favoriteSector: 'Technology'),
      ],
      verify: (_) {
        verify(
          () => mockReauthenticateUseCase(
            any(
              that: isA<ReauthenticateParams>().having(
                (p) => p.provider,
                'provider',
                AuthProvider.apple,
              ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenReauthScenario_whenPasswordReauthFails_thenEmitFailureAndIncrementAttempts',
      seed: () => const EditProfileState.form(
        firstName: 'Name',
        email: 'email',
        originalFirstName: 'Name',
        originalEmail: 'email',
        reauthAttempts: 0,
      ),
      build: () {
        // arrange
        when(
          () => mockReauthenticateUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.reauthentication()));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(
        const EditProfileEvent.reauthenticateWithPassword('wrongpass'),
      ),
      // assert
      expect: () => [
        const EditProfileState.form(
          firstName: 'Name',
          email: 'email',
          originalFirstName: 'Name',
          originalEmail: 'email',
          reauthAttempts: 0,
          isReauthSubmitting: true,
        ),
        const EditProfileState.form(
          firstName: 'Name',
          email: 'email',
          originalFirstName: 'Name',
          originalEmail: 'email',
          reauthAttempts: 1,
          isReauthSubmitting: false,
          reauthFailure: Failure.reauthentication(),
        ),
      ],
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'givenAttemptsAtLimit_whenPasswordReauthFails_thenDismissModalAndClearFailure',
      seed: () => const EditProfileState.form(
        firstName: 'Name',
        email: 'email',
        originalFirstName: 'Name',
        originalEmail: 'email',
        reauthAttempts: 2,
      ),
      build: () {
        // arrange
        when(
          () => mockReauthenticateUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.reauthentication()));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(
        const EditProfileEvent.reauthenticateWithPassword('wrongpass'),
      ),
      // assert
      expect: () => [
        const EditProfileState.form(
          firstName: 'Name',
          email: 'email',
          originalFirstName: 'Name',
          originalEmail: 'email',
          reauthAttempts: 2,
          isReauthSubmitting: true,
        ),
        const EditProfileState.form(
          firstName: 'Name',
          email: 'email',
          originalFirstName: 'Name',
          originalEmail: 'email',
          reauthAttempts: 3,
          isReauthSubmitting: false,
          reauthFailure: Failure.reauthentication(),
        ),
        const EditProfileState.form(
          firstName: 'Name',
          email: 'email',
          originalFirstName: 'Name',
          originalEmail: 'email',
          reauthAttempts: 3,
          isReauthSubmitting: false,
          reauthFailure: null,
          isShowReauthModal: false,
          pendingReauthAction: null,
        ),
      ],
    );
  });
}
