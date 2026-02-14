import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_model;
import 'package:bizzie/features/feedback/domain/interfaces/i_feedback_repository.dart';
import 'package:bizzie/features/feedback/domain/models/feedback_model.dart';
import 'package:bizzie/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart'
    as user_model;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFeedbackRepository extends Mock implements IFeedbackRepository {}

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockNotificationService extends Mock implements INotificationService {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockAuthUser extends Mock implements auth_model.UserModel {}

void main() {
  late SubmitFeedbackUseCase useCase;
  late MockFeedbackRepository mockFeedbackRepository;
  late MockAuthRepository mockAuthRepository;
  late MockNotificationService mockNotificationService;
  late MockUserRepository mockUserRepository;
  late MockAuthUser mockAuthUser;

  setUp(() {
    mockFeedbackRepository = MockFeedbackRepository();
    mockAuthRepository = MockAuthRepository();
    mockNotificationService = MockNotificationService();
    mockUserRepository = MockUserRepository();
    mockAuthUser = MockAuthUser();
    useCase = SubmitFeedbackUseCase(
      mockFeedbackRepository,
      mockAuthRepository,
      mockNotificationService,
      mockUserRepository,
    );

    registerFallbackValue(
      FeedbackModel(
        userId: 'id',
        userName: 'name',
        message: 'message',
        timestamp: DateTime.now(),
        isSubscribed: false,
        notificationsEnabled: false,
      ),
    );
  });

  const tUserId = 'test_user_id';
  const tEmail = 'test@example.com';
  const tMessage = 'Great app!';
  const tFcmToken = 'fcm_token';

  final tUserModel = user_model.UserModel(
    uid: tUserId,
    name: 'Test User',
    favoriteSector: 'Tech',
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime.now(),
    isSubscribed: true,
    notificationsEnabled: true,
  );

  group('SubmitFeedbackUseCase', () {
    test('call_emptyMessage_returnsServerFailure', () async {
      // act
      final result = await useCase('');

      // assert
      expect(result, const Left(Failure.server('Feedback cannot be empty')));
      verifyZeroInteractions(mockFeedbackRepository);
    });

    test('call_messageExceedsLength_returnsServerFailure', () async {
      // arrange
      final longMessage = 'a' * (FeedbackModel.maxMessageLength + 1);

      // act
      final result = await useCase(longMessage);

      // assert
      expect(result, const Left(Failure.server('Feedback is too long')));
      verifyZeroInteractions(mockFeedbackRepository);
    });

    test('call_unauthenticatedUser_returnsUserNotFoundFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      // act
      final result = await useCase(tMessage);

      // assert
      expect(result, const Left(Failure.userNotFound()));
      verifyZeroInteractions(mockFeedbackRepository);
    });

    test(
      'call_authenticatedUserWithProfile_populatesAllFieldsAndReturnsSuccess',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(mockAuthUser);
        when(() => mockAuthUser.id).thenReturn(tUserId);
        when(() => mockAuthUser.email).thenReturn(tEmail);
        when(() => mockAuthUser.displayName).thenReturn('Auth Name');

        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => Right(tUserModel));

        when(
          () => mockNotificationService.getFcmToken(),
        ).thenAnswer((_) async => tFcmToken);

        when(
          () => mockFeedbackRepository.submitFeedback(any()),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await useCase(tMessage);

        // assert
        expect(result, const Right(null));
        verify(
          () => mockFeedbackRepository.submitFeedback(
            any(
              that: isA<FeedbackModel>()
                  .having((m) => m.isSubscribed, 'isSubscribed', true)
                  .having(
                    (m) => m.notificationsEnabled,
                    'notificationsEnabled',
                    true,
                  )
                  .having((m) => m.userName, 'userName', 'Test User')
                  .having((m) => m.fcmToken, 'fcmToken', tFcmToken),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'call_userProfileFetchFails_fallsBackToAuthDefaultsAndReturnsSuccess',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(mockAuthUser);
        when(() => mockAuthUser.id).thenReturn(tUserId);
        when(() => mockAuthUser.email).thenReturn(tEmail);
        when(() => mockAuthUser.displayName).thenReturn('Auth Name');

        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => const Left(Failure.server('Error')));

        when(
          () => mockNotificationService.getFcmToken(),
        ).thenAnswer((_) async => tFcmToken);

        when(
          () => mockFeedbackRepository.submitFeedback(any()),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await useCase(tMessage);

        // assert
        expect(result, const Right(null));
        verify(
          () => mockFeedbackRepository.submitFeedback(
            any(
              that: isA<FeedbackModel>()
                  .having((m) => m.isSubscribed, 'isSubscribed', false)
                  .having(
                    (m) => m.notificationsEnabled,
                    'notificationsEnabled',
                    false,
                  )
                  .having((m) => m.userName, 'userName', 'Auth Name'),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'call_fcmTokenFetchFails_proceedsWithNullTokenAndReturnsSuccess',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(mockAuthUser);
        when(() => mockAuthUser.id).thenReturn(tUserId);
        when(() => mockAuthUser.email).thenReturn(tEmail);
        when(() => mockAuthUser.displayName).thenReturn('Auth Name');

        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => Right(tUserModel));

        when(
          () => mockNotificationService.getFcmToken(),
        ).thenThrow(Exception('FCM Error'));

        when(
          () => mockFeedbackRepository.submitFeedback(any()),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await useCase(tMessage);

        // assert
        expect(result, const Right(null));
        verify(
          () => mockFeedbackRepository.submitFeedback(
            any(
              that: isA<FeedbackModel>().having(
                (m) => m.fcmToken,
                'fcmToken',
                isNull,
              ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
