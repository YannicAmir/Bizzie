import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/presentation/models/filing_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_state.freezed.dart';

@freezed
class ReportsState with _$ReportsState {
  const factory ReportsState.initial() = Initial;
  const factory ReportsState.loading() = Loading;
  const factory ReportsState.loaded(
    ReportsFeed feed, {
    DateTime? lastViewedReports,
    @Default([]) List<FilingViewModel> todaysFilings,
  }) = Loaded;
  const factory ReportsState.failure(String message) = ReportsFailure;
}
