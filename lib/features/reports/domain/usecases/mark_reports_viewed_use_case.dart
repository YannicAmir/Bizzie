import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkReportsViewedUseCase
    implements UseCase<Either<Failure, Unit>, MarkReportsViewedParams> {
  final IReportsRepository _repository;

  MarkReportsViewedUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(MarkReportsViewedParams params) =>
      _repository.markReportsViewed(params.uid, params.timestamp);
}
