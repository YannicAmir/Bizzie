import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_state.freezed.dart';

@freezed
class WatchlistState with _$WatchlistState {
  const factory WatchlistState.initial() = _Initial;
  const factory WatchlistState.loading() = _Loading;
  const factory WatchlistState.loaded(List<Company> companies) = _Loaded;
  const factory WatchlistState.failure(String message) = _Failure;
  const factory WatchlistState.success(String message) = _Success;
}
