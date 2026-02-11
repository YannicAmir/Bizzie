import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ToggleNotificationsUseCase');

@lazySingleton
class ToggleNotificationsUseCase
    implements UseCase<Either<Failure, void>, bool> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  ToggleNotificationsUseCase(this._authRepository, this._userRepository);

  @override
  Future<Either<Failure, void>> call(bool params) async {
    _logger.info(
      'Executing ToggleNotificationsUseCase: Setting enable to $params',
    );

    final authRes = _getAuthenticatedUserId();

    return await authRes.fold((failure) async => Left(failure), (userId) async {
      final fetchRes = await _fetchUserModel(userId);

      return await fetchRes.fold(
        (failure) async => Left(failure),
        (user) async => _updateNotificationStatusInRepo(user, params),
      );
    });
  }

  Either<Failure, String> _getAuthenticatedUserId() {
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      _logger.warning('Toggle failed: No current user found in session');
      return const Left(Failure.userNotFound());
    }
    return Right(currentUser.id);
  }

  Future<Either<Failure, UserModel>> _fetchUserModel(String userId) async {
    final result = await _userRepository.getUser(userId);
    if (result.isLeft()) {
      _logger.warning('Failed to fetch user model for notification toggle');
    }
    return result;
  }

  Future<Either<Failure, void>> _updateNotificationStatusInRepo(
    UserModel user,
    bool enable,
  ) async {
    final updatedUser = user.copyWith(notificationsEnabled: enable);
    final result = await _userRepository.updateUser(updatedUser);

    result.fold(
      (failure) => _logger.warning(
        'Failed to update notification settings in repository',
        failure,
      ),
      (_) => _logger.info('Successfully toggled notifications to: $enable'),
    );

    return result;
  }
}
