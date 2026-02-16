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
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

class MockGetSectorsUseCase extends Mock implements GetSectorsUseCase {}

class MockGetSp500HistoryUseCase extends Mock
    implements GetSp500HistoryUseCase {}

class MockSectorService extends Mock implements ISectorService {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late OnboardingBloc bloc;
  late MockAuthRepository mockAuthRepository;
  late MockCompleteOnboardingUseCase mockCompleteOnboardingUseCase;

  late MockGetSectorsUseCase mockGetSectorsUseCase;
  late MockGetSp500HistoryUseCase mockGetSp500HistoryUseCase;
  late MockSectorService mockSectorService;

  setUpAll(() {
    registerFallbackValue(const OnboardingData());
    registerFallbackValue(
      const CompleteOnboardingParams(data: OnboardingData(), uid: ''),
    );
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockCompleteOnboardingUseCase = MockCompleteOnboardingUseCase();

    mockGetSectorsUseCase = MockGetSectorsUseCase();
    mockGetSp500HistoryUseCase = MockGetSp500HistoryUseCase();
    mockSectorService = MockSectorService();

    bloc = OnboardingBloc(
      mockAuthRepository,
      mockCompleteOnboardingUseCase,
      mockGetSectorsUseCase,
      mockGetSp500HistoryUseCase,
      mockSectorService,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('OnboardingBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(
        bloc.state,
        const OnboardingState(onboardingData: OnboardingData()),
      );
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
        const OnboardingState(
          onboardingData: OnboardingData(),
          isLoadingHistory: true,
        ),
        const OnboardingState(
          onboardingData: OnboardingData(),
          isLoadingHistory: false,
          sp500History: [],
        ),
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
        const OnboardingState(
          onboardingData: OnboardingData(firstName: 'New Name'),
          currentStep: 2,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'sectorSelected_validSector_updatesData',
      // arrange
      build: () => bloc,
      seed: () => OnboardingState(
        onboardingData: const OnboardingData(),
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
        const OnboardingState(
          onboardingData: OnboardingData(notificationsEnabled: true),
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'highlightPageChanged_validIndex_updatesIndex',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.highlightPageChanged(2)),
      // assert
      expect: () => [
        const OnboardingState(
          onboardingData: OnboardingData(),
          currentHighlightIndex: 2,
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
        const OnboardingState(
          onboardingData: OnboardingData(),
          selectedBrands: [tBrand],
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'toggleBrand_brandSelected_removesBrand',
      seed: () => const OnboardingState(
        onboardingData: OnboardingData(),
        selectedBrands: [tBrand],
      ),
      // arrange
      build: () => bloc,
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.toggleBrand(tBrand)),
      // assert
      expect: () => [
        const OnboardingState(
          onboardingData: OnboardingData(),
          selectedBrands: [],
        ),
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
        const OnboardingState(
          onboardingData: OnboardingData(),
          isLoadingHistory: true,
        ),
        const OnboardingState(
          onboardingData: OnboardingData(),
          isLoadingHistory: false,
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
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: true,
        ),
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: false,
          status: OnboardingStatus.failure,
          failureMessage: 'User is not authenticated',
        ),
      ],
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
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: true,
        ),
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: false,
          status: OnboardingStatus.failure,
          failureMessage: 'UseCase Error',
        ),
      ],
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
      // act
      act: (bloc) => bloc.add(const OnboardingEvent.completeOnboarding()),
      // assert
      expect: () => [
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: true,
        ),
        const OnboardingState(
          onboardingData: OnboardingData(),
          isSubmitting: false,
          status: OnboardingStatus.success,
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'startAnalysis_progressesThroughSteps',
      // arrange
      build: () => bloc,
      seed: () => const OnboardingState(
        onboardingData: OnboardingData(),
        selectedBrands: [
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
        onboardingData: const OnboardingData().copyWith(
          detectedCompanies: [
            const Company(ticker: 'AAPL', name: 'Apple'),
            const Company(ticker: 'MSFT', name: 'Microsoft'),
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
      seed: () => const OnboardingState(
        onboardingData: OnboardingData(),
        featureHighlights: [
          FeatureHighlightItem(
            title: 'T1',
            description: 'D1',
            type: FeatureHighlightType.historicalData,
          ),
          FeatureHighlightItem(
            title: 'T2',
            description: 'D2',
            type: FeatureHighlightType.dailyPicks,
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
        // Note: completeOnboarding is also triggered, which adds isSubmitting: true etc.
        // But since it's added as an event, those states will follow.
        isA<OnboardingState>().having(
          (s) => s.isSubmitting,
          'isSubmitting',
          true,
        ),
        isA<OnboardingState>()
            .having((s) => s.status, 'status success', OnboardingStatus.success)
            .having((s) => s.isSubmitting, 'not submitting', false),
      ],
    );
  });
}
