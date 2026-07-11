import 'package:bizzie/core/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/core/error/failures.dart';

part 'watchlist_state.freezed.dart';

@freezed
abstract class WatchlistState with _$WatchlistState {
  const factory WatchlistState.initial() = _Initial;
  const factory WatchlistState.loading() = _Loading;
  const factory WatchlistState.loaded(
    List<Company> companies, {
    @Default({}) Map<String, WatchlistEventStatus> events,
  }) = WatchlistLoaded;
  const factory WatchlistState.failure(Failure failure) = _Failure;
  const factory WatchlistState.success(String message) = _Success;
}
