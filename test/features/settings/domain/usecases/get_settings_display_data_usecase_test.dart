import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_app_info_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart' as domain;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:mocktail/mocktail.dart';

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockIUserRepository extends Mock implements IUserRepository {}

class MockISubscriptionRepository extends Mock
    implements ISubscriptionRepository {}

class MockIAppInfoService extends Mock implements IAppInfoService {}

class MockINotificationRepository extends Mock
    implements INotificationRepository {}

class MockConfigService extends Mock implements ConfigService {}

void main() {
  late GetSettingsDisplayDataUseCase useCase;
  late MockIAuthRepository mockAuthRepository;
  late MockIUserRepository mockUserRepository;
  late MockISubscriptionRepository mockSubscriptionRepository;
  late MockIAppInfoService mockAppInfoService;
  late MockINotificationRepository mockNotificationRepository;
  late MockConfigService mockConfigService;

  setUp(() {
    mockAuthRepository = MockIAuthRepository();
    mockUserRepository = MockIUserRepository();
    mockSubscriptionRepository = MockISubscriptionRepository();
    mockAppInfoService = MockIAppInfoService();
    mockNotificationRepository = MockINotificationRepository();
    mockConfigService = MockConfigService();

    useCase = GetSettingsDisplayDataUseCase(
      mockAuthRepository,
      mockUserRepository,
      mockSubscriptionRepository,
      mockAppInfoService,
      mockNotificationRepository,
      mockConfigService,
    );
  });

  const tUserId = 'user123';
  const tAuthUser = auth.UserModel(id: tUserId, email: 'test@example.com');

  final tDomainUser = domain.UserModel(
    uid: tUserId,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime(2023, 1, 1),
    isSubscribed: true,
  );
  const tSubscriptionStatus = SubscriptionStatus(
    isSubscribed: true,
    activeEntitlements: {},
    activeProductIds: {},
    expirationDate: null,
  );
  const tAppVersion = '1.0.0';

  group('GetSettingsDisplayDataUseCase', () {
    test('call_allSuccess_returnsSettingsDisplayData', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tDomainUser));
      when(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).thenAnswer((_) async => const Right(tSubscriptionStatus));
      when(
        () => mockAppInfoService.getAppVersion(),
      ).thenAnswer((_) async => tAppVersion);
      when(
        () => mockNotificationRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(true));
      when(
        () => mockConfigService.privacyPolicyUrl,
      ).thenReturn('https://privacy.com');
      when(
        () => mockConfigService.termsOfServiceUrl,
      ).thenReturn('https://terms.com');

      // act
      final result = await useCase(NoParams());

      // assert
      expect(
        result,
        Right(
          SettingsDisplayData(
            user: tDomainUser,
            subscriptionStatus: tSubscriptionStatus,
            isAppNotificationsEnabled: tDomainUser.notificationsEnabled,
            isSystemNotificationsEnabled: true,
            appVersion: tAppVersion,
            favoriteSector: tDomainUser.favoriteSector,
            privacyPolicyUrl: 'https://privacy.com',
            termsOfServiceUrl: 'https://terms.com',
          ),
        ),
      );
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
      verify(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).called(1);
      verify(() => mockAppInfoService.getAppVersion()).called(1);
      verify(() => mockNotificationRepository.isSystemAuthorized()).called(1);
    });

    test('call_anonymousAuthUser_returnsDataWithIsGuestTrue', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(
        const auth.UserModel(id: tUserId, email: '', isAnonymous: true),
      );
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tDomainUser));
      when(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).thenAnswer((_) async => const Right(tSubscriptionStatus));
      when(
        () => mockAppInfoService.getAppVersion(),
      ).thenAnswer((_) async => tAppVersion);
      when(
        () => mockNotificationRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(true));
      when(
        () => mockConfigService.privacyPolicyUrl,
      ).thenReturn('https://privacy.com');
      when(
        () => mockConfigService.termsOfServiceUrl,
      ).thenReturn('https://terms.com');

      // act
      final result = await useCase(NoParams());

      // assert
      expect(
        result.map((data) => data.isGuest),
        const Right<Failure, bool>(true),
      );
    });

    test('call_userRepositoryFailure_returnsFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      when(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).thenAnswer((_) async => const Right(tSubscriptionStatus));
      when(
        () => mockAppInfoService.getAppVersion(),
      ).thenAnswer((_) async => tAppVersion);
      when(
        () => mockNotificationRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(true));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Left(ServerFailure('Server Error')));
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
    });

    test(
      'call_subscriptionRepositoryFailure_returnsInitialStatus (Fail-Open)',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => Right(tDomainUser));
        when(
          () => mockSubscriptionRepository.getSubscriptionStatus(),
        ).thenAnswer((_) async => const Left(ServerFailure('Sub Error')));
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => tAppVersion);
        when(
          () => mockNotificationRepository.isSystemAuthorized(),
        ).thenAnswer((_) async => const Right(true));
        when(
          () => mockConfigService.privacyPolicyUrl,
        ).thenReturn('https://privacy.com');
        when(
          () => mockConfigService.termsOfServiceUrl,
        ).thenReturn('https://terms.com');

        // act
        final result = await useCase(NoParams());

        // assert
        expect(
          result,
          Right(
            SettingsDisplayData(
              user: tDomainUser,
              subscriptionStatus: SubscriptionStatus.initial(),
              isAppNotificationsEnabled: tDomainUser.notificationsEnabled,
              isSystemNotificationsEnabled: true,
              appVersion: tAppVersion,
              favoriteSector: tDomainUser.favoriteSector,
              privacyPolicyUrl: 'https://privacy.com',
              termsOfServiceUrl: 'https://terms.com',
            ),
          ),
        );
      },
    );

    test('call_appInfoServiceFailure_returnsUnknownVersion', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tDomainUser));
      when(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).thenAnswer((_) async => const Right(tSubscriptionStatus));
      when(() => mockAppInfoService.getAppVersion()).thenThrow(Exception());
      when(
        () => mockNotificationRepository.isSystemAuthorized(),
      ).thenAnswer((_) async => const Right(true));
      when(
        () => mockConfigService.privacyPolicyUrl,
      ).thenReturn('https://privacy.com');
      when(
        () => mockConfigService.termsOfServiceUrl,
      ).thenReturn('https://terms.com');

      // act
      final result = await useCase(NoParams());

      // assert
      expect(
        result,
        Right(
          SettingsDisplayData(
            user: tDomainUser,
            subscriptionStatus: tSubscriptionStatus,
            isAppNotificationsEnabled: tDomainUser.notificationsEnabled,
            isSystemNotificationsEnabled: true,
            appVersion: 'Unknown',
            favoriteSector: tDomainUser.favoriteSector,
            privacyPolicyUrl: 'https://privacy.com',
            termsOfServiceUrl: 'https://terms.com',
          ),
        ),
      );
      verify(() => mockAppInfoService.getAppVersion()).called(1);
    });

    test(
      'call_notificationPermissionFailure_returnsSystemNotificationsDisabled',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => Right(tDomainUser));
        when(
          () => mockSubscriptionRepository.getSubscriptionStatus(),
        ).thenAnswer((_) async => const Right(tSubscriptionStatus));
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => tAppVersion);
        when(() => mockNotificationRepository.isSystemAuthorized()).thenAnswer(
          (_) async => const Left(Failure.permission('Permission Error')),
        );
        when(
          () => mockConfigService.privacyPolicyUrl,
        ).thenReturn('https://privacy.com');
        when(
          () => mockConfigService.termsOfServiceUrl,
        ).thenReturn('https://terms.com');

        // act
        final result = await useCase(NoParams());

        // assert
        expect(
          result,
          Right(
            SettingsDisplayData(
              user: tDomainUser,
              subscriptionStatus: tSubscriptionStatus,
              isAppNotificationsEnabled: tDomainUser.notificationsEnabled,
              isSystemNotificationsEnabled: false,
              appVersion: tAppVersion,
              favoriteSector: tDomainUser.favoriteSector,
              privacyPolicyUrl: 'https://privacy.com',
              termsOfServiceUrl: 'https://terms.com',
            ),
          ),
        );
      },
    );
  });
}
