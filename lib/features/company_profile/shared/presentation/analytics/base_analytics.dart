import 'package:bizzie/core/enums/data_origin.dart';

abstract interface class CompanyProfileTabAnalyticsState {
  /// The stock ticker symbol.
  String get ticker;

  /// The name of the current screen/tab (Mandatory Rule).
  String get screenName;

  /// ISO8601 timestamp of the event (Mandatory Rule).
  String get timestamp;

  /// Total duration in seconds spent on the tab.
  int get viewDurationSec;

  /// Whether the data load was successful.
  bool get isSuccess;

  /// Time taken to load the data in milliseconds.
  int? get loadTimeMs;

  /// The origin of the data (API, DB, Cache).
  CompanyProfileDataOrigin? get dataSource;

  /// Returns a copy of the state with the updated duration.
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec);
}

/// Interface for all tab-specific feature trackers in the Company Profile.
abstract interface class CompanyProfileTabTracker<
  T extends CompanyProfileTabAnalyticsState
> {
  /// Logs a comprehensive summary of the tab view session.
  ///
  /// [isFinal] indicates if this is the end of the session (true) or an interim snapshot (false).
  Future<void> logViewSummary(T state, {required bool isFinal});
}
