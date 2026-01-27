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
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

class MockGetSectorsUseCase extends Mock implements GetSectorsUseCase {}

class MockGetSp500HistoryUseCase extends Mock
    implements GetSp500HistoryUseCase {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late OnboardingBloc bloc;
  late MockAuthRepository mockAuthRepository;
  late MockCompleteOnboardingUseCase mockCompleteOnboardingUseCase;

  late MockGetSectorsUseCase mockGetSectorsUseCase;
  late MockGetSp500HistoryUseCase mockGetSp500HistoryUseCase;

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

    bloc = OnboardingBloc(
      mockAuthRepository,
      mockCompleteOnboardingUseCase,
      mockGetSectorsUseCase,
      mockGetSp500HistoryUseCase,
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
      'loadSp500History_success_emitsLoadingAndData',
      // arrange
      build: () {
        when(
          () => mockGetSp500HistoryUseCase(any()),
        ).thenAnswer((_) async => const Right([]));
        when(
          () => mockGetSectorsUseCase(any()),
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
  });
}
