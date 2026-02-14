import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/feedback/domain/models/feedback_model.dart';
import 'package:dartz/dartz.dart';

abstract class IFeedbackRepository {
  Future<Either<Failure, void>> submitFeedback(FeedbackModel feedback);
}
