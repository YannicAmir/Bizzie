import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/settings/domain/enums/guest_logout_choice.dart';
import 'package:bizzie/features/settings/domain/enums/settings_link_type.dart';
import 'package:bizzie/features/settings/domain/enums/sign_out_mode.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/open_app_settings_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/features/settings/presentation/analytics/settings_tracker.dart';

class MockGetSettingsDisplayDataUseCase extends Mock
    implements GetSettingsDisplayDataUseCase {}

class MockToggleNotificationsUseCase extends Mock
    implements ToggleNotificationsUseCase {}

class MockLaunchUrlUseCase extends Mock implements LaunchUrlUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockOpenAppSettingsUseCase extends Mock
    implements OpenAppSettingsUseCase {}

class MockSettingsTracker extends Mock implements SettingsTracker {}

void main() {
  late MockGetSettingsDisplayDataUseCase mockGetSettingsDisplayDataUseCase;
  late MockToggleNotificationsUseCase mockToggleNotificationsUseCase;
  late MockLaunchUrlUseCase mockLaunchUrlUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockOpenAppSettingsUseCase mockOpenAppSettingsUseCase;
  late MockSettingsTracker mockTracker;
  late SettingsBloc settingsBloc;

  setUp(() {
    mockGetSettingsDisplayDataUseCase = MockGetSettingsDisplayDataUseCase();
    mockToggleNotificationsUseCase = MockToggleNotificationsUseCase();
    mockLaunchUrlUseCase = MockLaunchUrlUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockOpenAppSettingsUseCase = MockOpenAppSettingsUseCase();
    mockTracker = MockSettingsTracker();

    settingsBloc = SettingsBloc(
      mockGetSettingsDisplayDataUseCase,
      mockToggleNotificationsUseCase,
      mockLaunchUrlUseCase,
      mockSignOutUseCase,
      mockOpenAppSettingsUseCase,
      mockTracker,
    );

    registerFallbackValue(NoParams());
    registerFallbackValue(GuestLogoutChoice.dismissed);
    registerFallbackValue(SignOutMode.standard);
    registerFallbackValue(SettingsLinkType.privacyPolicy);

    when(() => mockTracker.logSettingsViewed()).thenAnswer((_) async {});
    when(
      () => mockTracker.logNotificationsToggled(enabled: any(named: 'enabled')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logNotificationsPermissionDenied(),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSignOutClicked(isGuest: any(named: 'isGuest')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSignOutSuccess(isGuest: any(named: 'isGuest')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logGuestLogoutChoice(choice: any(named: 'choice')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSettingsLinkClicked(type: any(named: 'type')),
    ).thenAnswer((_) async {});
    when(() => mockTracker.logSystemSettingsOpened()).thenAnswer((_) async {});
    when(() => mockTracker.logEditProfileClicked()).thenAnswer((_) async {});
    when(() => mockTracker.logFeedbackClicked()).thenAnswer((_) async {});
    when(
      () => mockTracker.logMembershipClicked(
        isSubscribed: any(named: 'isSubscribed'),
      ),
    ).thenAnswer((_) async {});
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
    favoriteSector: 'Technology',
    privacyPolicyUrl: 'https://privacy.com',
    termsOfServiceUrl: 'https://terms.com',
  );

  group('SettingsBloc Initialization', () {
    test('initialState_noAction_shouldBeInitial', () {
      // assert
      expect(settingsBloc.state, const SettingsState.initial());
    });

    blocTest<SettingsBloc, SettingsState>(
      'started_initializationSucceeds_emitsLoadingAndLoadedAndLogsView',
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
        verify(() => mockTracker.logSettingsViewed()).called(1);
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
        verify(() => mockTracker.logSettingsViewed()).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'started_alreadyLoaded_emitsNothingForSilentRefreshAndDoesNotLogViewAgain',
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
        verifyNever(() => mockTracker.logSettingsViewed());
      },
    );
  });

  group('Notification Toggling', () {
    blocTest<SettingsBloc, SettingsState>(
      'toggledNotifications_enableSuccess_optimisticallyUpdatesAndLogs',
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
        verify(
          () => mockTracker.logNotificationsToggled(enabled: true),
        ).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'toggledNotifications_systemPermissionMissing_requestsPermissionPromptAndLogsDenial',
      seed: () => SettingsState.loaded(
        tSettingsData.copyWith(isSystemNotificationsEnabled: false),
      ),
      build: () {
        // arrange
        return settingsBloc;
      },
      act: (bloc) => bloc.add(const SettingsEvent.toggledNotifications(true)),
      expect: () => [
        SettingsState.loaded(
          tSettingsData.copyWith(
            isSystemNotificationsEnabled: false,
            isAppNotificationsEnabled: false,
            favoriteSector: 'Technology',
          ),
          shouldShowPermissionPrompt: true,
        ),
      ],
      verify: (_) {
        // assert
        verifyZeroInteractions(mockToggleNotificationsUseCase);
        verify(() => mockTracker.logNotificationsPermissionDenied()).called(1);
      },
    );
  });

  group('Permission Prompt', () {
    blocTest<SettingsBloc, SettingsState>(
      'permissionPromptProcessed_promptPending_clearsPromptFlag',
      seed: () =>
          SettingsState.loaded(tSettingsData, shouldShowPermissionPrompt: true),
      build: () => settingsBloc,
      act: (bloc) => bloc.add(const SettingsEvent.permissionPromptProcessed()),
      expect: () => [SettingsState.loaded(tSettingsData)],
    );

    blocTest<SettingsBloc, SettingsState>(
      'permissionPromptProcessed_notLoaded_emitsNothing',
      build: () => settingsBloc,
      act: (bloc) => bloc.add(const SettingsEvent.permissionPromptProcessed()),
      expect: () => [],
    );
  });

  group('Sign Out', () {
    blocTest<SettingsBloc, SettingsState>(
      'signedOut_success_emitsLoadingAndInitialAndLogs',
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
        verify(() => mockSignOutUseCase(SignOutMode.standard)).called(1);
        verify(() => mockTracker.logSignOutClicked(isGuest: false)).called(1);
        verify(() => mockTracker.logSignOutSuccess(isGuest: false)).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'signedOut_guestSuccess_logsGuestAccountType',
      build: () {
        // arrange
        when(
          () => mockSignOutUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      seed: () => SettingsState.loaded(tSettingsData.copyWith(isGuest: true)),
      act: (bloc) => bloc.add(const SettingsEvent.signedOut()),
      expect: () => [
        const SettingsState.loading(),
        const SettingsState.initial(),
      ],
      verify: (_) {
        // assert
        verify(
          () => mockSignOutUseCase(SignOutMode.deleteGuestAccount),
        ).called(1);
        verifyNever(() => mockSignOutUseCase(SignOutMode.standard));
        verify(() => mockTracker.logSignOutClicked(isGuest: true)).called(1);
        verify(() => mockTracker.logSignOutSuccess(isGuest: true)).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'signedOut_registeredSuccess_logsRegisteredAccountType',
      build: () {
        // arrange
        when(
          () => mockSignOutUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      seed: () => SettingsState.loaded(tSettingsData),
      act: (bloc) => bloc.add(const SettingsEvent.signedOut()),
      expect: () => [
        const SettingsState.loading(),
        const SettingsState.initial(),
      ],
      verify: (_) {
        // assert
        verify(() => mockSignOutUseCase(SignOutMode.standard)).called(1);
        verifyNever(() => mockSignOutUseCase(SignOutMode.deleteGuestAccount));
        verify(() => mockTracker.logSignOutClicked(isGuest: false)).called(1);
        verify(() => mockTracker.logSignOutSuccess(isGuest: false)).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'signedOut_useCaseFails_emitsLoadingAndFailureWithoutSuccessLog',
      build: () {
        // arrange
        when(() => mockSignOutUseCase(any())).thenAnswer(
          (_) async => const Left(Failure.server('Sign out failed')),
        );
        return settingsBloc;
      },
      seed: () => SettingsState.loaded(tSettingsData.copyWith(isGuest: true)),
      act: (bloc) => bloc.add(const SettingsEvent.signedOut()),
      expect: () => [
        const SettingsState.loading(),
        const SettingsState.failure(Failure.server('Sign out failed')),
      ],
      verify: (_) {
        // assert
        verify(() => mockTracker.logSignOutClicked(isGuest: true)).called(1);
        verifyNever(
          () => mockTracker.logSignOutSuccess(isGuest: any(named: 'isGuest')),
        );
      },
    );
  });

  group('Guest Logout Prompt', () {
    for (final choice in GuestLogoutChoice.values) {
      blocTest<SettingsBloc, SettingsState>(
        'guestLogoutPromptResolved_${choice.name}_logsChoiceWithoutStateChange',
        build: () => settingsBloc,
        act: (bloc) =>
            bloc.add(SettingsEvent.guestLogoutPromptResolved(choice)),
        expect: () => [],
        verify: (_) {
          // assert
          verify(
            () => mockTracker.logGuestLogoutChoice(choice: choice),
          ).called(1);
          verifyZeroInteractions(mockSignOutUseCase);
        },
      );
    }
  });

  group('Other Actions', () {
    blocTest<SettingsBloc, SettingsState>(
      'openUrl_validUrl_callsUseCaseAndLogs',
      build: () {
        // arrange
        when(
          () => mockLaunchUrlUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return settingsBloc;
      },
      act: (bloc) => bloc.add(
        const SettingsEvent.openUrl(
          'https://test.com',
          SettingsLinkType.privacyPolicy,
        ),
      ),
      expect: () => [],
      verify: (_) {
        // assert
        verify(() => mockLaunchUrlUseCase('https://test.com')).called(1);
        verify(
          () => mockTracker.logSettingsLinkClicked(
            type: SettingsLinkType.privacyPolicy,
          ),
        ).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'openedSettings_noAction_callsUseCaseAndLogs',
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
        verify(() => mockTracker.logSystemSettingsOpened()).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'editProfileClicked_logsEvent',
      build: () => settingsBloc,
      act: (bloc) => bloc.add(const SettingsEvent.editProfileClicked()),
      expect: () => [],
      verify: (_) {
        verify(() => mockTracker.logEditProfileClicked()).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'feedbackClicked_logsEvent',
      build: () => settingsBloc,
      act: (bloc) => bloc.add(const SettingsEvent.feedbackClicked()),
      expect: () => [],
      verify: (_) {
        verify(() => mockTracker.logFeedbackClicked()).called(1);
      },
    );

    blocTest<SettingsBloc, SettingsState>(
      'membershipClicked_logsEventWithStatus',
      build: () => settingsBloc,
      act: (bloc) => bloc.add(const SettingsEvent.membershipClicked(true)),
      expect: () => [],
      verify: (_) {
        verify(
          () => mockTracker.logMembershipClicked(isSubscribed: true),
        ).called(1);
      },
    );
  });
}
