import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveSeenWeeklyReportIdsUseCase
    implements UseCase<Either<Failure, Unit>, Set<String>> {
  final IReportsViewHistoryRepository _repository;

  SaveSeenWeeklyReportIdsUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(Set<String> ids) =>
      _repository.saveSeenWeeklyReportIds(ids);
}
