import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ToggleNotificationsUseCase');

@lazySingleton
class ToggleNotificationsUseCase
    implements UseCase<Either<Failure, void>, bool> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final INotificationService _notificationService;

  ToggleNotificationsUseCase(
    this._authRepository,
    this._userRepository,
    this._notificationService,
  );

  @override
  Future<Either<Failure, void>> call(bool enable) async {
    _logger.info(
      'Executing ToggleNotificationsUseCase: Setting enable to $enable',
    );

    final authRes = _getAuthenticatedUserId();

    return await authRes.fold((failure) async => Left(failure), (userId) async {
      String? token;
      String? deviceId;

      if (enable) {
        try {
          token = await _notificationService.getFcmToken();
          deviceId = await _notificationService.getDeviceUuid();
          _logger.info(
            "Preemptive token fetch: ${token != null ? 'Success' : 'Failed'}",
          );
        } catch (e) {
          _logger.warning("Failed to fetch token during toggle on", e);
        }
      }

      return await _updateNotificationStatusInRepo(
        userId,
        enable,
        deviceId: deviceId,
        token: token,
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

  Future<Either<Failure, void>> _updateNotificationStatusInRepo(
    String userId,
    bool enable, {
    String? deviceId,
    String? token,
  }) async {
    final result = await _userRepository.updateNotificationSettings(
      enable,
      deviceId: deviceId,
      token: token,
    );

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
