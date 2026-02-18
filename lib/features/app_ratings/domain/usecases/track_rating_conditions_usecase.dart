import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/interfaces/i_app_ratings_repository.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('TrackRatingConditionsUseCase');

@injectable
class TrackRatingConditionsUseCase
    implements UseCase<Either<Failure, bool>, NoParams> {
  final IAppRatingsRepository _repository;
  final IConfigService _configService;

  static const int kMaxAttempts = 1;

  TrackRatingConditionsUseCase(this._repository, this._configService);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      await _repository.incrementInteractionCount();
      final currentInteractions = await _repository.getInteractionCount();
      _logger.info(
        'Interaction incremented. Current interactions: $currentInteractions',
      );

      final attempts = await _repository.getPromptAttempts();
      if (attempts >= kMaxAttempts) {
        _logger.info(
          'Skipping evaluation: Max attempts reached ($attempts/$kMaxAttempts).',
        );
        return const Right(false);
      }

      final shouldPrompt = await _evaluatePromptConditions(
        currentInteractions,
        attempts,
      );

      if (shouldPrompt) {
        _logger.info(
          'Prompt conditions met (interactions: $currentInteractions). Incrementing attempts.',
        );
        await _repository.incrementPromptAttempts();
        return const Right(true);
      }

      _logger.info(
        'No prompt conditions met (interactions: $currentInteractions).',
      );
      return const Right(false);
    } catch (e, s) {
      _logger.severe('Unexpected failure during rating tracking', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  Future<bool> _evaluatePromptConditions(int interactions, int attempts) async {
    final threshold = _configService.reviewPromptEventCount;

    _logger.info(
      'interactions=$interactions, attempts=$attempts, threshold=$threshold',
    );

    if (interactions >= threshold && attempts == 0) {
      _logger.info(
        'First threshold met ($interactions >= $threshold). Ready to prompt.',
      );
      return true;
    }

    return false;
  }
}
