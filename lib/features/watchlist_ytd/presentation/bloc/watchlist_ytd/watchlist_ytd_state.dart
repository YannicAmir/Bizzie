import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_ytd_state.freezed.dart';

@freezed
abstract class WatchlistYtdState with _$WatchlistYtdState {
  const factory WatchlistYtdState.initial() = _Initial;
  const factory WatchlistYtdState.loading() = _Loading;
  const factory WatchlistYtdState.loaded(
    Map<String, YtdPriceChange> changes,
  ) = WatchlistYtdLoaded;
  const factory WatchlistYtdState.failure(Failure failure) = _Failure;
}
