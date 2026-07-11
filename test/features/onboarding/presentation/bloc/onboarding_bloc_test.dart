import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
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

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

class MockGetSectorsUseCase extends Mock implements GetSectorsUseCase {}

class MockGetSp500HistoryUseCase extends Mock
    implements GetSp500HistoryUseCase {}

class MockSectorService extends Mock implements ISectorService {}

class MockOnboardingAnalytics extends Mock implements OnboardingAnalytics {}

class MockConfigService extends Mock implements IConfigService {}

class FakeNoParams extends Fake implements NoParams {}

class FakeOnboardingSessionSummary extends Fake
    implements OnboardingSessionSummary {}

final testTime = DateTime(2026, 1, 1);

void main() {
  late OnboardingBloc bloc;
  late MockAuthRepository mockAuthRepository;
  late MockCompleteOnboardingUseCase mockCompleteOnboardingUseCase;

  late MockGetSectorsUseCase mockGetSectorsUseCase;
  late MockGetSp500HistoryUseCase mockGetSp500HistoryUseCase;
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
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(OnboardingStep.landing);
    registerFallbackValue(Sector.energy);
    registerFallbackValue(InvestingExperience.beginner);
    registerFallbackValue(FakeOnboardingSessionSummary());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockCompleteOnboardingUseCase = MockCompleteOnboardingUseCase();

    mockGetSectorsUseCase = MockGetSectorsUseCase();
    mockGetSp500HistoryUseCase = MockGetSp500HistoryUseCase();
    mockSectorService = MockSectorService();
    mockOnboardingAnalytics = MockOnboardingAnalytics();

    when(() => mockConfigService.sectorDescriptions).thenReturn({});
    when(() => mockConfigService.stockMarketSectors).thenReturn([]);

    when(
      () => mockOnboardingAnalytics.logStep(
        stepName: any(named: 'stepName'),
        durationSec: any(named: 'durationSec'),
        extraParams: any(named: 'extraParams'),
      ),
    ).thenReturn(null);
    when(
      () => mockOnboardingAnalytics.logSessionSummary(any()),
    ).thenReturn(null);
    when(
      () => mockOnboardingAnalytics.logSignUp(method: any(named: 'method')),
    ).thenReturn(null);
    when(
      () => mockOnboardingAnalytics.setUserProperties(
        experience: any(named: 'experience'),
        sector: any(named: 'sector'),
      ),
    ).thenReturn(null);
    when(() => mockOnboardingAnalytics.resetUserProperties()).thenReturn(null);
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
      mockAuthRepository,
      mockCompleteOnboardingUseCase,
      mockGetSectorsUseCase,
      mockGetSp500HistoryUseCase,
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
      'loadSp500History_success_emitsLoadingAndData',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.loadSp500History()),
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
        isA<OnboardingState>()
            .having((s) => s.onboardingData.firstName, 'firstName', 'New Name')
            .having((s) => s.currentStep, 'currentStep', 2),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'sectorSelected_validSector_updatesData',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
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
      act: (bloc) => bloc.add(const OnboardingEvent.notificationsToggled(true)),
      // assert
      expect: () => [
        isA<OnboardingState>().having(
          (s) => s.onboardingData.notificationsEnabled,
          'notificationsEnabled',
          true,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightPageChanged_validIndex_updatesIndex',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
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
      'toggleBrand_brandNotSelected_addsBrand',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.toggleBrand(tBrand)),
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
      'toggleBrand_brandSelected_removesBrand',
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        selectedBrands: [tBrand],
      ),
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.toggleBrand(tBrand)),
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
      'loadSp500History_failure_emitsLoadingAndStops',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('API Failure')));

        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.loadSp500History()),
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
      'completeOnboarding_userNotAuthenticated_emitsFailure',
      // arrange
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(null);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completeOnboarding()),
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
          () => mockOnboardingAnalytics.logStep(
            stepName: 'complete_onboarding',
            errorMessage: 'User is not authenticated',
            durationSec: any(named: 'durationSec'),
            extraParams: any(named: 'extraParams'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completeOnboarding_useCaseFailure_emitsFailure',
      // arrange
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(
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
      act: (bloc) => bloc.add(const OnboardingEvent.completeOnboarding()),
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
          () => mockOnboardingAnalytics.logStep(
            stepName: 'complete_onboarding',
            errorMessage: 'UseCase Error',
            durationSec: any(named: 'durationSec'),
            extraParams: any(named: 'extraParams'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completeOnboarding_success_emitsSuccess',
      // arrange
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(
          const UserModel(
            id: '123',
            email: 'test@test.com',
            displayName: 'Test',
          ),
        );
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        onboardingData: const OnboardingData(
          investingExperience: InvestingExperience.beginner,
          selectedSector: Sector.informationTechnology,
        ),
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completeOnboarding()),
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
      'startAnalysis_progressesThroughSteps',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        selectedBrands: const [
          Brand(
            name: 'Apple',
            company: 'Apple',
            ticker: 'AAPL',
            description: '',
            sector: '',
          ),
        ],
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.startAnalysis()),
      // wait for all Delayed and internal events
      wait: const Duration(milliseconds: 3500),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having((s) => s.isAnalyzingBrands, 'isAnalyzingBrands', true)
            .having((s) => s.analysisStep, 'step 0', 0),
        isA<OnboardingState>().having((s) => s.analysisStep, 'step 1', 1),
        isA<OnboardingState>().having((s) => s.analysisStep, 'step 2', 2),
        isA<OnboardingState>().having((s) => s.analysisStep, 'step 3', 3),
        isA<OnboardingState>().having(
          (s) => s.isAnalyzingBrands,
          'isAnalyzingBrands',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'startWatchlistAddition_progressesThroughCompanies',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        onboardingData: const OnboardingData().copyWith(
          detectedCompanies: const [
            Company(ticker: 'AAPL', name: 'Apple'),
            Company(ticker: 'MSFT', name: 'Microsoft'),
          ],
        ),
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.startWatchlistAddition()),
      wait: const Duration(milliseconds: 4000),
      // assert
      expect: () => [
        isA<OnboardingState>()
            .having((s) => s.isAnalyzingBrands, 'isAnalyzingBrands', true)
            .having((s) => s.watchlistStep, 'step 0', 0),
        isA<OnboardingState>().having((s) => s.watchlistStep, 'step 1', 1),
        isA<OnboardingState>().having((s) => s.watchlistStep, 'step 2', 2),
        isA<OnboardingState>().having(
          (s) => s.isAnalyzingBrands,
          'isAnalyzingBrands',
          false,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightContinuePressed_incrementsIndexOrNavigates',
      // arrange
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(null);
        return bloc;
      },
      seed: () => OnboardingState(
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
      'highlightSkipPressed_navigatesToBuildingProfileIfUserExists',
      // arrange
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(
          const UserModel(
            id: '123',
            email: 'test@test.com',
            displayName: 'Test',
          ),
        );
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        onboardingData: const OnboardingData(
          investingExperience: InvestingExperience.beginner,
          selectedSector: Sector.informationTechnology,
        ),
      ),
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.highlightSkipPressed()),
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
    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_logsAnalyticsAndUpdatesDurationState',
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
        lastStep: OnboardingStep.landing,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.sectorSelection),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStep(
            stepName: OnboardingStep.landing.name,
            durationSec: any(named: 'durationSec'),
            extraParams: any(named: 'extraParams'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_brandsSelection_logsWithBrandCount',
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        selectedBrands: const [tBrand],
        lastStep: OnboardingStep.brandsSelection,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(
          OnboardingStep.analyzingSelectedBrands,
        ),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStep(
            stepName: OnboardingStep.brandsSelection.name,
            durationSec: any(named: 'durationSec'),
            extraParams: any(
              named: 'extraParams',
              that: isA<Map<String, Object>>().having(
                (m) => m['brands_selected_count'],
                'brands_selected_count',
                1,
              ),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'profileReadyContinuePressed_logsAnalyticsAndDuration',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const OnboardingEvent.profileReadyContinuePressed()),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStep(
            stepName: OnboardingStep.profileReady.name,
            durationSec: any(named: 'durationSec'),
            extraParams: any(named: 'extraParams'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'landingPageViewed_dispatchesStepViewed',
      build: () => bloc,
      act: (bloc) => bloc.add(const OnboardingEvent.landingPageViewed()),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verifyNever(
          () => mockOnboardingAnalytics.logStep(
            stepName: any(named: 'stepName'),
            durationSec: any(named: 'durationSec'),
          ),
        );
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_duplicateStep_logsNothingAndDoesNotEmit',
      build: () => bloc,
      seed: () => OnboardingState(
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
          () => mockOnboardingAnalytics.logStep(
            stepName: any(named: 'stepName'),
            durationSec: any(named: 'durationSec'),
          ),
        );
        verifyNever(
          () =>
              mockOnboardingAnalytics.logStep(stepName: any(named: 'stepName')),
        );
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_analyzingSelectedBrands_logsWhenMovingToNextStep',
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(),
        lastStep: OnboardingStep.analyzingSelectedBrands,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.companiesFound),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStep(
            stepName: OnboardingStep.analyzingSelectedBrands.name,
            durationSec: any(named: 'durationSec'),
            extraParams: any(named: 'extraParams'),
          ),
        ).called(1);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'stepViewed_sectorSelection_logsWhenMovingToNextStep',
      build: () => bloc,
      seed: () => OnboardingState(
        sessionId: 'test_id',
        sessionEntryTime: testTime,
        onboardingData: const OnboardingData(
          selectedSector: Sector.informationTechnology,
        ),
        lastStep: OnboardingStep.sectorSelection,
        didSubscribe: false,
        subscriptionType: 'none',
        highlightsSkipped: false,
      ),
      act: (bloc) => bloc.add(
        const OnboardingEvent.stepViewed(OnboardingStep.meetYourBizzie),
      ),
      verify: (_) {
        verify(
          () => mockOnboardingAnalytics.logStep(
            stepName: OnboardingStep.sectorSelection.name,
            durationSec: any(named: 'durationSec'),
            extraParams: any(
              named: 'extraParams',
              that: isA<Map<String, Object>>().having(
                (m) => m['selected_sector'],
                'selected_sector',
                Sector.informationTechnology.name,
              ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
