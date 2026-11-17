import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';

part 'reports_state.freezed.dart';

@freezed
abstract class ReportsState with _$ReportsState {
  const factory ReportsState.initial() = ReportsInitial;
  const factory ReportsState.loading() = ReportsLoading;
  const factory ReportsState.loaded(
    ReportsFeed feed, {
    required DateTime today,
    DateTime? lastViewedReports,
    @Default(<String>{}) Set<String> seenWeeklyReportIds,
    @Default([]) List<FilingViewModel> recentFilings,
    @Default([]) List<WeeklyReport> recentWeeklyReports,
    @Default([]) List<WeeklyReport> todaysWeeklyReports,
  }) = ReportsLoaded;
  const factory ReportsState.failure(Failure failure) = ReportsFailure;
}
