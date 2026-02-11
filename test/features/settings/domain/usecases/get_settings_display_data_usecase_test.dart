import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/services/app_info_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart' as domain;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/core/interfaces/i_notification_service.dart';

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockIUserRepository extends Mock implements IUserRepository {}

class MockISubscriptionRepository extends Mock
    implements ISubscriptionRepository {}

class MockIAppInfoService extends Mock implements IAppInfoService {}

class MockINotificationService extends Mock implements INotificationService {}

void main() {
  late GetSettingsDisplayDataUseCase useCase;
  late MockIAuthRepository mockAuthRepository;
  late MockIUserRepository mockUserRepository;
  late MockISubscriptionRepository mockSubscriptionRepository;
  late MockIAppInfoService mockAppInfoService;
  late MockINotificationService mockNotificationService;

  setUp(() {
    mockAuthRepository = MockIAuthRepository();
    mockUserRepository = MockIUserRepository();
    mockSubscriptionRepository = MockISubscriptionRepository();
    mockAppInfoService = MockIAppInfoService();
    mockNotificationService = MockINotificationService();

    useCase = GetSettingsDisplayDataUseCase(
      mockAuthRepository,
      mockUserRepository,
      mockSubscriptionRepository,
      mockAppInfoService,
      mockNotificationService,
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
        () => mockNotificationService.isSystemAuthorized(),
      ).thenAnswer((_) async => true);

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
          ),
        ),
      );
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
      verify(
        () => mockSubscriptionRepository.getSubscriptionStatus(),
      ).called(1);
      verify(() => mockAppInfoService.getAppVersion()).called(1);
      verify(() => mockNotificationService.isSystemAuthorized()).called(1);
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
        () => mockNotificationService.isSystemAuthorized(),
      ).thenAnswer((_) async => true);

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
          () => mockNotificationService.isSystemAuthorized(),
        ).thenAnswer((_) async => true);

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
        () => mockNotificationService.isSystemAuthorized(),
      ).thenAnswer((_) async => true);

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
          ),
        ),
      );
      verify(() => mockAppInfoService.getAppVersion()).called(1);
    });
  });
}
