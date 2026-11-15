import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/notifications/domain/usecases/check_notification_permission_usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:bizzie/features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('PersistNotificationGrantUseCase');

@lazySingleton
class PersistNotificationGrantUseCase
    implements UseCase<Either<Failure, bool>, NoParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final CheckNotificationPermissionUseCase _checkNotificationPermission;
  final ToggleNotificationsUseCase _toggleNotificationsUseCase;
  final SubscribeToNotificationTopicsUseCase _subscribeToTopicsUseCase;

  PersistNotificationGrantUseCase(
    this._authRepository,
    this._userRepository,
    this._checkNotificationPermission,
    this._toggleNotificationsUseCase,
    this._subscribeToTopicsUseCase,
  );

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final permissionResult = await _checkNotificationPermission(NoParams());
    return permissionResult.fold(Left.new, (isGranted) async {
      if (!isGranted) {
        _logger.info('Notification permission not granted; nothing to persist');
        return const Right(false);
      }
      return _persistGrant();
    });
  }

  Future<Either<Failure, bool>> _persistGrant() async {
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) return const Left(Failure.userNotFound());

    final toggleResult = await _toggleNotificationsUseCase(true);
    return toggleResult.fold(Left.new, (_) async {
      final userResult = await _userRepository.getUser(currentUser.id);
      return userResult.fold(Left.new, _subscribeToUserTopics);
    });
  }

  Future<Either<Failure, bool>> _subscribeToUserTopics(UserModel user) async {
    final result = await _subscribeToTopicsUseCase(
      NotificationTopicsParams.fromUser(user),
    );
    return result.map((_) => true);
  }
}
