import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompleteOnboardingUseCase
    implements UseCase<Either<Failure, void>, CompleteOnboardingParams> {
  final IOnboardingRepository _repository;
  final INotificationService _notificationService;
  final _logger = BizzieLogger('CompleteOnboardingUseCase');

  CompleteOnboardingUseCase(this._repository, this._notificationService);

  @override
  Future<Either<Failure, void>> call(CompleteOnboardingParams params) async {
    Map<String, String> tokensMap = {};

    try {
      _logger.info('Starting onboarding completion for user ${params.uid}');

      if (params.data.notificationsEnabled) {
        final deviceUuid = await _notificationService.getDeviceUuid();
        final fcmToken = await _notificationService.getFcmToken();

        if (fcmToken != null) {
          tokensMap[deviceUuid] = fcmToken;
          await _subscribeToTopics(params.data);
        }
      }
    } catch (e) {
      _logger.warning('Failed to setup notifications (proceeding anyway)', e);
    }

    final user = UserModel(
      uid: params.uid,
      name: params.data.firstName,
      favoriteSector: StringUtils.sanitizeTopic(
        params.data.selectedSector?.displayName ?? '',
      ),
      favoriteSectorDisplay: params.data.selectedSector?.displayName ?? '',
      watchlist: params.data.detectedCompanies
          .map((c) => Company(ticker: c.ticker, name: c.name))
          .toList(),
      investingExperience:
          params.data.investingExperience ?? InvestingExperience.beginner,
      createdAt: DateTime.now(),
      isSubscribed: false,
      notificationsEnabled: params.data.notificationsEnabled,
      fcmTokens: tokensMap,
    );

    final result = await _repository.saveUserProfile(user);

    return result.fold(
      (failure) {
        _logger.severe('Failed to save user profile: ${failure.message}');
        return Left(failure);
      },
      (_) {
        _logger.info('Onboarding completed successfully');
        return const Right(null);
      },
    );
  }

  Future<void> _subscribeToTopics(OnboardingData data) async {
    final selectedSector = data.selectedSector;
    if (selectedSector != null) {
      final sanitizedSector = StringUtils.sanitizeTopic(
        selectedSector.displayName,
      );
      if (sanitizedSector.isNotEmpty) {
        await _notificationService.subscribeToTopic(sanitizedSector);
      }
    }

    for (final company in data.detectedCompanies) {
      final sanitizedTicker = StringUtils.sanitizeTicker(company.ticker);
      if (sanitizedTicker.isNotEmpty) {
        await _notificationService.subscribeToTopic(sanitizedTicker);
      }
    }
  }
}
