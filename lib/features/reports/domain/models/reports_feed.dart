import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';

part 'reports_feed.freezed.dart';

@freezed
abstract class ReportsFeed with _$ReportsFeed {
  const factory ReportsFeed({
    @Default([]) List<FinancialReport> currentReports,
    @Default([]) List<FinancialReport> pastReports,
    @Default([]) List<SecFiling> filings,
    @Default([]) List<UpcomingEarnings> upcomingEarnings,
    @Default([]) List<WeeklyReport> weeklyReports,
  }) = _ReportsFeed;
}
