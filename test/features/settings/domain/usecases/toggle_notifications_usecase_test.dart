import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockINotificationService extends Mock implements INotificationService {}

void main() {
  late ToggleNotificationsUseCase useCase;
  late MockUserRepository mockUserRepository;
  late MockAuthRepository mockAuthRepository;
  late MockINotificationService mockNotificationService;

  setUpAll(() {
    registerFallbackValue(
      UserModel(
        uid: 'fallback',
        name: 'fallback',
        favoriteSector: 'fallback',
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime(2023),
        isSubscribed: false,
        notificationsEnabled: true,
      ),
    );
  });

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockAuthRepository = MockAuthRepository();
    mockNotificationService = MockINotificationService();
    useCase = ToggleNotificationsUseCase(
      mockAuthRepository,
      mockUserRepository,
      mockNotificationService,
    );
  });

  const tUserId = 'user_123';
  final tAuthUser = auth.UserModel(id: tUserId, email: 'test@example.com');

  group('ToggleNotificationsUseCase', () {
    group('execute', () {
      test(
        'toggleNotificationsUseCase_executeEnableSuccess_returnsRight',
        () async {
          // arrange
          const tEnable = true;
          const tToken = 'token_123';
          const tDeviceId = 'device_123';
          when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
          when(
            () => mockNotificationService.getFcmToken(),
          ).thenAnswer((_) async => tToken);
          when(
            () => mockNotificationService.getDeviceUuid(),
          ).thenAnswer((_) async => tDeviceId);
          when(
            () => mockUserRepository.updateNotificationSettings(
              any(),
              deviceId: any(named: 'deviceId'),
              token: any(named: 'token'),
            ),
          ).thenAnswer((_) async => const Right(null));

          // act
          final result = await useCase(tEnable);

          // assert
          expect(result, const Right(null));
          verify(() => mockAuthRepository.currentUser).called(1);
          verify(() => mockNotificationService.getFcmToken()).called(1);
          verify(() => mockNotificationService.getDeviceUuid()).called(1);
          verify(
            () => mockUserRepository.updateNotificationSettings(
              tEnable,
              deviceId: tDeviceId,
              token: tToken,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
          verifyNoMoreInteractions(mockUserRepository);
        },
      );

      test(
        'toggleNotificationsUseCase_executeDisableSuccess_returnsRight',
        () async {
          // arrange
          const tEnable = false;
          when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
          when(
            () => mockUserRepository.updateNotificationSettings(any()),
          ).thenAnswer((_) async => const Right(null));

          // act
          final result = await useCase(tEnable);

          // assert
          expect(result, const Right(null));
          verify(() => mockAuthRepository.currentUser).called(1);
          verify(
            () => mockUserRepository.updateNotificationSettings(tEnable),
          ).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
          verifyNoMoreInteractions(mockUserRepository);
        },
      );

      test(
        'toggleNotificationsUseCase_executeUnauthenticated_returnsUserNotFoundFailure',
        () async {
          // arrange
          when(() => mockAuthRepository.currentUser).thenReturn(null);

          // act
          final result = await useCase(true);

          // assert
          expect(result, const Left(Failure.userNotFound()));
          verify(() => mockAuthRepository.currentUser).called(1);
          verifyZeroInteractions(mockUserRepository);
        },
      );

      test(
        'toggleNotificationsUseCase_executeUpdateRepoFails_returnsFailure',
        () async {
          // arrange
          const tFailure = Failure.server('Update failed');
          when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
          when(
            () => mockNotificationService.getFcmToken(),
          ).thenAnswer((_) async => 'token');
          when(
            () => mockNotificationService.getDeviceUuid(),
          ).thenAnswer((_) async => 'device');
          when(
            () => mockUserRepository.updateNotificationSettings(
              any(),
              deviceId: any(named: 'deviceId'),
              token: any(named: 'token'),
            ),
          ).thenAnswer((_) async => const Left(tFailure));

          // act
          final result = await useCase(true);

          // assert
          expect(result, const Left(tFailure));
          verify(() => mockAuthRepository.currentUser).called(1);
          verify(
            () => mockUserRepository.updateNotificationSettings(
              any(),
              deviceId: any(named: 'deviceId'),
              token: any(named: 'token'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUserRepository);
          verifyNoMoreInteractions(mockAuthRepository);
        },
      );

      test(
        'toggleNotificationsUseCase_executeEnableWithTokenFetchError_continuesAndUpdateRepoWithNullToken',
        () async {
          // arrange
          const tEnable = true;
          when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
          when(
            () => mockNotificationService.getFcmToken(),
          ).thenThrow(Exception('Fetch failed'));
          when(
            () => mockUserRepository.updateNotificationSettings(
              any(),
              deviceId: any(named: 'deviceId'),
              token: any(named: 'token'),
            ),
          ).thenAnswer((_) async => const Right(null));

          // act
          final result = await useCase(tEnable);

          // assert
          expect(result, const Right(null));
          verify(() => mockAuthRepository.currentUser).called(1);
          verify(() => mockNotificationService.getFcmToken()).called(1);
          verify(
            () => mockUserRepository.updateNotificationSettings(
              tEnable,
              deviceId: null,
              token: null,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockAuthRepository);
          verifyNoMoreInteractions(mockUserRepository);
        },
      );
    });
  });
}
