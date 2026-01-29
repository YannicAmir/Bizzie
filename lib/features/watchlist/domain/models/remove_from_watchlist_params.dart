import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_from_watchlist_params.freezed.dart';

@freezed
abstract class RemoveFromWatchlistParams with _$RemoveFromWatchlistParams {
  const factory RemoveFromWatchlistParams({
    required String ticker,
    required String uid,
  }) = _RemoveFromWatchlistParams;
}
