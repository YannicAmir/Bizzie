import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SubmitFeedbackUseCase');

@lazySingleton
class SubmitFeedbackUseCase implements UseCase<Either<Failure, void>, String> {
  SubmitFeedbackUseCase();

  @override
  Future<Either<Failure, void>> call(String feedback) async {
    _logger.info(
      'Executing SubmitFeedbackUseCase: Initiating feedback submission',
    );

    if (feedback.trim().isEmpty) {
      _logger.warning(
        'SubmitFeedbackUseCase failed: Feedback content is empty',
      );
      return Left(
        Failure.server(
          'Feedback cannot be empty. Please provide your thoughts.',
        ),
      );
    }

    return _processFeedbackSubmission(feedback);
  }

  Future<Either<Failure, void>> _processFeedbackSubmission(
    String feedback,
  ) async {
    try {
      // TODO: Implement actual feedback repository call (e.g., Firestore or External API)
      _logger.info('Feedback submission placeholder executed successfully');

      // Simulating successful submission for now as it's a placeholder
      _logger.info('Successfully submitted feedback');
      return const Right(null);
    } catch (e) {
      _logger.severe('Failed to submit feedback', e);
      return Left(
        Failure.server(
          'Could not submit feedback at this time. Please try again later.',
        ),
      );
    }
  }
}
