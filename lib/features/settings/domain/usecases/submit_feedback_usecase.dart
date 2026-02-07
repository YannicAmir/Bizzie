import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// TODO: Implement actual feedback submission logic
@lazySingleton
class SubmitFeedbackUseCase implements UseCase<Either<Failure, void>, String> {
  SubmitFeedbackUseCase();

  @override
  Future<Either<Failure, void>> call(String params) async {
    // Placeholder for Feedback submission logic (e.g. API call or email)
    return const Right(null);
  }
}
