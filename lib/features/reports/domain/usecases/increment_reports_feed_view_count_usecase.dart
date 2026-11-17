import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IncrementReportsFeedViewCountUseCase
    implements UseCase<Either<Failure, int>, NoParams> {
  final IReportsViewHistoryRepository _repository;

  IncrementReportsFeedViewCountUseCase(this._repository);

  @override
  Future<Either<Failure, int>> call([NoParams? params]) =>
      _repository.incrementFeedViewCount();
}
