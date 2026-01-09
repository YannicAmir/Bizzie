import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event.freezed.dart';

@freezed
class WatchlistEvent with _$WatchlistEvent {
  const factory WatchlistEvent.syncRequested() = SyncRequested;
  const factory WatchlistEvent.addRequested(Company company) = AddRequested;
  const factory WatchlistEvent.removeRequested(String ticker) = RemoveRequested;
  const factory WatchlistEvent.loadRequested() = LoadRequested;
}
