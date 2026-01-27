import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_watchlist_params.freezed.dart';

@freezed
abstract class SyncWatchlistParams with _$SyncWatchlistParams {
  const factory SyncWatchlistParams({required List<String> activeTickers}) =
      _SyncWatchlistParams;
}
