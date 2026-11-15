import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/notifications/domain/usecases/check_notification_permission_usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:bizzie/features/onboarding/domain/usecases/persist_notification_grant_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockCheckNotificationPermissionUseCase extends Mock
    implements CheckNotificationPermissionUseCase {}

class MockToggleNotificationsUseCase extends Mock
    implements ToggleNotificationsUseCase {}

class MockSubscribeToNotificationTopicsUseCase extends Mock
    implements SubscribeToNotificationTopicsUseCase {}

const tUid = 'guest-uid';
const tAuthUser = auth.UserModel(id: tUid, email: '', isAnonymous: true);
const tFailure = Failure.server('Test Failure');
const tExpectedTopics = NotificationTopicsParams(
  sectorName: 'informationtechnology',
  tickers: ['AAPL', 'MSFT'],
);
final tUser = UserModel(
  uid: tUid,
  name: 'Guest',
  favoriteSector: 'informationtechnology',
  watchlist: const [
    Company(ticker: 'AAPL', name: 'Apple'),
    Company(ticker: 'MSFT', name: 'Microsoft'),
  ],
  investingExperience: InvestingExperience.beginner,
  createdAt: DateTime(2026),
  isSubscribed: false,
);

void main() {
  late PersistNotificationGrantUseCase sut;
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockCheckNotificationPermissionUseCase mockCheckPermission;
  late MockToggleNotificationsUseCase mockToggleNotifications;
  late MockSubscribeToNotificationTopicsUseCase mockSubscribeToTopics;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(const NotificationTopicsParams());
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockCheckPermission = MockCheckNotificationPermissionUseCase();
    mockToggleNotifications = MockToggleNotificationsUseCase();
    mockSubscribeToTopics = MockSubscribeToNotificationTopicsUseCase();
    sut = PersistNotificationGrantUseCase(
      mockAuthRepository,
      mockUserRepository,
      mockCheckPermission,
      mockToggleNotifications,
      mockSubscribeToTopics,
    );

    when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
    when(
      () => mockCheckPermission(any()),
    ).thenAnswer((_) async => const Right(true));
    when(
      () => mockToggleNotifications(any()),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockUserRepository.getUser(any()),
    ).thenAnswer((_) async => Right(tUser));
    when(
      () => mockSubscribeToTopics(any()),
    ).thenAnswer((_) async => const Right(null));
  });

  group('PersistNotificationGrantUseCase', () {
    test(
      'call_permissionGranted_enablesNotificationsAndSubscribesUserTopics',
      () async {
        // arrange

        // act
        final result = await sut(NoParams());

        // assert
        expect(result, const Right(true));
        verify(() => mockToggleNotifications(true)).called(1);
        verify(() => mockUserRepository.getUser(tUid)).called(1);
        verify(() => mockSubscribeToTopics(tExpectedTopics)).called(1);
      },
    );

    test('call_permissionDenied_returnsRightFalseWithoutPersisting', () async {
      // arrange
      when(
        () => mockCheckPermission(any()),
      ).thenAnswer((_) async => const Right(false));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Right(false));
      verifyNever(() => mockToggleNotifications(any()));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test('call_permissionCheckFails_returnsLeft', () async {
      // arrange
      when(
        () => mockCheckPermission(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockToggleNotifications(any()));
    });

    test('call_noCurrentUser_returnsLeftUserNotFound', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(Failure.userNotFound()));
      verifyNever(() => mockToggleNotifications(any()));
    });

    test('call_toggleFails_returnsLeftWithoutSubscribing', () async {
      // arrange
      when(
        () => mockToggleNotifications(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test('call_getUserFails_returnsLeftWithoutSubscribing', () async {
      // arrange
      when(
        () => mockUserRepository.getUser(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(tFailure));
      verifyNever(() => mockSubscribeToTopics(any()));
    });

    test('call_topicSubscriptionFails_returnsLeft', () async {
      // arrange
      when(
        () => mockSubscribeToTopics(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(NoParams());

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
