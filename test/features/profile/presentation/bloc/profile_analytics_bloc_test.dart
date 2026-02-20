import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/profile/domain/usecases/get_profile_display_data_usecase.dart';
import 'package:bizzie/features/profile/presentation/analytics/profile_tracker.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProfileDisplayDataUseCase extends Mock
    implements GetProfileDisplayDataUseCase {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockAnalyticsContext extends Mock implements AnalyticsContext {}

class MockProfileTracker extends Mock implements ProfileTracker {}

void main() {
  late MockGetProfileDisplayDataUseCase mockGetProfileDisplayDataUseCase;
  late MockUserRepository mockUserRepository;
  late MockProfileTracker mockTracker;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      ProfileDisplayData(
        displayName: '',
        sectorName: '',
        sectorDescription: '',
        joinedDate: DateTime.now(),
        sectorPe: null,
        sectorAverageChange: null,
        marketDataDate: null,
      ),
    );
  });

  setUp(() {
    mockTracker = MockProfileTracker();
    mockGetProfileDisplayDataUseCase = MockGetProfileDisplayDataUseCase();
    mockUserRepository = MockUserRepository();

    when(
      () => mockUserRepository.userStream,
    ).thenAnswer((_) => const Stream.empty());

    when(() => mockTracker.logProfileLoaded(any())).thenAnswer((_) async {});
    when(() => mockTracker.logProfileViewed()).thenAnswer((_) async {});
    when(() => mockTracker.logProfileLoadSuccess()).thenAnswer((_) async {});
    when(() => mockTracker.logSettingsClicked()).thenAnswer((_) async {});
    when(() => mockTracker.logPremiumCardClicked()).thenAnswer((_) async {});
    when(
      () => mockTracker.logProfileLoadFailure(
        type: any(named: 'type'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async {});
  });

  ProfileBloc buildBloc() => ProfileBloc(
    mockGetProfileDisplayDataUseCase,
    mockUserRepository,
    mockTracker,
  );

  group('ProfileBloc', () {
    test('initialState_is_correct', () {
      expect(buildBloc().state, const ProfileState.initial());
    });

    final tProfileData = ProfileDisplayData(
      displayName: 'Test User',
      sectorName: 'Technology',
      sectorDescription: 'Description',
      joinedDate: DateTime.now(),
      sectorPe: null,
      sectorAverageChange: null,
      marketDataDate: null,
    );

    blocTest<ProfileBloc, ProfileState>(
      'givenUseCaseSucceeds_whenStartedAdded_thenEmitLoadingThenLoadedAndLogViewAndSuccess',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => [
        const ProfileState.loading(),
        ProfileState.loaded(tProfileData),
      ],
      verify: (_) {
        verify(() => mockTracker.logProfileViewed()).called(1);
        verify(() => mockTracker.logProfileLoaded(tProfileData)).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'givenAlreadyLoaded_whenStartedAdded_thenRefreshesButDoesNotLogViewAgain',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      seed: () => ProfileState.loaded(tProfileData),
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => [
        const ProfileState.loading(),
        ProfileState.loaded(tProfileData),
      ],
      verify: (_) {
        // Should NOT log view again if already loaded/loading
        verifyNever(() => mockTracker.logProfileViewed());
        verify(() => mockTracker.logProfileLoaded(tProfileData)).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'givenUseCaseFails_whenStartedAdded_thenEmitLoadingThenFailureAndLogFailure',
      build: () {
        when(() => mockGetProfileDisplayDataUseCase(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Failed fetching data')),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.failure(ServerFailure('Failed fetching data')),
      ],
      verify: (_) {
        verify(() => mockTracker.logProfileViewed()).called(1);
        verify(
          () => mockTracker.logProfileLoadFailure(
            type: any(named: 'type'),
            message: any(named: 'message'),
          ),
        ).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'whenSettingsClicked_thenEmitLoadedWithSettingsMarkerAndLogAnalytics',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      seed: () => ProfileState.loaded(tProfileData),
      act: (bloc) => bloc.add(const ProfileEvent.settingsClicked()),
      expect: () => [
        ProfileState.loaded(tProfileData, shouldNavigateToSettings: true),
      ],
      verify: (_) {
        verify(() => mockTracker.logSettingsClicked()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'whenPremiumCardClicked_thenEmitLoadedWithPaywallMarkerAndLogAnalytics',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      seed: () => ProfileState.loaded(tProfileData),
      act: (bloc) => bloc.add(const ProfileEvent.premiumCardClicked()),
      expect: () => [
        ProfileState.loaded(tProfileData, shouldShowPaywall: true),
      ],
      verify: (_) {
        verify(() => mockTracker.logPremiumCardClicked()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'whenNavigationProcessed_thenResetMarkers',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      seed: () => ProfileState.loaded(
        tProfileData,
        shouldNavigateToSettings: true,
        shouldShowPaywall: true,
      ),
      act: (bloc) => bloc.add(const ProfileEvent.navigationProcessed()),
      expect: () => [
        ProfileState.loaded(
          tProfileData,
          shouldNavigateToSettings: false,
          shouldShowPaywall: false,
        ),
      ],
    );
  });
}
