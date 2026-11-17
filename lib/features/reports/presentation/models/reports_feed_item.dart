import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_feed_item.freezed.dart';

@freezed
sealed class ReportsFeedItem with _$ReportsFeedItem {
  const ReportsFeedItem._();

  const factory ReportsFeedItem.filing(FilingViewModel viewModel) =
      ReportsFeedFilingItem;
  const factory ReportsFeedItem.weekly(WeeklyReport report) =
      ReportsFeedWeeklyItem;

  bool get isDated => map(
    filing: (item) => item.viewModel.filing.createdAt != null,
    weekly: (item) => item.report.reportDate != null,
  );

  DateTime? get sortDate => map(
    filing: (item) => item.viewModel.filing.createdAt,
    weekly: (item) => item.report.createdAt ?? item.report.reportDate,
  );
}
