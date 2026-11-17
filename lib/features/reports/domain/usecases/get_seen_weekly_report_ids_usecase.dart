import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSeenWeeklyReportIdsUseCase
    implements SynchronousUseCase<Either<Failure, Set<String>>, NoParams> {
  final IReportsViewHistoryRepository _repository;

  GetSeenWeeklyReportIdsUseCase(this._repository);

  @override
  Either<Failure, Set<String>> call([NoParams? params]) =>
      _repository.getSeenWeeklyReportIds();
}
