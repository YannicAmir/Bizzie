import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_event.freezed.dart';

@freezed
class ReportsEvent with _$ReportsEvent {
  const factory ReportsEvent.started({String? uid}) = Started;
  const factory ReportsEvent.refresh() = Refresh;
  const factory ReportsEvent.watchlistUpdated(List<String> tickers) =
      WatchlistUpdated;
  const factory ReportsEvent.reportsUpdated(
    Either<Failure, ReportsFeed> result,
  ) = ReportsUpdated;
  const factory ReportsEvent.viewed() = Viewed;
  const factory ReportsEvent.activityUpdated(DateTime? lastViewedReports) =
      ActivityUpdated;
  const factory ReportsEvent.reset() = Reset;
}
