import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';

part 'upcoming_earnings_state.freezed.dart';

@freezed
class UpcomingEarningsState with _$UpcomingEarningsState {
  const factory UpcomingEarningsState.initial() = _Initial;
  const factory UpcomingEarningsState.loading() = _Loading;
  const factory UpcomingEarningsState.loaded(
    DateTime earningsDate, {
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory UpcomingEarningsState.empty() = _Empty;
  const factory UpcomingEarningsState.failure(Failure failure) = _Failure;
}
