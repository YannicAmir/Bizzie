import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_result.dart';
import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:bizzie/features/onboarding/domain/services/initial_company_resolver.dart';
import 'package:bizzie/features/onboarding/domain/services/skipped_onboarding_data_resolver.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/skip_onboarding_usecase.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResolveOnboardingUserUseCase extends Mock
    implements ResolveOnboardingUserUseCase {}

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

class MockGuestUsernameGenerator extends Mock
    implements GuestUsernameGenerator {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

const tGuestName = 'userabc123xyz0';
const tExistingUser = UserModel(id: 'existing-uid', email: 'jane@test.com');
const tAnonymousUser = UserModel(id: 'anon-uid', email: '', isAnonymous: true);
const tFailure = Failure.server('Test Failure');
const tDefaults = OnboardingSkipDefaults(
  defaultWatchlist: [Company(ticker: 'AAPL', name: 'Apple')],
  defaultSector: Sector.informationTechnology,
  initialCompanyTicker: 'AAPL',
);
const tEmptyData = OnboardingData();
const tResolvedEmptyData = OnboardingData(
  firstName: tGuestName,
  selectedSector: Sector.informationTechnology,
  detectedCompanies: [Company(ticker: 'AAPL', name: 'Apple')],
  investingExperience: InvestingExperience.beginner,
);
const tDefaultResult = SkipOnboardingResult.completed(
  destination: PostOnboardingDestination(
    ticker: 'AAPL',
    tickerSource: OnboardingValueSource.remoteDefault,
    shouldPromptNotifications: true,
  ),
  fieldSources: OnboardingFieldSources(
    name: OnboardingValueSource.localDefault,
    sector: OnboardingValueSource.remoteDefault,
    companies: OnboardingValueSource.remoteDefault,
    experience: OnboardingValueSource.localDefault,
    notifications: OnboardingValueSource.localDefault,
  ),
);

void main() {
  late SkipOnboardingUseCase sut;
  late MockResolveOnboardingUserUseCase mockResolveOnboardingUserUseCase;
  late MockOnboardingRepository mockOnboardingRepository;
  late MockGuestUsernameGenerator mockUsernameGenerator;
  late MockCompleteOnboardingUseCase mockCompleteOnboardingUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const CompleteOnboardingParams(data: OnboardingData(), uid: ''),
    );
  });

  setUp(() {
    mockResolveOnboardingUserUseCase = MockResolveOnboardingUserUseCase();
    mockOnboardingRepository = MockOnboardingRepository();
    mockUsernameGenerator = MockGuestUsernameGenerator();
    mockCompleteOnboardingUseCase = MockCompleteOnboardingUseCase();

    when(
      () => mockOnboardingRepository.getSkipDefaults(),
    ).thenAnswer((_) async => const Right(tDefaults));
    when(() => mockUsernameGenerator.resolveName('')).thenReturn(tGuestName);

    sut = SkipOnboardingUseCase(
      mockResolveOnboardingUserUseCase,
      mockOnboardingRepository,
      SkippedOnboardingDataResolver(mockUsernameGenerator),
      mockCompleteOnboardingUseCase,
      InitialCompanyResolver(),
    );
  });

  group('SkipOnboardingUseCase', () {
    test('call_signedInUser_savesResolvedDataForUserUid', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tExistingUser));
      when(
        () => mockCompleteOnboardingUseCase(any()),
      ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

      // act
      final result = await sut(const SkipOnboardingParams(data: tEmptyData));

      // assert
      expect(result, const Right(tDefaultResult));
      verify(() => mockOnboardingRepository.getSkipDefaults()).called(1);
      verify(
        () => mockCompleteOnboardingUseCase(
          const CompleteOnboardingParams(
            data: tResolvedEmptyData,
            uid: 'existing-uid',
            awaitServerAck: false,
            deferNotificationSetup: true,
          ),
        ),
      ).called(1);
    });

    test('call_anonymousUser_savesResolvedDataForAnonymousUid', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tAnonymousUser));
      when(
        () => mockCompleteOnboardingUseCase(any()),
      ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

      // act
      final result = await sut(const SkipOnboardingParams(data: tEmptyData));

      // assert
      expect(result, const Right(tDefaultResult));
      verify(
        () => mockCompleteOnboardingUseCase(
          const CompleteOnboardingParams(
            data: tResolvedEmptyData,
            uid: 'anon-uid',
            awaitServerAck: false,
            deferNotificationSetup: true,
          ),
        ),
      ).called(1);
    });

    test('call_userDecisions_returnsUserSelectionDestination', () async {
      // arrange
      const tData = OnboardingData(
        detectedCompanies: [Company(ticker: 'NKE', name: 'Nike')],
        hasDecidedNotifications: true,
      );
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tExistingUser));
      when(
        () => mockCompleteOnboardingUseCase(any()),
      ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

      // act
      final result = await sut(const SkipOnboardingParams(data: tData));

      // assert
      expect(
        result,
        const Right(
          SkipOnboardingResult.completed(
            destination: PostOnboardingDestination(
              ticker: 'NKE',
              tickerSource: OnboardingValueSource.userSelection,
              shouldPromptNotifications: false,
            ),
            fieldSources: OnboardingFieldSources(
              name: OnboardingValueSource.localDefault,
              sector: OnboardingValueSource.remoteDefault,
              companies: OnboardingValueSource.userSelection,
              experience: OnboardingValueSource.localDefault,
              notifications: OnboardingValueSource.userSelection,
            ),
          ),
        ),
      );
    });

    test(
      'call_enabledNotificationsBeforeSkip_defersSetupAndFlagsGrantPersist',
      () async {
        // arrange
        const tData = OnboardingData(
          hasDecidedNotifications: true,
          notificationsEnabled: true,
        );
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tExistingUser));
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

        // act
        final result = await sut(const SkipOnboardingParams(data: tData));

        // assert
        final destination = result.fold(
          (_) => fail('Should be Right'),
          (skipResult) => switch (skipResult) {
            SkipOnboardingCompleted(:final destination) => destination,
            SkipOnboardingExistingProfile() => fail('Should be completed'),
          },
        );
        expect(destination.shouldPersistNotificationGrant, isTrue);
        expect(destination.shouldPromptNotifications, isFalse);
        final params =
            verify(
                  () => mockCompleteOnboardingUseCase(captureAny()),
                ).captured.single
                as CompleteOnboardingParams;
        expect(params.data.notificationsEnabled, isTrue);
        expect(params.deferNotificationSetup, isTrue);
        expect(params.awaitServerAck, isFalse);
      },
    );

    test(
      'call_declinedNotificationsBeforeSkip_neitherPromptsNorPersistsGrant',
      () async {
        // arrange
        const tData = OnboardingData(hasDecidedNotifications: true);
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tExistingUser));
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

        // act
        final result = await sut(const SkipOnboardingParams(data: tData));

        // assert
        final destination = result.fold(
          (_) => fail('Should be Right'),
          (skipResult) => switch (skipResult) {
            SkipOnboardingCompleted(:final destination) => destination,
            SkipOnboardingExistingProfile() => fail('Should be completed'),
          },
        );
        expect(destination.shouldPersistNotificationGrant, isFalse);
        expect(destination.shouldPromptNotifications, isFalse);
      },
    );

    test(
      'call_profileAlreadyExistsForSignedInAccount_returnsExistingProfileWithoutResolvingCompany',
      () async {
        // arrange
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tExistingUser));
        when(() => mockCompleteOnboardingUseCase(any())).thenAnswer(
          (_) async => const Right(OnboardingSaveOutcome.existingProfile),
        );

        // act
        final result = await sut(const SkipOnboardingParams(data: tEmptyData));

        // assert
        expect(result, const Right(SkipOnboardingResult.existingProfile()));
        verify(() => mockOnboardingRepository.getSkipDefaults()).called(1);
      },
    );

    group('existing profile', () {
      const tCompanyProfileData = OnboardingData(
        selectedSector: Sector.energy,
        detectedCompanies: [Company(ticker: 'XOM', name: 'Exxon')],
        hasDecidedNotifications: true,
        notificationsEnabled: true,
      );

      test(
        'call_existingProfile_updatesWithUnresolvedDataWithoutRecreatingProfile',
        () async {
          // arrange
          when(
            () => mockResolveOnboardingUserUseCase(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

          // act
          final result = await sut(
            const SkipOnboardingParams(
              data: tCompanyProfileData,
              hasExistingProfile: true,
            ),
          );

          // assert
          expect(result.isRight(), isTrue);
          verify(
            () => mockCompleteOnboardingUseCase(
              const CompleteOnboardingParams(
                data: tCompanyProfileData,
                uid: 'anon-uid',
                awaitServerAck: false,
                deferNotificationSetup: true,
                hasExistingProfile: true,
              ),
            ),
          ).called(1);
        },
      );

      test(
        'call_existingProfile_reportsOnlyUserProvidedFieldSources',
        () async {
          // arrange
          when(
            () => mockResolveOnboardingUserUseCase(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

          // act
          final result = await sut(
            const SkipOnboardingParams(
              data: tCompanyProfileData,
              hasExistingProfile: true,
            ),
          );

          // assert
          expect(
            result,
            const Right(
              SkipOnboardingResult.completed(
                destination: PostOnboardingDestination(
                  ticker: 'XOM',
                  tickerSource: OnboardingValueSource.userSelection,
                  shouldPromptNotifications: false,
                  shouldPersistNotificationGrant: true,
                ),
                fieldSources: OnboardingFieldSources(
                  name: OnboardingValueSource.none,
                  sector: OnboardingValueSource.userSelection,
                  companies: OnboardingValueSource.userSelection,
                  experience: OnboardingValueSource.none,
                  notifications: OnboardingValueSource.userSelection,
                ),
              ),
            ),
          );
        },
      );

      test(
        'call_existingProfileWithUserCompanies_skipsDefaultsFetch',
        () async {
          // arrange
          when(
            () => mockResolveOnboardingUserUseCase(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          when(
            () => mockOnboardingRepository.getSkipDefaults(),
          ).thenAnswer((_) async => const Left(tFailure));
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

          // act
          final result = await sut(
            const SkipOnboardingParams(
              data: tCompanyProfileData,
              hasExistingProfile: true,
            ),
          );

          // assert
          expect(result.isRight(), isTrue);
          verifyNever(() => mockOnboardingRepository.getSkipDefaults());
        },
      );

      test(
        'call_existingProfileWithoutUserCompanies_resolvesDefaultDestination',
        () async {
          // arrange
          when(
            () => mockResolveOnboardingUserUseCase(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          when(
            () => mockCompleteOnboardingUseCase(any()),
          ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

          // act
          final result = await sut(
            const SkipOnboardingParams(
              data: tEmptyData,
              hasExistingProfile: true,
            ),
          );

          // assert
          final destination = result.fold(
            (_) => fail('Should be Right'),
            (skipResult) => switch (skipResult) {
              SkipOnboardingCompleted(:final destination) => destination,
              SkipOnboardingExistingProfile() => fail('Should be completed'),
            },
          );
          expect(destination.ticker, 'AAPL');
          expect(destination.tickerSource, OnboardingValueSource.remoteDefault);
          verify(() => mockOnboardingRepository.getSkipDefaults()).called(1);
          verify(
            () => mockCompleteOnboardingUseCase(
              const CompleteOnboardingParams(
                data: tEmptyData,
                uid: 'anon-uid',
                awaitServerAck: false,
                deferNotificationSetup: true,
                hasExistingProfile: true,
              ),
            ),
          ).called(1);
        },
      );

      test(
        'call_existingProfileWithoutUserCompaniesAndDefaultsFail_returnsLeftFailureWithoutSaving',
        () async {
          // arrange
          when(
            () => mockResolveOnboardingUserUseCase(any()),
          ).thenAnswer((_) async => const Right(tAnonymousUser));
          when(
            () => mockOnboardingRepository.getSkipDefaults(),
          ).thenAnswer((_) async => const Left(tFailure));

          // act
          final result = await sut(
            const SkipOnboardingParams(
              data: tEmptyData,
              hasExistingProfile: true,
            ),
          );

          // assert
          expect(result, const Left(tFailure));
          verifyNever(() => mockCompleteOnboardingUseCase(any()));
        },
      );

      test('call_noExistingProfile_createsProfileFromResolvedData', () async {
        // arrange
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tExistingUser));
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));

        // act
        await sut(const SkipOnboardingParams(data: tEmptyData));

        // assert
        final params =
            verify(
                  () => mockCompleteOnboardingUseCase(captureAny()),
                ).captured.single
                as CompleteOnboardingParams;
        expect(params.hasExistingProfile, isFalse);
        expect(params.data, tResolvedEmptyData);
      });

      test('call_existingProfileUpdateFails_returnsLeftFailure', () async {
        // arrange
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tAnonymousUser));
        when(
          () => mockCompleteOnboardingUseCase(any()),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await sut(
          const SkipOnboardingParams(
            data: tCompanyProfileData,
            hasExistingProfile: true,
          ),
        );

        // assert
        expect(result, const Left(tFailure));
      });
    });

    test('call_userResolutionFails_returnsLeftFailureWithoutSaving', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(const SkipOnboardingParams(data: tEmptyData));

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockCompleteOnboardingUseCase(any()));
    });

    test('call_skipDefaultsFail_returnsLeftFailureWithoutSaving', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tExistingUser));
      when(
        () => mockOnboardingRepository.getSkipDefaults(),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(const SkipOnboardingParams(data: tEmptyData));

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockCompleteOnboardingUseCase(any()));
    });

    test('call_saveFails_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tExistingUser));
      when(
        () => mockCompleteOnboardingUseCase(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(const SkipOnboardingParams(data: tEmptyData));

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
