import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:dartz/dartz.dart';

abstract class IReportsRepository {
  Stream<Either<Failure, ReportsFeed>> getReportsFeed(List<String> tickers);

  Stream<Either<Failure, UserActivity>> getUserActivityStream(String uid);

  Future<void> markReportsViewed(String uid, DateTime timestamp);
}
