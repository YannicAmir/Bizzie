import 'dart:convert';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_local_datasource.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ReportsViewHistoryRepositoryImpl');

@LazySingleton(as: IReportsViewHistoryRepository)
class ReportsViewHistoryRepositoryImpl
    implements IReportsViewHistoryRepository {
  final IReportsLocalDataSource _localDataSource;

  ReportsViewHistoryRepositoryImpl(this._localDataSource);

  @override
  Either<Failure, Set<String>> getSeenWeeklyReportIds() {
    try {
      final stored = _localDataSource.getSeenWeeklyReportIds();
      if (stored == null) return const Right(<String>{});
      return Right((jsonDecode(stored) as List).cast<String>().toSet());
    } catch (e) {
      _logger.warning('Failed to decode stored seen weekly report IDs', e);
      return Left(Failure.cache(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSeenWeeklyReportIds(Set<String> ids) async {
    try {
      await _localDataSource.setSeenWeeklyReportIds(jsonEncode(ids.toList()));
      return const Right(unit);
    } catch (e) {
      _logger.severe('Failed to save seen weekly report IDs', e);
      return Left(Failure.cache(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> incrementFeedViewCount() async {
    try {
      final count = (_localDataSource.getFeedViewCount() ?? 0) + 1;
      await _localDataSource.setFeedViewCount(count);
      return Right(count);
    } catch (e) {
      _logger.severe('Failed to increment reports feed view count', e);
      return Left(Failure.cache(e.toString()));
    }
  }
}
