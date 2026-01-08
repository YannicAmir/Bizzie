import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event.freezed.dart';

@freezed
class WatchlistEvent with _$WatchlistEvent {
  const factory WatchlistEvent.syncRequested() = _SyncRequested;
  const factory WatchlistEvent.addRequested(Company company) = _AddRequested;
  const factory WatchlistEvent.removeRequested(String ticker) =
      _RemoveRequested;
  const factory WatchlistEvent.loadRequested() = _LoadRequested;
}
