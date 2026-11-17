import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/save_onboarding_progress_result.dart';
import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/save_onboarding_progress_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResolveOnboardingUserUseCase extends Mock
    implements ResolveOnboardingUserUseCase {}

class MockGuestUsernameGenerator extends Mock
    implements GuestUsernameGenerator {}

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

const tGuestName = 'userabc123xyz0';
const tGuestUser = UserModel(id: 'guest-uid', email: '', isAnonymous: true);
const tFailure = Failure.server('Test Failure');
const tBrandsData = OnboardingData(
  selectedSector: Sector.energy,
  detectedCompanies: [Company(ticker: 'XOM', name: 'Exxon')],
);
const tSavedBrandsData = OnboardingData(
  firstName: tGuestName,
  selectedSector: Sector.energy,
  detectedCompanies: [Company(ticker: 'XOM', name: 'Exxon')],
);
const tPartialParams = CompleteOnboardingParams(
  data: tSavedBrandsData,
  uid: 'guest-uid',
  awaitServerAck: false,
  deferNotificationSetup: true,
);

void main() {
  late SaveOnboardingProgressUseCase sut;
  late MockResolveOnboardingUserUseCase mockResolveOnboardingUserUseCase;
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
    mockUsernameGenerator = MockGuestUsernameGenerator();
    mockCompleteOnboardingUseCase = MockCompleteOnboardingUseCase();
    sut = SaveOnboardingProgressUseCase(
      mockResolveOnboardingUserUseCase,
      mockUsernameGenerator,
      mockCompleteOnboardingUseCase,
    );

    when(() => mockUsernameGenerator.resolveName('')).thenReturn(tGuestName);
    when(() => mockUsernameGenerator.resolveName('Ana')).thenReturn('Ana');
    when(
      () => mockCompleteOnboardingUseCase(any()),
    ).thenAnswer((_) async => const Right(OnboardingSaveOutcome.saved));
  });

  group('SaveOnboardingProgressUseCase', () {
    test(
      'call_guestSignedIn_savesGeneratedNameWithoutServerAckAndReturnsSaved',
      () async {
        // arrange
        when(
          () => mockResolveOnboardingUserUseCase(any()),
        ).thenAnswer((_) async => const Right(tGuestUser));

        // act
        final result = await sut(tBrandsData);

        // assert
        expect(
          result,
          const Right(SaveOnboardingProgressResult.saved(uid: 'guest-uid')),
        );
        verify(() => mockCompleteOnboardingUseCase(tPartialParams)).called(1);
      },
    );

    test('call_profileAlreadyExists_returnsExistingProfile', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tGuestUser));
      when(() => mockCompleteOnboardingUseCase(any())).thenAnswer(
        (_) async => const Right(OnboardingSaveOutcome.existingProfile),
      );

      // act
      final result = await sut(tBrandsData);

      // assert
      expect(
        result,
        const Right(SaveOnboardingProgressResult.existingProfile()),
      );
    });

    test('call_typedName_keepsTypedName', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tGuestUser));

      // act
      await sut(tBrandsData.copyWith(firstName: 'Ana'));

      // assert
      verify(() => mockUsernameGenerator.resolveName('Ana')).called(1);
      verify(
        () => mockCompleteOnboardingUseCase(
          tPartialParams.copyWith(
            data: tSavedBrandsData.copyWith(firstName: 'Ana'),
          ),
        ),
      ).called(1);
    });

    test('call_userResolutionFails_returnsLeftWithoutSaving', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tBrandsData);

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockCompleteOnboardingUseCase(any()));
    });

    test('call_saveFails_returnsLeft', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tGuestUser));
      when(
        () => mockCompleteOnboardingUseCase(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tBrandsData);

      // assert
      expect(result, const Left(tFailure));
    });

    test('call_firstSave_createsProfileRatherThanUpdating', () async {
      // arrange
      when(
        () => mockResolveOnboardingUserUseCase(any()),
      ).thenAnswer((_) async => const Right(tGuestUser));

      // act
      await sut(tBrandsData);

      // assert
      final params =
          verify(
                () => mockCompleteOnboardingUseCase(captureAny()),
              ).captured.single
              as CompleteOnboardingParams;
      expect(params.hasExistingProfile, isFalse);
    });
  });
}
