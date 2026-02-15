import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/services/app_info_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart' as domain;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetSettingsDisplayDataUseCase');

@lazySingleton
class GetSettingsDisplayDataUseCase
    implements UseCase<Either<Failure, SettingsDisplayData>, NoParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final ISubscriptionRepository _subscriptionRepository;
  final IAppInfoService _appInfoService;
  final INotificationService _notificationService;
  final IConfigService _configService;

  GetSettingsDisplayDataUseCase(
    this._authRepository,
    this._userRepository,
    this._subscriptionRepository,
    this._appInfoService,
    this._notificationService,
    this._configService,
  );

  @override
  Future<Either<Failure, SettingsDisplayData>> call(NoParams params) async {
    _logger.info('Fetching Settings Display Data');

    final user = _authRepository.currentUser;
    if (user == null) {
      _logger.warning('User not found in cache');
      return const Left(CacheFailure('User not found'));
    }

    final (userRes, subRes, appVersion, isSystemAuthorized) = await (
      _userRepository.getUser(user.id),
      _subscriptionRepository.getSubscriptionStatus(),
      _getAppVersionSafe(),
      _notificationService.isSystemAuthorized(),
    ).wait;

    return _aggregateData((userRes, subRes, appVersion, isSystemAuthorized));
  }

  Future<String> _getAppVersionSafe() async {
    try {
      return await _appInfoService.getAppVersion();
    } catch (e) {
      _logger.warning('Failed to fetch app version', e);
      return 'Unknown';
    }
  }

  Either<Failure, SettingsDisplayData> _aggregateData(
    (
      Either<Failure, domain.UserModel>,
      Either<Failure, SubscriptionStatus>,
      String,
      bool,
    )
    results,
  ) {
    final (userRes, subRes, appVersion, isSystemAuthorized) = results;

    return userRes.fold(
      (f) {
        _logger.severe('Failed to fetch user', f);
        return Left(f);
      },
      (user) {
        final safeSubStatus = subRes.fold((f) {
          _logger.warning(
            'Failed to fetch subscription status (using default)',
            f,
          );
          return SubscriptionStatus.initial();
        }, (s) => s);

        _logger.info('Successfully aggregated settings data');
        return Right(
          SettingsDisplayData(
            user: user,
            subscriptionStatus: safeSubStatus,
            isAppNotificationsEnabled: user.notificationsEnabled,
            isSystemNotificationsEnabled: isSystemAuthorized,
            appVersion: appVersion,
            favoriteSector: user.favoriteSector,
            privacyPolicyUrl: _configService.privacyPolicyUrl,
            termsOfServiceUrl: _configService.termsOfServiceUrl,
          ),
        );
      },
    );
  }
}
