import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/interfaces/i_app_ratings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('TrackRatingConditionsUseCase');

@injectable
class TrackRatingConditionsUseCase
    implements UseCase<Either<Failure, bool>, NoParams> {
  final IAppRatingsRepository _repository;

  static const int kFirstThreshold = 7;
  static const int kMaxAttempts = 1;

  TrackRatingConditionsUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      await _repository.incrementInteractionCount();

      if (await _hasReachedMaxAttempts()) {
        _logger.info('Skipping evaluation: Max attempts reached.');
        return const Right(false);
      }

      final shouldPrompt = await _evaluatePromptConditions();

      if (shouldPrompt) {
        _logger.info('Prompt conditions met. Incrementing attempts.');
        await _repository.incrementPromptAttempts();
        return const Right(true);
      }

      _logger.info('No prompt conditions met.');
      return const Right(false);
    } catch (e, s) {
      _logger.severe('Unexpected failure during rating tracking', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  Future<bool> _hasReachedMaxAttempts() async {
    final attempts = await _repository.getPromptAttempts();
    if (attempts >= kMaxAttempts) {
      _logger.info('Max rating attempts reached ($kMaxAttempts).');
      return true;
    }
    return false;
  }

  Future<bool> _evaluatePromptConditions() async {
    final interactions = await _repository.getInteractionCount();
    final attempts = await _repository.getPromptAttempts();

    _logger.info('interactions=$interactions, attempts=$attempts');

    if (interactions >= kFirstThreshold && attempts == 0) {
      _logger.info(
        'First threshold met ($interactions >= $kFirstThreshold). Ready to prompt.',
      );
      return true;
    }

    return false;
  }
}
