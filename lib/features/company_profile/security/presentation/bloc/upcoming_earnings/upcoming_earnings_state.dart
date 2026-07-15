import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';

part 'upcoming_earnings_state.freezed.dart';

@freezed
abstract class UpcomingEarningsState with _$UpcomingEarningsState {
  const factory UpcomingEarningsState.initial() = _Initial;
  const factory UpcomingEarningsState.loading() = _Loading;
  const factory UpcomingEarningsState.loaded(
    DateTime earningsDate, {
    required CompanyProfileDataOrigin dataSource,
    DateTime? lastUpdated,
  }) = UpcomingEarningsLoaded;
  const factory UpcomingEarningsState.empty() = _Empty;
  const factory UpcomingEarningsState.failure(Failure failure) = _Failure;
}
