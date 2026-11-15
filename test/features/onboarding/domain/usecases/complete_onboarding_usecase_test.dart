import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/features/onboarding/domain/services/onboarding_profile_builder.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockNotificationService extends Mock implements INotificationService {}

class MockSubscribeToNotificationTopicsUseCase extends Mock
    implements SubscribeToNotificationTopicsUseCase {}

const tUid = 'uid-1';
const tFailure = Failure.server('Test Failure');
const tData = OnboardingData(
  firstName: 'Jane',
  selectedSector: Sector.informationTechnology,
  detectedCompanies: [Company(ticker: 'AAPL', name: 'Apple')],
  investingExperience: InvestingExperience.beginner,
  notificationsEnabled: true,
);
const tParams = CompleteOnboardingParams(data: tData, uid: tUid);
const tExistingProfileParams = CompleteOnboardingParams(
  data: OnboardingData(
    firstName: 'Jane',
    selectedSector: Sector.informationTechnology,
    detectedCompanies: [
      Company(ticker: 'AAPL', name: 'Apple'),
      Company(ticker: 'TSLA', name: 'Tesla'),
    ],
    investingExperience: InvestingExperience.expert,
    notificationsEnabled: true,
    hasDecidedNotifications: true,
  ),
  uid: tUid,
  hasExistingProfile: true,
);
final tSavedUser = UserModel(
  uid: tUid,
  name: 'Jane',
  favoriteSector: 'information_technology',
  watchlist: const [Company(ticker: 'AAPL', name: 'Apple')],
  investingExperience: InvestingExperience.expert,
  createdAt: DateTime(2026),
  isSubscribed: false,
);

