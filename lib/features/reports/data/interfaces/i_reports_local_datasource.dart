abstract class IReportsLocalDataSource {
  String? getSeenWeeklyReportIds();
  Future<void> setSeenWeeklyReportIds(String encoded);
  int? getFeedViewCount();
  Future<void> setFeedViewCount(int count);
}
