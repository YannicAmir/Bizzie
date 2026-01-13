import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDashboardReportsUseCase
    implements StreamUseCase<Either<Failure, ReportsFeed>, List<String>> {
  final IReportsRepository _repository;

  GetDashboardReportsUseCase(this._repository);

  @override
  Stream<Either<Failure, ReportsFeed>> call(List<String> tickers) {
    return _repository.getReportsFeed(tickers);
  }
}
