import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/services/onboarding_profile_builder.dart';
import 'package:bizzie/features/onboarding/domain/services/onboarding_watchlist_resolver.dart';
import 'package:bizzie/features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CompleteOnboardingUseCase
    implements
        UseCase<
          Either<Failure, OnboardingSaveOutcome>,
          CompleteOnboardingParams
        > {
  final IOnboardingRepository _repository;
  final IUserRepository _userRepository;
  final INotificationService _notificationService;
  final SubscribeToNotificationTopicsUseCase _subscribeToTopicsUseCase;
  final OnboardingProfileBuilder _profileBuilder;
  final OnboardingWatchlistResolver _watchlistResolver;
  final _logger = BizzieLogger('CompleteOnboardingUseCase');

  CompleteOnboardingUseCase(
    this._repository,
    this._userRepository,
    this._notificationService,
    this._subscribeToTopicsUseCase,
    this._profileBuilder,
    this._watchlistResolver,
  );

  @override
  Future<Either<Failure, OnboardingSaveOutcome>> call(
    CompleteOnboardingParams params,
  ) async {
    _logger.info('Starting onboarding completion for user ${params.uid}');

    if (params.hasExistingProfile) return _updateProfile(params);

    final existsResult = await _repository.userProfileExists(params.uid);
    return existsResult.fold(Left.new, (exists) async {
      if (!exists) return _createProfile(params);

      _logger.warning(
        'Profile already exists for user ${params.uid}; skipping onboarding write',
      );
      return const Right(OnboardingSaveOutcome.existingProfile);
    });
  }

  Future<Either<Failure, OnboardingSaveOutcome>> _updateProfile(
    CompleteOnboardingParams params,
  ) async {
    final fcmTokens = await _fcmTokensFor(params);
    final result = await _repository.updateOnboardingProfile(
      _profileBuilder.profileUpdate(uid: params.uid, data: params.data),
      awaitServerAck: params.awaitServerAck,
    );
    if (result.isRight()) await _saveFcmTokens(fcmTokens);
    return _completeWith(result, uid: params.uid, fcmTokens: fcmTokens);
  }

  Future<Either<Failure, OnboardingSaveOutcome>> _createProfile(
    CompleteOnboardingParams params,
  ) async {
    final fcmTokens = await _fcmTokensFor(params);
    final result = await _repository.saveUserProfile(
      _profileBuilder.newUser(
        uid: params.uid,
        data: await _withDefaultWatchlist(params.data),
        fcmTokens: fcmTokens,
      ),
      awaitServerAck: params.awaitServerAck,
    );
    return _completeWith(result, uid: params.uid, fcmTokens: fcmTokens);
  }

  Future<OnboardingData> _withDefaultWatchlist(OnboardingData data) async {
    final userSelectedCompanies = data.detectedCompanies;
    if (!_watchlistResolver.needsDefaults(userSelectedCompanies)) return data;

    final defaultsResult = await _repository.getSkipDefaults();
    return defaultsResult.fold(
      (failure) {
        _logger.warning(
          'Failed to load default watchlist (proceeding with user selection): ${failure.errorMessage}',
        );
        return data;
      },
      (defaults) => data.copyWith(
        detectedCompanies: _watchlistResolver.resolve(
          userSelectedCompanies: userSelectedCompanies,
          defaultWatchlist: defaults.defaultWatchlist,
        ),
      ),
    );
  }

  Future<Either<Failure, OnboardingSaveOutcome>> _completeWith(
    Either<Failure, void> result, {
    required String uid,
    required Map<String, String> fcmTokens,
  }) {
    return result.fold(
      (failure) async {
        _logger.severe('Failed to save user profile: ${failure.errorMessage}');
        return Left(failure);
      },
      (_) async {
        _logger.info('Onboarding completed successfully');
        if (fcmTokens.isNotEmpty) await _subscribeToSavedTopics(uid);
        return const Right(OnboardingSaveOutcome.saved);
      },
    );
  }

  Future<Map<String, String>> _fcmTokensFor(
    CompleteOnboardingParams params,
  ) async {
    if (!params.data.notificationsEnabled || params.deferNotificationSetup) {
      return {};
    }

    try {
      final deviceUuid = await _notificationService.getDeviceUuid();
      final fcmToken = await _notificationService.getFcmToken();
      return fcmToken == null ? {} : {deviceUuid: fcmToken};
    } on Exception catch (e) {
      _logger.warning('Failed to setup notifications (proceeding anyway)', e);
      return {};
    }
  }

  Future<void> _saveFcmTokens(Map<String, String> fcmTokens) async {
    for (final MapEntry(key: deviceId, value: token) in fcmTokens.entries) {
      final result = await _userRepository.updateNotificationSettings(
        true,
        deviceId: deviceId,
        token: token,
      );
      result.fold(
        (failure) => _logger.warning(
          'Failed to save FCM token (proceeding anyway): ${failure.errorMessage}',
        ),
        (_) => null,
      );
    }
  }

  Future<void> _subscribeToSavedTopics(String uid) async {
    final userResult = await _userRepository.getUser(uid);
    final result = await userResult.fold(
      (failure) async => Left<Failure, void>(failure),
      (user) =>
          _subscribeToTopicsUseCase(NotificationTopicsParams.fromUser(user)),
    );
    result.fold(
      (failure) => _logger.warning(
        'Failed to setup notifications (proceeding anyway): ${failure.errorMessage}',
      ),
      (_) => null,
    );
  }
}
