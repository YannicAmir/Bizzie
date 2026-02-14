import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_models;
import 'package:bizzie/features/feedback/domain/interfaces/i_feedback_repository.dart';
import 'package:bizzie/features/feedback/domain/models/feedback_model.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart'
    as user_models;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SubmitFeedbackUseCase');

@lazySingleton
class SubmitFeedbackUseCase implements UseCase<Either<Failure, void>, String> {
  final IFeedbackRepository _feedbackRepository;
  final IAuthRepository _authRepository;
  final INotificationService _notificationService;
  final IUserRepository _userRepository;

  SubmitFeedbackUseCase(
    this._feedbackRepository,
    this._authRepository,
    this._notificationService,
    this._userRepository,
  );

  @override
  Future<Either<Failure, void>> call(String message) async {
    // 1. Validate Input
    final validation = _validateInput(message);
    if (validation.isLeft()) {
      return validation.fold((l) => Left(l), (_) => const Right(null));
    }

    // 2. Get Authenticated User
    final authUser = _authRepository.currentUser;
    if (authUser == null) {
      _logger.severe('User not logged in during feedback submission');
      return const Left(Failure.userNotFound());
    }

    // 3. Gather Data (Parallel execution for performance)
    final results = await Future.wait([
      _getSafeUserProfile(authUser.id),
      _getSafeFcmToken(),
    ]);

    final userProfile = results[0] as user_models.UserModel?;
    final fcmToken = results[1] as String?;

    // 4. Create Model
    final feedback = _createFeedbackModel(
      authUser: authUser,
      userProfile: userProfile,
      message: message,
      fcmToken: fcmToken,
    );

    // 5. Submit
    return _feedbackRepository.submitFeedback(feedback);
  }

  Either<Failure, void> _validateInput(String message) {
    if (message.trim().isEmpty) {
      _logger.warning('Attempted to submit empty feedback');
      return const Left(Failure.server('Feedback cannot be empty'));
    }
    if (message.length > FeedbackModel.maxMessageLength) {
      _logger.warning('Attempted to submit feedback exceeding length limit');
      return const Left(Failure.server('Feedback is too long'));
    }
    return const Right(null);
  }

  Future<user_models.UserModel?> _getSafeUserProfile(String userId) async {
    final result = await _userRepository.getUser(userId);
    return result.fold((failure) {
      _logger.warning(
        'Failed to fetch full user profile: $failure. Using Auth defaults.',
      );
      return null;
    }, (userModel) => userModel);
  }

  Future<String?> _getSafeFcmToken() async {
    try {
      return await _notificationService.getFcmToken();
    } catch (e) {
      _logger.warning('Failed to get FCM token for feedback: $e');
      return null;
    }
  }

  FeedbackModel _createFeedbackModel({
    required auth_models.UserModel authUser,
    required user_models.UserModel? userProfile,
    required String message,
    required String? fcmToken,
  }) {
    String userName = 'Unknown';
    if (userProfile?.name.isNotEmpty ?? false) {
      userName = userProfile!.name;
    } else if (authUser.displayName != null &&
        authUser.displayName!.isNotEmpty) {
      userName = authUser.displayName!;
    }

    final isSubscribed = userProfile?.isSubscribed ?? false;
    final notificationsEnabled = userProfile?.notificationsEnabled ?? false;

    return FeedbackModel(
      userId: authUser.id,
      userName: userName,
      userEmail: authUser.email,
      message: message.trim(),
      fcmToken: fcmToken,
      isSubscribed: isSubscribed,
      notificationsEnabled: notificationsEnabled,
      timestamp: DateTime.now(),
    );
  }
}
