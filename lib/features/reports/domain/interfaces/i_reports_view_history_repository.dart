import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IReportsViewHistoryRepository {
  Either<Failure, Set<String>> getSeenWeeklyReportIds();

  Future<Either<Failure, Unit>> saveSeenWeeklyReportIds(Set<String> ids);

  Future<Either<Failure, int>> incrementFeedViewCount();
}
