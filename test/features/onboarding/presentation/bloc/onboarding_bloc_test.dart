import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/save_onboarding_progress_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/skip_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/save_onboarding_progress_result.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_result.dart';
import 'package:dartz/dartz.dart';

import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/persist_notification_grant_usecase.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_analytics.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';

import 'package:bizzie/core/usecase/usecase.dart';

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockGetAuthStreamUseCase extends Mock implements GetAuthStreamUseCase {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

class MockSkipOnboardingUseCase extends Mock implements SkipOnboardingUseCase {}

class MockSaveOnboardingProgressUseCase extends Mock
    implements SaveOnboardingProgressUseCase {}

class MockSignInAnonymouslyUseCase extends Mock
    implements SignInAnonymouslyUseCase {}

class MockPersistNotificationGrantUseCase extends Mock
    implements PersistNotificationGrantUseCase {}

class MockGetSectorsUseCase extends Mock implements GetSectorsUseCase {}

class MockGetSp500HistoryUseCase extends Mock
    implements GetSp500HistoryUseCase {}

class MockGetDailyBrandsUseCase extends Mock implements GetDailyBrandsUseCase {}

class MockSectorService extends Mock implements ISectorService {}

class MockOnboardingAnalytics extends Mock implements OnboardingAnalytics {}

class MockConfigService extends Mock implements IConfigService {}

class FakeNoParams extends Fake implements NoParams {}

class FakeOnboardingSessionSummary extends Fake
    implements OnboardingSessionSummary {}

final testTime = DateTime(2026, 1, 1);

const tFieldSources = OnboardingFieldSources(
  name: OnboardingValueSource.remoteDefault,
  sector: OnboardingValueSource.remoteDefault,
  companies: OnboardingValueSource.userSelection,
  experience: OnboardingValueSource.localDefault,
  notifications: OnboardingValueSource.remoteDefault,
);

const tSkipDestination = PostOnboardingDestination(
  ticker: 'TST',
  tickerSource: OnboardingValueSource.userSelection,
  shouldPromptNotifications: true,
);

const tSkipResult = SkipOnboardingResult.completed(
  destination: tSkipDestination,
  fieldSources: tFieldSources,
);

const tRegisteredUser = UserModel(
  id: '123',
  email: 'test@test.com',
  displayName: 'Test',
);

const tAnonymousUser = UserModel(id: 'anon', email: '', isAnonymous: true);

const tAppleBrand = Brand(
  name: 'iPhone',
  company: 'Apple',
  ticker: 'AAPL',
  description: '',
  sector: '',
);

const tNikeBrand = Brand(
  name: 'Air Max',
  company: 'Nike',
  ticker: 'NKE',
  description: '',
  sector: '',
);

void main() {
  late OnboardingBloc bloc;
  late MockGetCurrentUserUseCase mockGetCurrentUser;
  late MockGetAuthStreamUseCase mockGetAuthStream;
  late MockCompleteOnboardingUseCase mockCompleteOnboardingUseCase;
  late MockSkipOnboardingUseCase mockSkipOnboardingUseCase;
  late MockSaveOnboardingProgressUseCase mockSaveOnboardingProgressUseCase;
  late MockSignInAnonymouslyUseCase mockSignInAnonymously;
  late MockPersistNotificationGrantUseCase mockPersistNotificationGrantUseCase;

  late MockGetSectorsUseCase mockGetSectorsUseCase;
  late MockGetSp500HistoryUseCase mockGetSp500HistoryUseCase;
  late MockGetDailyBrandsUseCase mockGetDailyBrandsUseCase;
  late MockSectorService mockSectorService;
  late MockOnboardingAnalytics mockOnboardingAnalytics;
  late MockConfigService mockConfigService;

  setUpAll(() {
    getIt.allowReassignment = true;
    mockConfigService = MockConfigService();
    getIt.registerLazySingleton<IConfigService>(() => mockConfigService);

    registerFallbackValue(const OnboardingData());
    registerFallbackValue(
      const CompleteOnboardingParams(data: OnboardingData(), uid: ''),
    );
    registerFallbackValue(const SkipOnboardingParams(data: OnboardingData()));
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(OnboardingStep.landing);
    registerFallbackValue(Sector.energy);
    registerFallbackValue(InvestingExperience.beginner);
    registerFallbackValue(FakeOnboardingSessionSummary());
    registerFallbackValue(<Company>[]);
    registerFallbackValue(tFieldSources);
    registerFallbackValue(OnboardingValueSource.userSelection);
    registerFallbackValue(OnboardingSkipReason.userSkipped);
    registerFallbackValue(const GetDailyBrandsParams());
  });

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUserUseCase();
    mockGetAuthStream = MockGetAuthStreamUseCase();
    mockCompleteOnboardingUseCase = MockCompleteOnboardingUseCase();
    mockSkipOnboardingUseCase = MockSkipOnboardingUseCase();
    mockSaveOnboardingProgressUseCase = MockSaveOnboardingProgressUseCase();
    mockSignInAnonymously = MockSignInAnonymouslyUseCase();
    mockPersistNotificationGrantUseCase = MockPersistNotificationGrantUseCase();

    mockGetSectorsUseCase = MockGetSectorsUseCase();
    mockGetSp500HistoryUseCase = MockGetSp500HistoryUseCase();
    mockGetDailyBrandsUseCase = MockGetDailyBrandsUseCase();
    mockSectorService = MockSectorService();
    mockOnboardingAnalytics = MockOnboardingAnalytics();

    when(() => mockConfigService.sectorDescriptions).thenReturn({});
    when(() => mockConfigService.stockMarketSectors).thenReturn([]);

    when(
      () => mockOnboardingAnalytics.logStepViewed(
        step: any(named: 'step'),
        prevDurationSec: any(named: 'prevDurationSec'),
        selectedSector: any(named: 'selectedSector'),
        brandsSelectedCount: any(named: 'brandsSelectedCount'),
        experienceSelected: any(named: 'experienceSelected'),
        notificationsEnabled: any(named: 'notificationsEnabled'),
        didSubscribe: any(named: 'didSubscribe'),
        subscriptionType: any(named: 'subscriptionType'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.logCompletionFailed(
        errorMessage: any(named: 'errorMessage'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.logSessionSummary(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.logSignUp(method: any(named: 'method')),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.setUserProperties(
        experience: any(named: 'experience'),
        sector: any(named: 'sector'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.resetUserProperties(),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.logSkipped(
        step: any(named: 'step'),
        reason: any(named: 'reason'),
        sessionId: any(named: 'sessionId'),
        hadAccount: any(named: 'hadAccount'),
        brandsSelectedCount: any(named: 'brandsSelectedCount'),
        fieldSources: any(named: 'fieldSources'),
        notificationsDecided: any(named: 'notificationsDecided'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockOnboardingAnalytics.logInitialCompanyShown(
        ticker: any(named: 'ticker'),
        tickerSource: any(named: 'tickerSource'),
        isSkipped: any(named: 'isSkipped'),
        isGuest: any(named: 'isGuest'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockPersistNotificationGrantUseCase(any()),
    ).thenAnswer((_) async => const Right(false));
    when(
      () => mockGetSectorsUseCase(any()),
    ).thenAnswer((_) async => const Right([]));
    when(
      () => mockGetSp500HistoryUseCase(any()),
    ).thenAnswer((_) async => const Right([]));
    when(
      () => mockSectorService.getSectorDisplayName(any()),
    ).thenReturn('Mock Sector');
    when(
      () => mockSectorService.getSectorDescription(any()),
    ).thenReturn('Mock Description');

    bloc = OnboardingBloc(
      mockGetCurrentUser,
      mockGetAuthStream,
      mockCompleteOnboardingUseCase,
      mockSkipOnboardingUseCase,
      mockSaveOnboardingProgressUseCase,
      mockSignInAnonymously,
      mockPersistNotificationGrantUseCase,
      mockGetSectorsUseCase,
      mockGetSp500HistoryUseCase,
      mockGetDailyBrandsUseCase,
      mockSectorService,
      mockOnboardingAnalytics,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('OnboardingBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(bloc.state.onboardingData, const OnboardingData());
    });

    blocTest<OnboardingBloc, OnboardingState>(
      'started_success_emitsLoadingAndData',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        when(
          () => mockGetSectorsUseCase(any()),
        ).thenAnswer((_) async => const Right([Sector.financials]));
        when(
          () => mockSectorService.getSectorDisplayName(any()),
        ).thenReturn('Financials');
        when(
          () => mockSectorService.getSectorDescription(any()),
        ).thenReturn('Description');
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.started()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isLoadingSectors,
          'isLoadingSectors',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isLoadingSectors, 'isLoadingSectors', false)
            .having(
              (s) => s.availableSectors.length,
              'availableSectors length',
              1,
            )
            .having(
              (s) => s.availableSectors.first.sector,
              'first sector',
              Sector.financials,
            ),
        isA<OnboardingState>().having(
          (s) => s.isLoadingHistory,
          'isLoadingHistory',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
            .having((s) => s.sp500History, 'sp500History', []),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'sp500HistoryRequested_success_emitsLoadingAndData',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.sp500HistoryRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isLoadingHistory,
          'isLoadingHistory',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isLoadingHistory, 'isLoadingHistory', false)
            .having((s) => s.sp500History, 'sp500History', []),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'nameSubmitted_validName_updatesDataAndStep',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.nameSubmitted('New Name')),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.onboardingData.firstName,
          'firstName',
          'New Name',
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'sectorSelected_validSector_updatesData',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        availableSectors: [
          SectorViewModel(
            sector: Sector.financials,
            displayName: 'Financials',
            description: 'Desc',
          ),
        ],
      ),
      // act
      act: (bloc) {
        bloc.add(const OnboardingEvent.sectorSelected(Sector.financials));
      },
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.onboardingData.selectedSector,
              'selectedSector',
              Sector.financials,
            )
            .having(
              (s) => s.displaySectorName,
              'displaySectorName',
              'Financials',
            ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'experienceSelected_expert_updatesDataAndCalculatesHighlights',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(
        const OnboardingEvent.experienceSelected(InvestingExperience.expert),
      ),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.onboardingData.investingExperience,
              'experience',
              InvestingExperience.expert,
            )
            .having((s) => s.featureHighlights.length, 'highlights length', 3)
            .having(
              (s) => s.featureHighlights.first.type,
              'first highlight type',
              FeatureHighlightType.historicalData,
            ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'notificationsToggled_true_updatesData',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) =>
          bloc.add(const OnboardingEvent.notificationsToggled(enabled: true)),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.onboardingData.notificationsEnabled,
              'notificationsEnabled',
              true,
            )
            .having(
              (s) => s.onboardingData.hasDecidedNotifications,
              'hasDecidedNotifications',
              true,
            ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'notificationsToggled_false_marksNotificationsDecided',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) =>
          bloc.add(const OnboardingEvent.notificationsToggled(enabled: false)),
      // assert
      expect: () => [
        OnboardingState.initial(
          onboardingData: const OnboardingData(
            notificationsEnabled: false,
            hasDecidedNotifications: true,
          ),
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightPageChanged_validIndex_updatesIndex',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        featureHighlights: const [
          FeatureHighlightItem(
            title: 'T1',
            description: 'D1',
            type: FeatureHighlightType.historicalData,
          ),
          FeatureHighlightItem(
            title: 'T2',
            description: 'D2',
            type: FeatureHighlightType.visualFinancials,
          ),
          FeatureHighlightItem(
            title: 'T3',
            description: 'D3',
            type: FeatureHighlightType.brandSearch,
          ),
        ],
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.highlightPageChanged(2)),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.currentHighlightIndex,
          'currentHighlightIndex',
          2,
        ),
      ],
    );

    const tBrand = Brand(
      name: 'Test',
      company: 'Test Co',
      ticker: 'TST',
      description: 'Desc',
      sector: 'Tech',
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'brandToggled_brandNotSelected_addsBrand',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.brandToggled(tBrand)),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.onboardingData,
              'onboardingData',
              const OnboardingData(),
            )
            .having((s) => s.selectedBrands, 'selectedBrands', [tBrand]),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'brandToggled_brandSelected_removesBrand',
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        selectedBrands: [tBrand],
      ),
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.brandToggled(tBrand)),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.onboardingData,
              'onboardingData',
              const OnboardingData(),
            )
            .having((s) => s.selectedBrands, 'selectedBrands', []),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'sp500HistoryRequested_failure_emitsLoadingAndStops',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('API Failure')));

        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.sp500HistoryRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isLoadingHistory,
          'isLoadingHistory',
          true,
        ),
        isA<OnboardingState>().having(
          (s) => s.isLoadingHistory,
          'isLoadingHistory',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'brandsPrefetchRequested_success_callsUseCaseWithSelectedSectorAndEmitsNothing',
      // arrange
      build: () {
        when(() => mockGetDailyBrandsUseCase(any())).thenAnswer(
          (_) async =>
              const Right(BrandListing(globalBrands: [], sectorBrands: [])),
        );
        return bloc;
      },
      seed: () => const OnboardingState.initial(
        onboardingData: OnboardingData(selectedSector: Sector.energy),
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.brandsPrefetchRequested()),
      // assert
      expect: () => <OnboardingState>[],
      verify: (_) {
        verify(
          () => mockGetDailyBrandsUseCase(
            const GetDailyBrandsParams(sector: Sector.energy),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'brandsPrefetchRequested_failure_emitsNothing',
      // arrange
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('API Failure')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.brandsPrefetchRequested()),
      // assert
      expect: () => <OnboardingState>[],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completionRequested_userNotAuthenticated_emitsFailure',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(null);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.status, 'status failure', OnboardingStatus.failure)
            .having(
              (s) => s.failureMessage,
              'failureMessage',
              'User is not authenticated',
            ),
      ],
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logCompletionFailed(
            errorMessage: 'User is not authenticated',
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completionRequested_useCaseFailure_emitsFailure',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(
          const UserModel(
            id: '123',
            email: 'test@test.com',
            displayName: 'Test',
          ),
        );
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => Left(Failure.server('UseCase Error')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.status, 'status failure', OnboardingStatus.failure)
            .having((s) => s.failureMessage, 'failureMessage', 'UseCase Error'),
      ],
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logCompletionFailed(
            errorMessage: 'UseCase Error',
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completionRequested_success_emitsSuccess',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(
          const UserModel(
            id: '123',
            email: 'test@test.com',
            displayName: 'Test',
          ),
        );
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
        return bloc;
      },
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        didSubscribe: false,
        subscriptionType: 'none',
        onboardingData: const OnboardingData(
          investingExperience: InvestingExperience.beginner,
          selectedSector: Sector.informationTechnology,
        ),
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.status,
              'status success',
              OnboardingStatus.success,
            ),
      ],
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.setUserProperties(
            experience: any(named: 'experience'),
            sector: any(named: 'sector'),
          ),
        ).called(1);
        verify(
          () => mockOnboardingAnalytics.logSignUp(method: any(named: 'method')),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightContinuePressed_incrementsIndexOrNavigates',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(null);
        return bloc;
      },
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        featureHighlights: const [
          FeatureHighlightItem(
            title: 'T1',
            description: 'D1',
            type: FeatureHighlightType.historicalData,
          ),
          FeatureHighlightItem(
            title: 'T2',
            description: 'D2',
            type: FeatureHighlightType.visualFinancials,
          ),
        ],
        currentHighlightIndex: 0,
      ),
      // act
      act: (bloc) {
        bloc.add(const OnboardingEvent.highlightContinuePressed());
        bloc.add(const OnboardingEvent.highlightContinuePressed());
      },
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.currentHighlightIndex,
          'index becomes 1',
          1,
        ),
        // On the second press, it reaches the end and sees no user
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToCreateAccount,
          'nav to create account',
          true,
        ),
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToCreateAccount,
          'reset nav state',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_logsAnalyticsAndUpdatesDurationState',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        lastStep: OnboardingStep.landing,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.sectorSelection),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStepViewed(
            step: OnboardingStep.sectorSelection,
            prevDurationSec: any(named: 'prevDurationSec'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_brandsSelection_logsWithBrandCount',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        selectedBrands: const [tBrand],
        lastStep: OnboardingStep.brandsSelection,
        didSubscribe: false,
        subscriptionType: 'none',
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.companyProfile),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStepViewed(
            step: OnboardingStep.companyProfile,
            prevDurationSec: any(named: 'prevDurationSec'),
            brandsSelectedCount: 1,
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_withoutSession_startsSessionAndKeepsLastStep',
      build: () {
        when(
          () => mockGetSectorsUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const OnboardingEvent.stepViewed(OnboardingStep.landing)),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.sessionId, isNotEmpty);
        expect(bloc.state.lastStep, OnboardingStep.landing);
        verify(
          () => mockOnboardingAnalytics.logStepViewed(
            step: OnboardingStep.landing,
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_duplicateStep_logsNothingAndDoesNotEmit',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        lastStep: OnboardingStep.landing,
      ),
      act: (bloc) =>
          bloc.add(const OnboardingEvent.stepViewed(OnboardingStep.landing)),
      expect: () => [],
      verify: (_) {
        verifyNever(
          () => mockOnboardingAnalytics.logStepViewed(
            step: any(named: 'step'),
            prevDurationSec: any(named: 'prevDurationSec'),
            selectedSector: any(named: 'selectedSector'),
            brandsSelectedCount: any(named: 'brandsSelectedCount'),
            experienceSelected: any(named: 'experienceSelected'),
            notificationsEnabled: any(named: 'notificationsEnabled'),
            didSubscribe: any(named: 'didSubscribe'),
            subscriptionType: any(named: 'subscriptionType'),
          ),
        );
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_companyProfile_marksCompanyProfileViewed',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        lastStep: OnboardingStep.brandsSelection,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.companyProfile),
      ),
      expect: () => [
        isA<OnboardingState>()
            .having(
              (s) => s.lastStep,
              'lastStep',
              OnboardingStep.companyProfile,
            )
            .having(
              (s) => s.hasViewedCompanyProfile,
              'hasViewedCompanyProfile',
              true,
            ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_otherStep_doesNotMarkCompanyProfileViewed',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        lastStep: OnboardingStep.landing,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.sectorSelection),
      ),
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.hasViewedCompanyProfile,
          'hasViewedCompanyProfile',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_sectorSelection_logsWhenMovingToNextStep',
      build: () => bloc,
      seed: () => OnboardingState.initial(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(
          selectedSector: Sector.informationTechnology,
        ),
        lastStep: OnboardingStep.sectorSelection,
        didSubscribe: false,
        subscriptionType: 'none',
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.brandsSelection),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStepViewed(
            step: OnboardingStep.brandsSelection,
            prevDurationSec: any(named: 'prevDurationSec'),
            selectedSector: Sector.informationTechnology.name,
          ),
        ).called(1);
      },
    );
    group('buildingProfileStarted', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'buildingProfileStarted_userAuthenticated_completesWithoutAwaitingAuthStream',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.buildingProfileStarted()),
        // assert
        expect: () => [
          isA<OnboardingState>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<OnboardingState>().having(
            (s) => s.status,
            'status success',
            OnboardingStatus.success,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockGetAuthStream(any()));
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'buildingProfileStarted_userSignsInLater_completesAfterAuthentication',
        // arrange
        build: () {
          UserModel? currentUser;
          when(() => mockGetCurrentUser()).thenAnswer((_) => currentUser);
          when(() => mockGetAuthStream(any())).thenAnswer((_) async* {
            yield null;
            currentUser = tAnonymousUser;
            yield tAnonymousUser;
          });
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.buildingProfileStarted()),
        // assert
        expect: () => [
          isA<OnboardingState>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<OnboardingState>().having(
            (s) => s.status,
            'status success',
            OnboardingStatus.success,
          ),
        ],
        verify: (_) {
          verify(() => mockCompleteOnboardingUseCase(any())).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'buildingProfileStarted_authStreamEndsUnauthenticated_doesNotComplete',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(
            () => mockGetAuthStream(any()),
          ).thenAnswer((_) => Stream<UserModel?>.value(null));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.buildingProfileStarted()),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verifyNever(() => mockCompleteOnboardingUseCase(any()));
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'buildingProfileStarted_authStreamFails_doesNotComplete',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(() => mockGetAuthStream(any())).thenAnswer(
            (_) => Stream<UserModel?>.error(
              ServerException(message: 'Auth Error'),
            ),
          );
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.buildingProfileStarted()),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verifyNever(() => mockCompleteOnboardingUseCase(any()));
        },
      );
    });

    blocTest<OnboardingBloc, OnboardingState>(
      'completionRequested_anonymousUser_doesNotLogSignUp',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<OnboardingState>().having(
          (s) => s.status,
          'status success',
          OnboardingStatus.success,
        ),
      ],
      verify: (_) {
        verifyNever(
          () => mockOnboardingAnalytics.logSignUp(method: any(named: 'method')),
        );
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'skipRequested_existingUser_emitsInProgressThenOneShotDestination',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
        when(
          () => mockSkipOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(tSkipResult));
        return bloc;
      },
      seed: () => const OnboardingState.initial(
        onboardingData: OnboardingData(firstName: 'Ana'),
      ),
      // act
      act: (bloc) => bloc.add(
        const OnboardingEvent.skipRequested(OnboardingStep.sectorSelection),
      ),
      // assert
      expect: () => [
        const OnboardingState.initial(
          onboardingData: OnboardingData(firstName: 'Ana'),
          skipStatus: OnboardingSkipStatus.inProgress,
        ),
        const OnboardingState.initial(
          onboardingData: OnboardingData(firstName: 'Ana'),
          skipStatus: OnboardingSkipStatus.success,
          skippedAtStep: OnboardingStep.sectorSelection,
          skipFieldSources: tFieldSources,
          postOnboardingDestination: tSkipDestination,
        ),
        const OnboardingState.initial(
          onboardingData: OnboardingData(firstName: 'Ana'),
          skipStatus: OnboardingSkipStatus.success,
          skippedAtStep: OnboardingStep.sectorSelection,
          skipFieldSources: tFieldSources,
        ),
      ],
      verify: (_) {
        verify(
          () => mockSkipOnboardingUseCase(
            const SkipOnboardingParams(data: OnboardingData(firstName: 'Ana')),
          ),
        ).called(1);
        verifyNever(() => mockCompleteOnboardingUseCase(any()));
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'skipRequested_noUserWithSelectedBrands_passesBrandCompaniesToUseCase',
      // arrange
      build: () {
        when(() => mockGetCurrentUser()).thenReturn(null);
        when(
          () => mockSkipOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(tSkipResult));
        return bloc;
      },
      seed: () => const OnboardingState.initial(selectedBrands: [tBrand]),
      // act
      act: (bloc) => bloc.add(
        const OnboardingEvent.skipRequested(OnboardingStep.brandsSelection),
      ),
      // assert
      expect: () => [
        const OnboardingState.initial(
          selectedBrands: [tBrand],
          onboardingData: OnboardingData(
            detectedCompanies: [Company(ticker: 'TST', name: 'Test Co')],
          ),
          skipStatus: OnboardingSkipStatus.inProgress,
        ),
        const OnboardingState.initial(
          selectedBrands: [tBrand],
          onboardingData: OnboardingData(
            detectedCompanies: [Company(ticker: 'TST', name: 'Test Co')],
          ),
          skipStatus: OnboardingSkipStatus.success,
          skippedAtStep: OnboardingStep.brandsSelection,
          skipFieldSources: tFieldSources,
          postOnboardingDestination: tSkipDestination,
        ),
        const OnboardingState.initial(
          selectedBrands: [tBrand],
          onboardingData: OnboardingData(
            detectedCompanies: [Company(ticker: 'TST', name: 'Test Co')],
          ),
          skipStatus: OnboardingSkipStatus.success,
          skippedAtStep: OnboardingStep.brandsSelection,
          skipFieldSources: tFieldSources,
        ),
      ],
      verify: (_) {
        verify(
          () => mockSkipOnboardingUseCase(
            const SkipOnboardingParams(
              data: OnboardingData(
                detectedCompanies: [Company(ticker: 'TST', name: 'Test Co')],
              ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'skipRequested_useCaseFails_emitsSkipFailureWithMessage',
      // arrange
      build: () {
        when(
          () => mockSkipOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Skip failed')));
        return bloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const OnboardingEvent.skipRequested(OnboardingStep.askName)),
      // assert
      expect: () => [
        const OnboardingState.initial(
          skipStatus: OnboardingSkipStatus.inProgress,
        ),
        const OnboardingState.initial(
          skipStatus: OnboardingSkipStatus.failure,
          failureMessage: 'Skip failed',
        ),
      ],
    );

    group('skip analytics', () {
      final tSessionState = OnboardingState.initial(
        sessionId: 'session-1',
        sessionEntryTime: DateTime.now(),
        selectedBrands: const [tBrand],
        onboardingData: const OnboardingData(hasDecidedNotifications: true),
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_registeredUser_logsSkippedAndSkipSummaryOnce',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(tSkipResult));
          return bloc;
        },
        seed: () => tSessionState,
        // act
        act: (bloc) async {
          bloc.add(
            const OnboardingEvent.skipRequested(OnboardingStep.sectorSelection),
          );
          await Future<void>.delayed(Duration.zero);
          await bloc.close();
        },
        // assert
        verify: (_) {
          verify(
            () => mockOnboardingAnalytics.logSkipped(
              step: OnboardingStep.sectorSelection,
              reason: OnboardingSkipReason.userSkipped,
              sessionId: 'session-1',
              hadAccount: true,
              brandsSelectedCount: 1,
              fieldSources: tFieldSources,
              notificationsDecided: true,
            ),
          ).called(1);
          final summary =
              verify(
                    () =>
                        mockOnboardingAnalytics.logSessionSummary(captureAny()),
                  ).captured.single
                  as OnboardingSessionSummary;
          expect(summary.exitStep, 'skipped_sector_selection');
          expect(summary.didSkip, isTrue);
          expect(summary.didSignup, isTrue);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_noUserBeforeSkip_logsHadAccountFalseAndDidSignupFalse',
        // arrange
        build: () {
          var calls = 0;
          when(
            () => mockGetCurrentUser(),
          ).thenAnswer((_) => calls++ == 0 ? null : tAnonymousUser);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(tSkipResult));
          return bloc;
        },
        seed: () => tSessionState,
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(OnboardingStep.askName),
        ),
        // assert
        verify: (_) {
          verify(
            () => mockOnboardingAnalytics.logSkipped(
              step: OnboardingStep.askName,
              reason: OnboardingSkipReason.userSkipped,
              sessionId: 'session-1',
              hadAccount: false,
              brandsSelectedCount: 1,
              fieldSources: tFieldSources,
              notificationsDecided: true,
            ),
          ).called(1);
          final summary =
              verify(
                    () =>
                        mockOnboardingAnalytics.logSessionSummary(captureAny()),
                  ).captured.single
                  as OnboardingSessionSummary;
          expect(summary.exitStep, 'skipped_ask_name');
          expect(summary.didSignup, isFalse);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_purchaseAbort_logsSkippedWithPurchasedReason',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(tSkipResult));
          return bloc;
        },
        seed: () => tSessionState,
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(
            OnboardingStep.companyProfile,
            reason: OnboardingSkipReason.purchased,
          ),
        ),
        // assert
        verify: (_) {
          verify(
            () => mockOnboardingAnalytics.logSkipped(
              step: OnboardingStep.companyProfile,
              reason: OnboardingSkipReason.purchased,
              sessionId: 'session-1',
              hadAccount: true,
              brandsSelectedCount: 1,
              fieldSources: tFieldSources,
              notificationsDecided: true,
            ),
          ).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_useCaseFails_doesNotLogSkippedAndCloseLogsNonSkipSummary',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Left(Failure.server('Skip failed')));
          return bloc;
        },
        seed: () => tSessionState,
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(OnboardingStep.askName),
        ),
        // assert
        verify: (_) {
          verifyNever(
            () => mockOnboardingAnalytics.logSkipped(
              step: any(named: 'step'),
              reason: any(named: 'reason'),
              sessionId: any(named: 'sessionId'),
              hadAccount: any(named: 'hadAccount'),
              brandsSelectedCount: any(named: 'brandsSelectedCount'),
              fieldSources: any(named: 'fieldSources'),
              notificationsDecided: any(named: 'notificationsDecided'),
            ),
          );
          final summary =
              verify(
                    () =>
                        mockOnboardingAnalytics.logSessionSummary(captureAny()),
                  ).captured.single
                  as OnboardingSessionSummary;
          expect(summary.didSkip, isFalse);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'close_withoutSkipOrCompletion_logsSummaryWithDidSkipFalse',
        // arrange
        build: () => bloc,
        seed: () => tSessionState.copyWith(lastStep: OnboardingStep.askName),
        // act
        act: (_) {},
        // assert
        verify: (_) {
          final summary =
              verify(
                    () =>
                        mockOnboardingAnalytics.logSessionSummary(captureAny()),
                  ).captured.single
                  as OnboardingSessionSummary;
          expect(summary.exitStep, 'ask_name');
          expect(summary.didSkip, isFalse);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'initialCompanyShown_afterSkipAsGuest_logsSkippedExitType',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          skipStatus: OnboardingSkipStatus.success,
          skippedAtStep: OnboardingStep.askName,
        ),
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.initialCompanyShown(tSkipDestination),
        ),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verify(
            () => mockOnboardingAnalytics.logInitialCompanyShown(
              ticker: 'TST',
              tickerSource: OnboardingValueSource.userSelection,
              isSkipped: true,
              isGuest: true,
            ),
          ).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'initialCompanyShown_afterCompletion_logsCompletedExitType',
        // arrange
        build: () {
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          return bloc;
        },
        seed: () =>
            const OnboardingState.initial(status: OnboardingStatus.success),
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.initialCompanyShown(
            PostOnboardingDestination(
              ticker: 'AAPL',
              tickerSource: OnboardingValueSource.remoteDefault,
              shouldPromptNotifications: false,
            ),
          ),
        ),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verify(
            () => mockOnboardingAnalytics.logInitialCompanyShown(
              ticker: 'AAPL',
              tickerSource: OnboardingValueSource.remoteDefault,
              isSkipped: false,
              isGuest: false,
            ),
          ).called(1);
        },
      );
    });

    group('guestSessionRequested', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'guestSessionRequested_noCurrentUser_signsInAnonymously',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(
            () => mockSignInAnonymously(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.guestSessionRequested()),
        // assert
        expect: () => [],
        verify: (_) {
          verify(() => mockSignInAnonymously(any())).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'guestSessionRequested_userAlreadySignedIn_doesNotSignIn',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.guestSessionRequested()),
        // assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockSignInAnonymously(any()));
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'guestSessionRequested_signInFails_emitsNothing',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(
            () => mockSignInAnonymously(any()),
          ).thenAnswer((_) async => const Left(Failure.server('offline')));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.guestSessionRequested()),
        // assert
        expect: () => [],
      );
    });

    group('brandsConfirmed', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'brandsConfirmed_success_setsCompaniesSavesProgressAndRecordsProfileUid',
        build: () {
          // arrange
          when(() => mockSaveOnboardingProgressUseCase(any())).thenAnswer(
            (_) async =>
                const Right(SaveOnboardingProgressResult.saved(uid: 'anon')),
          );
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: OnboardingData(selectedSector: Sector.energy),
          selectedBrands: [tAppleBrand, tNikeBrand],
        ),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.brandsConfirmed()),
        // assert
        expect: () => [
          isA<OnboardingState>().having(
            (s) => s.onboardingData.detectedCompanies,
            'detectedCompanies',
            const [
              Company(ticker: 'AAPL', name: 'Apple'),
              Company(ticker: 'NKE', name: 'Nike'),
            ],
          ),
          isA<OnboardingState>().having(
            (s) => s.savedProfileUid,
            'savedProfileUid',
            'anon',
          ),
        ],
        verify: (_) {
          verify(
            () => mockSaveOnboardingProgressUseCase(
              const OnboardingData(
                selectedSector: Sector.energy,
                detectedCompanies: [
                  Company(ticker: 'AAPL', name: 'Apple'),
                  Company(ticker: 'NKE', name: 'Nike'),
                ],
              ),
            ),
          ).called(1);
          verify(() => mockPersistNotificationGrantUseCase(any())).called(1);
        },
      );

      test(
        'brandsConfirmed_saveSucceeds_recordsProfileUidBeforeGrantPersistCompletes',
        () async {
          // arrange
          final grantPersist = Completer<Either<Failure, bool>>();
          when(() => mockSaveOnboardingProgressUseCase(any())).thenAnswer(
            (_) async =>
                const Right(SaveOnboardingProgressResult.saved(uid: 'anon')),
          );
          when(
            () => mockPersistNotificationGrantUseCase(any()),
          ).thenAnswer((_) => grantPersist.future);

          // act
          bloc.add(const OnboardingEvent.brandsConfirmed());
          await bloc.stream.firstWhere((s) => s.savedProfileUid == 'anon');

          // assert
          expect(grantPersist.isCompleted, isFalse);
          verify(() => mockPersistNotificationGrantUseCase(any())).called(1);
          grantPersist.complete(const Right(true));
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'brandsConfirmed_profileAlreadyExists_recordsNoProfileUidAndSkipsGrantPersist',
        build: () {
          // arrange
          when(() => mockSaveOnboardingProgressUseCase(any())).thenAnswer(
            (_) async =>
                const Right(SaveOnboardingProgressResult.existingProfile()),
          );
          return bloc;
        },
        seed: () =>
            const OnboardingState.initial(selectedBrands: [tAppleBrand]),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.brandsConfirmed()),
        // assert
        expect: () => [
          isA<OnboardingState>().having(
            (s) => s.savedProfileUid,
            'savedProfileUid',
            isNull,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockPersistNotificationGrantUseCase(any()));
        },
      );

      test(
        'skipRequested_whileBrandsSaveInFlight_waitsAndSkipsWithExistingProfile',
        () async {
          // arrange
          final progressSave =
              Completer<Either<Failure, SaveOnboardingProgressResult>>();
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          when(
            () => mockSaveOnboardingProgressUseCase(any()),
          ).thenAnswer((_) => progressSave.future);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(tSkipResult));
          bloc.add(const OnboardingEvent.brandsConfirmed());
          await Future<void>.delayed(Duration.zero);

          // act
          bloc.add(
            const OnboardingEvent.skipRequested(OnboardingStep.companyProfile),
          );
          await Future<void>.delayed(Duration.zero);
          verifyNever(() => mockSkipOnboardingUseCase(any()));
          progressSave.complete(
            const Right(SaveOnboardingProgressResult.saved(uid: 'anon')),
          );
          await bloc.stream.firstWhere(
            (s) => s.skipStatus == OnboardingSkipStatus.success,
          );

          // assert
          final params =
              verify(
                    () => mockSkipOnboardingUseCase(captureAny()),
                  ).captured.single
                  as SkipOnboardingParams;
          expect(params.hasExistingProfile, isTrue);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'brandsConfirmed_saveFails_keepsSelectedCompaniesWithoutProfileUid',
        build: () {
          // arrange
          when(
            () => mockSaveOnboardingProgressUseCase(any()),
          ).thenAnswer((_) async => const Left(Failure.server('save failed')));
          return bloc;
        },
        seed: () =>
            const OnboardingState.initial(selectedBrands: [tAppleBrand]),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.brandsConfirmed()),
        // assert
        expect: () => [
          isA<OnboardingState>()
              .having(
                (s) => s.onboardingData.detectedCompanies,
                'detectedCompanies',
                const [Company(ticker: 'AAPL', name: 'Apple')],
              )
              .having((s) => s.savedProfileUid, 'savedProfileUid', isNull),
        ],
        verify: (_) {
          verifyNever(() => mockPersistNotificationGrantUseCase(any()));
        },
      );

      test(
        'brandsConfirmed_guestSignInInFlight_savesOnlyAfterSignInCompletes',
        () async {
          // arrange
          final signIn = Completer<Either<Failure, UserModel>>();
          when(() => mockGetCurrentUser()).thenReturn(null);
          when(
            () => mockSignInAnonymously(any()),
          ).thenAnswer((_) => signIn.future);
          when(() => mockSaveOnboardingProgressUseCase(any())).thenAnswer(
            (_) async =>
                const Right(SaveOnboardingProgressResult.saved(uid: 'anon')),
          );
          bloc.add(const OnboardingEvent.brandToggled(tAppleBrand));

          // act
          bloc.add(const OnboardingEvent.guestSessionRequested());
          bloc.add(const OnboardingEvent.brandsConfirmed());
          await Future<void>.delayed(Duration.zero);

          // assert
          verifyNever(() => mockSaveOnboardingProgressUseCase(any()));
          signIn.complete(const Right(tAnonymousUser));
          await Future<void>.delayed(Duration.zero);
          verify(() => mockSaveOnboardingProgressUseCase(any())).called(1);
        },
      );
    });

    group('saves after progress saved', () {
      const tSavedData = OnboardingData(
        firstName: 'Ana',
        selectedSector: Sector.energy,
        detectedCompanies: [
          Company(ticker: 'AAPL', name: 'Apple'),
          Company(ticker: 'NKE', name: 'Nike'),
        ],
        investingExperience: InvestingExperience.expert,
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'completionRequested_progressSavedForCurrentUser_completesExistingProfile',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: '123',
        ),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
        // assert
        expect: () => [
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: '123',
            isSubmitting: true,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: '123',
            status: OnboardingStatus.success,
          ),
        ],
        verify: (_) {
          verify(
            () => mockCompleteOnboardingUseCase(
              const CompleteOnboardingParams(
                data: tSavedData,
                uid: '123',
                hasExistingProfile: true,
              ),
            ),
          ).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'completionRequested_progressSavedForDifferentUser_createsProfile',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: 'anon',
        ),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
        // assert
        expect: () => [
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            isSubmitting: true,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            status: OnboardingStatus.success,
          ),
        ],
        verify: (_) {
          verify(
            () => mockCompleteOnboardingUseCase(
              const CompleteOnboardingParams(data: tSavedData, uid: '123'),
            ),
          ).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'completionRequested_accountAlreadyHasProfile_emitsExistingProfileWithoutSignUp',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(() => mockCompleteOnboardingUseCase(any())).thenAnswer(
            (_) async => const Right(OnboardingSaveOutcome.existingProfile),
          );
          return bloc;
        },
        seed: () => OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: 'anon',
          sessionId: 'session',
          sessionEntryTime: testTime,
        ),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
        // assert
        expect: () => [
          OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            sessionId: 'session',
            sessionEntryTime: testTime,
            isSubmitting: true,
          ),
          OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            sessionId: 'session',
            sessionEntryTime: testTime,
            status: OnboardingStatus.existingProfile,
          ),
        ],
        verify: (_) {
          verifyNever(
            () =>
                mockOnboardingAnalytics.logSignUp(method: any(named: 'method')),
          );
          verifyNever(
            () => mockOnboardingAnalytics.setUserProperties(
              experience: any(named: 'experience'),
              sector: any(named: 'sector'),
            ),
          );
          verify(
            () => mockOnboardingAnalytics.logSessionSummary(any()),
          ).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_accountAlreadyHasProfile_emitsExistingProfileWithoutDestination',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(() => mockSkipOnboardingUseCase(any())).thenAnswer(
            (_) async => const Right(SkipOnboardingResult.existingProfile()),
          );
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: 'anon',
        ),
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(OnboardingStep.createAccount),
        ),
        // assert
        expect: () => [
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            skipStatus: OnboardingSkipStatus.inProgress,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            skipStatus: OnboardingSkipStatus.existingProfile,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSkipOnboardingUseCase(
              const SkipOnboardingParams(data: tSavedData),
            ),
          ).called(1);
          verifyNever(
            () => mockOnboardingAnalytics.logSkipped(
              step: any(named: 'step'),
              reason: any(named: 'reason'),
              sessionId: any(named: 'sessionId'),
              hadAccount: any(named: 'hadAccount'),
              brandsSelectedCount: any(named: 'brandsSelectedCount'),
              fieldSources: any(named: 'fieldSources'),
              notificationsDecided: any(named: 'notificationsDecided'),
            ),
          );
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'completionRequested_existingProfileUpdateFails_emitsFailure',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
          when(() => mockCompleteOnboardingUseCase(any())).thenAnswer(
            (_) async => const Left(Failure.server('update failed')),
          );
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: '123',
        ),
        // act
        act: (bloc) => bloc.add(const OnboardingEvent.completionRequested()),
        // assert
        expect: () => [
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: '123',
            isSubmitting: true,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: '123',
            status: OnboardingStatus.failure,
            failureMessage: 'update failed',
          ),
        ],
      );

      test(
        'completionRequested_watchlistCompanyRemovedAfterBrandsSave_usesPartialUpdate',
        () async {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          when(() => mockSaveOnboardingProgressUseCase(any())).thenAnswer(
            (_) async =>
                const Right(SaveOnboardingProgressResult.saved(uid: 'anon')),
          );
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
          bloc
            ..add(const OnboardingEvent.brandToggled(tAppleBrand))
            ..add(const OnboardingEvent.brandToggled(tNikeBrand))
            ..add(const OnboardingEvent.brandsConfirmed());
          await bloc.stream.firstWhere((s) => s.savedProfileUid == 'anon');

          // act
          bloc.add(const OnboardingEvent.completionRequested());
          await bloc.stream.firstWhere(
            (s) => s.status == OnboardingStatus.success,
          );

          // assert
          final params =
              verify(
                    () => mockCompleteOnboardingUseCase(captureAny()),
                  ).captured.single
                  as CompleteOnboardingParams;
          expect(params.hasExistingProfile, isTrue);
          expect(params.uid, 'anon');
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_purchaseAbortAfterProgressSaved_skipsWithExistingProfile',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(tSkipResult));
          return bloc;
        },
        seed: () => const OnboardingState.initial(
          onboardingData: tSavedData,
          savedProfileUid: 'anon',
        ),
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(OnboardingStep.companyProfile),
        ),
        // assert
        expect: () => [
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            skipStatus: OnboardingSkipStatus.inProgress,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            skipStatus: OnboardingSkipStatus.success,
            skippedAtStep: OnboardingStep.companyProfile,
            skipFieldSources: tFieldSources,
            postOnboardingDestination: tSkipDestination,
          ),
          const OnboardingState.initial(
            onboardingData: tSavedData,
            savedProfileUid: 'anon',
            skipStatus: OnboardingSkipStatus.success,
            skippedAtStep: OnboardingStep.companyProfile,
            skipFieldSources: tFieldSources,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSkipOnboardingUseCase(
              const SkipOnboardingParams(
                data: tSavedData,
                hasExistingProfile: true,
              ),
            ),
          ).called(1);
          verifyNever(() => mockCompleteOnboardingUseCase(any()));
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'skipRequested_noProgressSaved_skipsWithoutExistingProfile',
        build: () {
          // arrange
          when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
          when(
            () => mockSkipOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Left(Failure.server('Skip failed')));
          return bloc;
        },
        // act
        act: (bloc) => bloc.add(
          const OnboardingEvent.skipRequested(OnboardingStep.sectorSelection),
        ),
        // assert
        expect: () => [
          const OnboardingState.initial(
            skipStatus: OnboardingSkipStatus.inProgress,
          ),
          const OnboardingState.initial(
            skipStatus: OnboardingSkipStatus.failure,
            failureMessage: 'Skip failed',
          ),
        ],
        verify: (_) {
          verify(
            () => mockSkipOnboardingUseCase(
              const SkipOnboardingParams(data: OnboardingData()),
            ),
          ).called(1);
        },
      );
    });

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightContinuePressed_guestUserOnLastPage_navigatesToCreateAccount',
      build: () {
        // arrange
        when(() => mockGetCurrentUser()).thenReturn(tAnonymousUser);
        return bloc;
      },
      seed: () => const OnboardingState.initial(
        featureHighlights: [
          FeatureHighlightItem(
            title: 'T1',
            description: 'D1',
            type: FeatureHighlightType.historicalData,
          ),
        ],
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.highlightContinuePressed()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToCreateAccount,
          'nav to create account',
          true,
        ),
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToCreateAccount,
          'reset nav state',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightContinuePressed_registeredUserOnLastPage_navigatesToBuildingProfile',
      build: () {
        // arrange
        when(() => mockGetCurrentUser()).thenReturn(tRegisteredUser);
        return bloc;
      },
      seed: () => const OnboardingState.initial(
        featureHighlights: [
          FeatureHighlightItem(
            title: 'T1',
            description: 'D1',
            type: FeatureHighlightType.historicalData,
          ),
        ],
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.highlightContinuePressed()),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToBuildingProfile,
          'nav to building profile',
          true,
        ),
        isA<OnboardingState>().having(
          (s) => s.shouldNavigateToBuildingProfile,
          'reset nav state',
          false,
        ),
      ],
    );

    group('notificationGrantPersistRequested', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'notificationGrantPersistRequested_useCaseSucceeds_invokesUseCaseAndEmitsNothing',
        // arrange
        build: () {
          when(
            () => mockPersistNotificationGrantUseCase(any()),
          ).thenAnswer((_) async => const Right(true));
          return bloc;
        },
        // act
        act: (bloc) =>
            bloc.add(const OnboardingEvent.notificationGrantPersistRequested()),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verify(() => mockPersistNotificationGrantUseCase(any())).called(1);
        },
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'notificationGrantPersistRequested_useCaseFails_emitsNothing',
        // arrange
        build: () {
          when(
            () => mockPersistNotificationGrantUseCase(any()),
          ).thenAnswer((_) async => const Left(Failure.server('error')));
          return bloc;
        },
        // act
        act: (bloc) =>
            bloc.add(const OnboardingEvent.notificationGrantPersistRequested()),
        // assert
        expect: () => <OnboardingState>[],
        verify: (_) {
          verify(() => mockPersistNotificationGrantUseCase(any())).called(1);
        },
      );
    });
  });
}
