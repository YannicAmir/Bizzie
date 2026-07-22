import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';

part 'reports_event.freezed.dart';

@freezed
sealed class ReportsEvent with _$ReportsEvent {
  const factory ReportsEvent.started({String? uid}) = Started;
  const factory ReportsEvent.refresh() = Refresh;
  const factory ReportsEvent.watchlistUpdated(List<String> tickers) =
      WatchlistUpdated;
  const factory ReportsEvent.reportsUpdated(
    Either<Failure, ReportsFeed> result,
  ) = ReportsUpdated;
  const factory ReportsEvent.viewed({
    required int unreadCount,
    required ReportsEntrySource entrySource,
    ReportsNotificationType? notificationType,
  }) = Viewed;
  const factory ReportsEvent.linkOpened({
    required String ticker,
    required String filingType,
  }) = LinkOpened;
  const factory ReportsEvent.summaryRequested({
    required String ticker,
    required String filingType,
    required bool isReady,
  }) = SummaryRequested;
  const factory ReportsEvent.summarizeLockedClicked({
    required String ticker,
    required String filingType,
  }) = SummarizeLockedClicked;
  const factory ReportsEvent.upcomingExpanded() = UpcomingExpanded;
  const factory ReportsEvent.upcomingCompanyClicked({required String ticker}) =
      UpcomingCompanyClicked;
  const factory ReportsEvent.ytdCompanyClicked({required String ticker}) =
      YtdCompanyClicked;
  const factory ReportsEvent.filingCardCompanyClicked({
    required String ticker,
  }) = FilingCardCompanyClicked;
  const factory ReportsEvent.emptyCtaClicked() = EmptyCtaClicked;
  const factory ReportsEvent.marketNewsArticleOpened({
    required String publisher,
    required String site,
  }) = MarketNewsArticleOpened;
  const factory ReportsEvent.marketNewsLoadFailed({required String error}) =
      MarketNewsLoadFailed;
  const factory ReportsEvent.activityUpdated(DateTime? lastViewedReports) =
      ActivityUpdated;
  const factory ReportsEvent.reset() = Reset;
}
