import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_local_datasource.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ReportsLocalDataSource');

@Injectable(as: IReportsLocalDataSource)
class ReportsLocalDataSource implements IReportsLocalDataSource {
  static const String _kSeenWeeklyReportIdsKey =
      StorageConstants.reportsSeenWeeklyReportIds;
  static const String _kFeedViewCountKey =
      StorageConstants.reportsFeedTotalViews;

  final ILocalStorageService _storage;

  ReportsLocalDataSource(this._storage);

  @override
  String? getSeenWeeklyReportIds() =>
      _storage.getString(_kSeenWeeklyReportIdsKey);

  @override
  Future<void> setSeenWeeklyReportIds(String encoded) {
    _logger.info('Persisting seen weekly report IDs');
    return _storage.setString(_kSeenWeeklyReportIdsKey, encoded);
  }

  @override
  int? getFeedViewCount() => _storage.getInt(_kFeedViewCountKey);

  @override
  Future<void> setFeedViewCount(int count) {
    _logger.info('Persisting reports feed view count: $count');
    return _storage.setInt(_kFeedViewCountKey, count);
  }
}
