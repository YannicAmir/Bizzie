import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_user;
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/open_app_settings_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/reset_password_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetSettingsDisplayDataUseCase extends Mock
    implements GetSettingsDisplayDataUseCase {}

class MockToggleNotificationsUseCase extends Mock
    implements ToggleNotificationsUseCase {}

class MockSubmitFeedbackUseCase extends Mock implements SubmitFeedbackUseCase {}

class MockLaunchUrlUseCase extends Mock implements LaunchUrlUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockOpenAppSettingsUseCase extends Mock
    implements OpenAppSettingsUseCase {}

void main() {
  late MockGetSettingsDisplayDataUseCase mockGetSettingsDisplayDataUseCase;
  late MockToggleNotificationsUseCase mockToggleNotificationsUseCase;
  late MockSubmitFeedbackUseCase mockSubmitFeedbackUseCase;
  late MockLaunchUrlUseCase mockLaunchUrlUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late SettingsBloc settingsBloc;

  setUp(() {
    mockGetSettingsDisplayDataUseCase = MockGetSettingsDisplayDataUseCase();
    mockToggleNotificationsUseCase = MockToggleNotificationsUseCase();
    mockSubmitFeedbackUseCase = MockSubmitFeedbackUseCase();
    mockLaunchUrlUseCase = MockLaunchUrlUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockAuthRepository = MockAuthRepository();
    mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();

    settingsBloc = SettingsBloc(
      mockGetSettingsDisplayDataUseCase,
      mockToggleNotificationsUseCase,
      mockSubmitFeedbackUseCase,
      mockLaunchUrlUseCase,
      mockSignOutUseCase,
      mockResetPasswordUseCase,
      mockAuthRepository,
      mockOpenAppSettingsUseCase,
    );

    registerFallbackValue(NoParams());
  });

  tearDown(() {
    settingsBloc.close();
  });

  final tUser = UserModel(
    uid: '123',
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime(2023),
    isSubscribed: false,
    notificationsEnabled: true,
  );

  final tSubscriptionStatus = SubscriptionStatus.initial();

  final tSettingsData = SettingsDisplayData(
    user: tUser,
    subscriptionStatus: tSubscriptionStatus,
    isAppNotificationsEnabled: true,
    isSystemNotificationsEnabled: true,
    appVersion: '1.0.0',
    favoriteSector: 'Information Technology',
  );

  group('SettingsBloc Initialization', () {
    test('initialState_noAction_shouldBeInitial', () {
      // assert
      expect(settingsBloc.state, const SettingsState.initial());
    });

    blocTest<SettingsBloc, SettingsState>(
      'started_initializationSucceeds_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetSettingsDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tSettingsData));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.started()),
      expect: () => [
        const SettingsState.loading(),
        SettingsState.loaded(tSettingsData),
      ],
      verify: (_) {
        // assert
        verify(() => mockGetSettingsDisplayDataUseCase(any())).called(1);
        verifyNoMoreInteractions(mockGetSettingsDisplayDataUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'started_initializationFails_emitsLoadingAndFailure',
      build: () {
        // arrange
        when(
          () => mockGetSettingsDisplayDataUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Server Error')));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.started()),
      expect: () => [
        const SettingsState.loading(),
        const SettingsState.failure(Failure.server('Server Error')),
      ],
      verify: (_) {
        // assert
        verify(() => mockGetSettingsDisplayDataUseCase(any())).called(1);
        verifyNoMoreInteractions(mockGetSettingsDisplayDataUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'started_alreadyLoaded_emitsNothingForSilentRefresh',
      seed: () => SettingsState.loaded(tSettingsData),
      build: () {
        // arrange
        when(
          () => mockGetSettingsDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tSettingsData));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.started()),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockGetSettingsDisplayDataUseCase(any())).called(1);
        verifyNoMoreInteractions(mockGetSettingsDisplayDataUseCase);
      },
    );
  });

  group('Notification Toggling', () {
    blocTest<SettingsBloc, SettingsState>(
      'toggledNotifications_enableSuccess_optimisticallyUpdatesAndCallsUseCase',
      seed: () => SettingsState.loaded(
        tSettingsData.copyWith(isAppNotificationsEnabled: false),
      ),
      build: () {
        // arrange
        when(
          () => mockToggleNotificationsUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.toggledNotifications(true)),
      expect: () => [
        SettingsState.loaded(
          tSettingsData.copyWith(isAppNotificationsEnabled: true),
        ),
      ],
      verify: (_) {
        // assert
        verify(() => mockToggleNotificationsUseCase(true)).called(1);
        verifyNoMoreInteractions(mockToggleNotificationsUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'toggledNotifications_systemPermissionMissing_revertsStateAndEmitsFailure',
      seed: () => SettingsState.loaded(
        tSettingsData.copyWith(isSystemNotificationsEnabled: false),
      ),
      build: () {
        // arrange
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.toggledNotifications(true)),
      expect: () => [
        const SettingsState.failure(Failure.permission()),
        SettingsState.loaded(
          tSettingsData.copyWith(
            isSystemNotificationsEnabled: false,
            isAppNotificationsEnabled: false,
            favoriteSector: 'Information Technology',
          ),
        ),
      ],
      verify: (_) {
        // assert
        verifyZeroInteractions(mockToggleNotificationsUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'toggledNotifications_useCaseFails_revertsState',
      seed: () => SettingsState.loaded(tSettingsData),
      build: () {
        // arrange
        when(
          () => mockToggleNotificationsUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Error')));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.toggledNotifications(false)),
      expect: () => [
        SettingsState.loaded(
          tSettingsData.copyWith(isAppNotificationsEnabled: false),
        ),
        SettingsState.loaded(
          tSettingsData.copyWith(isAppNotificationsEnabled: true),
        ),
      ],
      verify: (_) {
        // assert
        verify(() => mockToggleNotificationsUseCase(false)).called(1);
        verifyNoMoreInteractions(mockToggleNotificationsUseCase);
      },
    );
  });

  group('Sign Out', () {
    blocTest<SettingsBloc, SettingsState>(
      'signedOut_success_emitsLoadingAndInitial',
      build: () {
        // arrange
        when(
          () => mockSignOutUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.signedOut()),
      expect: () => [
        const SettingsState.loading(),
        const SettingsState.initial(),
      ],
      verify: (_) {
        // assert
        verify(() => mockSignOutUseCase(any())).called(1);
        verifyNoMoreInteractions(mockSignOutUseCase);
      },
    );
  });

  group('Other Actions', () {
    blocTest<SettingsBloc, SettingsState>(
      'openUrl_validUrl_callsUseCaseWithCorrectUrl',
      build: () {
        // arrange
        when(
          () => mockLaunchUrlUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.openUrl('https://test.com')),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockLaunchUrlUseCase('https://test.com')).called(1);
        verifyNoMoreInteractions(mockLaunchUrlUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'submitFeedback_validMessage_callsUseCaseWithCorrectMessage',
      build: () {
        // arrange
        when(
          () => mockSubmitFeedbackUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.submitFeedback('Feedback')),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockSubmitFeedbackUseCase('Feedback')).called(1);
        verifyNoMoreInteractions(mockSubmitFeedbackUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'resetPassword_userLoggedIn_callsUseCaseWithCurrentEmail',
      build: () {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(
          const auth_user.UserModel(id: '123', email: 'test@test.com'),
        );
        when(
          () => mockResetPasswordUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.resetPassword()),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockResetPasswordUseCase('test@test.com')).called(1);
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'openedSettings_noAction_callsUseCase',
      build: () {
        // arrange
        when(
          () => mockOpenAppSettingsUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.openedSettings()),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockOpenAppSettingsUseCase(any())).called(1);
        verifyNoMoreInteractions(mockOpenAppSettingsUseCase);
      },
    );
  });
}