void main() {
  late CompleteOnboardingUseCase sut;
  late MockOnboardingRepository mockRepository;
  late MockUserRepository mockUserRepository;
  late MockNotificationService mockNotificationService;
  late MockSubscribeToNotificationTopicsUseCase mockSubscribeToTopics;

  setUpAll(() {
    registerFallbackValue(const NotificationTopicsParams());
    registerFallbackValue(const OnboardingProfileUpdate(uid: 'fallback'));
    registerFallbackValue(
      UserModel(
        uid: 'fallback',
        name: 'fallback',
        favoriteSector: 'fallback',
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime(2026),
        isSubscribed: false,
      ),
    );
  });

  setUp(() {
    mockRepository = MockOnboardingRepository();
    mockUserRepository = MockUserRepository();
    mockNotificationService = MockNotificationService();
    mockSubscribeToTopics = MockSubscribeToNotificationTopicsUseCase();
    sut = CompleteOnboardingUseCase(
      mockRepository,
      mockUserRepository,
      mockNotificationService,
      mockSubscribeToTopics,
      OnboardingProfileBuilder(),
    );

    when(
      () => mockRepository.userProfileExists(any()),
    ).thenAnswer((_) async => const Right(false));
    when(
      () => mockUserRepository.getUser(any()),
    ).thenAnswer((_) async => Right(tSavedUser));
    when(
      () => mockNotificationService.getDeviceUuid(),
    ).thenAnswer((_) async => 'device-1');
    when(
      () => mockNotificationService.getFcmToken(),
    ).thenAnswer((_) async => 'token-1');
    when(
      () => mockSubscribeToTopics(any()),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockRepository.saveUserProfile(
        any(),
        awaitServerAck: any(named: 'awaitServerAck'),
      ),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockRepository.updateOnboardingProfile(
        any(),
        awaitServerAck: any(named: 'awaitServerAck'),
      ),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockUserRepository.updateNotificationSettings(
        any(),
        deviceId: any(named: 'deviceId'),
        token: any(named: 'token'),
      ),
    ).thenAnswer((_) async => const Right(null));
  });

  group('CompleteOnboardingUseCase', () {
    test(
      'call_notificationsEnabled_subscribesSavedProfileTopicsAndSavesToken',
      () async {
        // arrange

        // act
        final result = await sut(tParams);

        // assert
        expect(result, const Right(OnboardingSaveOutcome.saved));
        verify(() => mockUserRepository.getUser(tUid)).called(1);
        verify(
          () => mockSubscribeToTopics(
            const NotificationTopicsParams(
              sectorName: 'information_technology',
              tickers: ['AAPL'],
            ),
          ),
        ).called(1);
        final saved =
            verify(
                  () => mockRepository.saveUserProfile(
                    captureAny(),
                    awaitServerAck: any(named: 'awaitServerAck'),
                  ),
                ).captured.single
                as UserModel;
        expect(saved.fcmTokens, {'device-1': 'token-1'});
        expect(saved.notificationsEnabled, isTrue);
      },
    );

    test('call_topicSubscriptionFails_stillSavesProfile', () async {
      // arrange
      when(
        () => mockSubscribeToTopics(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Right(OnboardingSaveOutcome.saved));
      verify(
        () => mockRepository.saveUserProfile(
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      ).called(1);
    });

    test('call_notificationsDisabled_doesNotSubscribe', () async {
      // arrange
      final params = tParams.copyWith(
        data: tData.copyWith(notificationsEnabled: false),
      );

      // act
      final result = await sut(params);

      // assert
      expect(result, const Right(OnboardingSaveOutcome.saved));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test('params_defaults_awaitServerAckAndDoNotDeferNotifications', () {
      // arrange
      const params = CompleteOnboardingParams(data: tData, uid: tUid);

      // act
      final awaitServerAck = params.awaitServerAck;
      final deferNotificationSetup = params.deferNotificationSetup;
      final hasExistingProfile = params.hasExistingProfile;

      // assert
      expect(awaitServerAck, isTrue);
      expect(deferNotificationSetup, isFalse);
      expect(hasExistingProfile, isFalse);
    });

    test(
      'call_defaultParams_checksProfileThenSavesWithServerAckBeforeSubscribing',
      () async {
        // arrange

        // act
        await sut(tParams);

        // assert
        verifyInOrder([
          () => mockRepository.userProfileExists(tUid),
          () => mockNotificationService.getFcmToken(),
          () => mockRepository.saveUserProfile(any(), awaitServerAck: true),
          () => mockUserRepository.getUser(tUid),
          () => mockSubscribeToTopics(any()),
        ]);
      },
    );

    test('call_savedProfileReadFails_stillReturnsSaved', () async {
      // arrange
      when(
        () => mockUserRepository.getUser(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Right(OnboardingSaveOutcome.saved));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test('call_noFcmToken_savesWithoutSubscribing', () async {
      // arrange
      when(
        () => mockNotificationService.getFcmToken(),
      ).thenAnswer((_) async => null);

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Right(OnboardingSaveOutcome.saved));
      verifyNever(() => mockUserRepository.getUser(any()));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test(
      'call_deferNotificationSetup_skipsTokenAndTopicsButKeepsPreference',
      () async {
        // arrange
        final params = tParams.copyWith(deferNotificationSetup: true);

        // act
        final result = await sut(params);

        // assert
        expect(result, const Right(OnboardingSaveOutcome.saved));
        verifyNever(() => mockNotificationService.getFcmToken());
        verifyNever(() => mockNotificationService.getDeviceUuid());
        verifyNever(() => mockSubscribeToTopics(any()));
        final saved =
            verify(
                  () => mockRepository.saveUserProfile(
                    captureAny(),
                    awaitServerAck: any(named: 'awaitServerAck'),
                  ),
                ).captured.single
                as UserModel;
        expect(saved.fcmTokens, isEmpty);
        expect(saved.notificationsEnabled, isTrue);
      },
    );

    test('call_awaitServerAckFalse_forwardsFlagToRepository', () async {
      // arrange
      final params = tParams.copyWith(awaitServerAck: false);

      // act
      final result = await sut(params);

      // assert
      expect(result, const Right(OnboardingSaveOutcome.saved));
      verify(
        () => mockRepository.saveUserProfile(any(), awaitServerAck: false),
      ).called(1);
    });

    test('call_noExistingProfile_createsFullProfileAndNeverUpdates', () async {
      // arrange

      // act
      await sut(tParams);

      // assert
      final saved =
          verify(
                () => mockRepository.saveUserProfile(
                  captureAny(),
                  awaitServerAck: any(named: 'awaitServerAck'),
                ),
              ).captured.single
              as UserModel;
      expect(saved.isSubscribed, isFalse);
      expect(saved.watchlist, const [Company(ticker: 'AAPL', name: 'Apple')]);
      expect(saved.favoriteSector, 'informationtechnology');
      verifyNever(
        () => mockRepository.updateOnboardingProfile(
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      );
    });

    group('profile already exists without a saved onboarding profile', () {
      test(
        'call_profileExists_returnsExistingProfileWithoutAnyWriteOrSubscription',
        () async {
          // arrange
          when(
            () => mockRepository.userProfileExists(any()),
          ).thenAnswer((_) async => const Right(true));

          // act
          final result = await sut(tParams);

          // assert
          expect(result, const Right(OnboardingSaveOutcome.existingProfile));
          verify(() => mockRepository.userProfileExists(tUid)).called(1);
          verifyNever(
            () => mockRepository.saveUserProfile(
              any(),
              awaitServerAck: any(named: 'awaitServerAck'),
            ),
          );
          verifyNever(
            () => mockRepository.updateOnboardingProfile(
              any(),
              awaitServerAck: any(named: 'awaitServerAck'),
            ),
          );
          verifyNever(() => mockNotificationService.getFcmToken());
          verifyNever(() => mockSubscribeToTopics(any()));
        },
      );

      test(
        'call_profileExistenceCheckFails_returnsLeftWithoutWriting',
        () async {
          // arrange
          when(
            () => mockRepository.userProfileExists(any()),
          ).thenAnswer((_) async => const Left(tFailure));

          // act
          final result = await sut(tParams);

          // assert
          expect(result, const Left(tFailure));
          verifyNever(
            () => mockRepository.saveUserProfile(
              any(),
              awaitServerAck: any(named: 'awaitServerAck'),
            ),
          );
        },
      );
    });

    group('existing profile', () {
      test(
        'call_existingProfile_updatesOwnedFieldsWithoutRecreatingProfile',
        () async {
          // arrange

          // act
          final result = await sut(tExistingProfileParams);

          // assert
          expect(result, const Right(OnboardingSaveOutcome.saved));
          verifyNever(() => mockRepository.userProfileExists(any()));
          verify(
            () => mockRepository.updateOnboardingProfile(
              const OnboardingProfileUpdate(
                uid: tUid,
                name: 'Jane',
                investingExperience: InvestingExperience.expert,
                notificationsEnabled: true,
              ),
              awaitServerAck: true,
            ),
          ).called(1);
          verifyNever(
            () => mockRepository.saveUserProfile(
              any(),
              awaitServerAck: any(named: 'awaitServerAck'),
            ),
          );
        },
      );

      test(
        'call_existingProfileUndecidedFields_omitsNameExperienceAndNotifications',
        () async {
          // arrange
          final params = tExistingProfileParams.copyWith(
            data: const OnboardingData(
              detectedCompanies: [Company(ticker: 'AAPL', name: 'Apple')],
            ),
          );

          // act
          await sut(params);

          // assert
          verify(
            () => mockRepository.updateOnboardingProfile(
              const OnboardingProfileUpdate(uid: tUid),
              awaitServerAck: true,
            ),
          ).called(1);
        },
      );

      test(
        'call_existingProfileAwaitServerAckFalse_forwardsFlagToUpdate',
        () async {
          // arrange
          final params = tExistingProfileParams.copyWith(
            awaitServerAck: false,
            deferNotificationSetup: true,
          );

          // act
          await sut(params);

          // assert
          verify(
            () => mockRepository.updateOnboardingProfile(
              any(),
              awaitServerAck: false,
            ),
          ).called(1);
          verifyNever(() => mockNotificationService.getFcmToken());
          verifyNever(() => mockSubscribeToTopics(any()));
        },
      );

      test(
        'call_existingProfileNotificationsEnabled_subscribesSavedWatchlistNotOnboardingPicks',
        () async {
          // arrange

          // act
          await sut(tExistingProfileParams);

          // assert
          verifyInOrder([
            () => mockRepository.updateOnboardingProfile(
              any(),
              awaitServerAck: true,
            ),
            () => mockUserRepository.getUser(tUid),
            () => mockSubscribeToTopics(
              const NotificationTopicsParams(
                sectorName: 'information_technology',
                tickers: ['AAPL'],
              ),
            ),
          ]);
        },
      );

      test(
        'call_existingProfileNotificationsEnabled_savesFcmTokenAfterUpdate',
        () async {
          // arrange

          // act
          final result = await sut(tExistingProfileParams);

          // assert
          expect(result, const Right(OnboardingSaveOutcome.saved));
          verifyInOrder([
            () => mockRepository.updateOnboardingProfile(
              any(),
              awaitServerAck: true,
            ),
            () => mockUserRepository.updateNotificationSettings(
              true,
              deviceId: 'device-1',
              token: 'token-1',
            ),
            () => mockSubscribeToTopics(any()),
          ]);
        },
      );

      test('call_existingProfileFcmTokenSaveFails_stillReturnsSaved', () async {
        // arrange
        when(
          () => mockUserRepository.updateNotificationSettings(
            any(),
            deviceId: any(named: 'deviceId'),
            token: any(named: 'token'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await sut(tExistingProfileParams);

        // assert
        expect(result, const Right(OnboardingSaveOutcome.saved));
        verify(() => mockSubscribeToTopics(any())).called(1);
      });

      test(
        'call_existingProfileNoFcmToken_doesNotSaveNotificationSettings',
        () async {
          // arrange
          when(
            () => mockNotificationService.getFcmToken(),
          ).thenAnswer((_) async => null);

          // act
          await sut(tExistingProfileParams);

          // assert
          verifyNever(
            () => mockUserRepository.updateNotificationSettings(
              any(),
              deviceId: any(named: 'deviceId'),
              token: any(named: 'token'),
            ),
          );
        },
      );

      test('call_existingProfileUpdateFails_returnsLeft', () async {
        // arrange
        when(
          () => mockRepository.updateOnboardingProfile(
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await sut(tExistingProfileParams);

        // assert
        expect(result, const Left(tFailure));
        verifyNever(
          () => mockUserRepository.updateNotificationSettings(
            any(),
            deviceId: any(named: 'deviceId'),
            token: any(named: 'token'),
          ),
        );
      });
    });

    test('call_newProfile_savesTokenInProfileNotViaSettings', () async {
      // arrange

      // act
      await sut(tParams);

      // assert
      verifyNever(
        () => mockUserRepository.updateNotificationSettings(
          any(),
          deviceId: any(named: 'deviceId'),
          token: any(named: 'token'),
        ),
      );
    });

    test('call_saveFails_returnsLeft', () async {
      // arrange
      when(
        () => mockRepository.saveUserProfile(
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
