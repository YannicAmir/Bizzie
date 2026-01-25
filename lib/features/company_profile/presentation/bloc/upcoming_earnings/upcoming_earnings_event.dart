import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_earnings_event.freezed.dart';

@freezed
sealed class UpcomingEarningsEvent with _$UpcomingEarningsEvent {
  const factory UpcomingEarningsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory UpcomingEarningsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
