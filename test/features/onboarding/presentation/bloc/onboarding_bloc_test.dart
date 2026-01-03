import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late OnboardingBloc bloc;
  late MockOnboardingRepository mockRepository;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(const OnboardingData());
  });

  setUp(() {
    mockRepository = MockOnboardingRepository();
    mockAuthRepository = MockAuthRepository();
    bloc = OnboardingBloc(mockRepository, mockAuthRepository);
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
          () => mockRepository.getSp500History(),
        ).thenAnswer((_) async => []);
        when(() => mockRepository.getSectors()).thenAnswer((_) async => []);
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
          () => mockRepository.getSp500History(),
        ).thenThrow(Exception('API Failure'));
        when(() => mockRepository.getSectors()).thenAnswer((_) async => []);
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
          failureMessage: 'Exception: User is not authenticated',
        ),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'completeOnboarding_repoThrows_emitsFailure',
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
          () => mockRepository.completeOnboarding(
            data: any(named: 'data'),
            uid: any(named: 'uid'),
          ),
        ).thenThrow(Exception('Repo Error'));
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
          failureMessage: 'Exception: Repo Error',
        ),
      ],
    );
  });
}
