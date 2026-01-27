import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event.freezed.dart';

@freezed
class WatchlistEvent with _$WatchlistEvent {
  const factory WatchlistEvent.syncRequested() = SyncRequested;
  const factory WatchlistEvent.addRequested({
    required String ticker,
    String? name,
  }) = AddRequested;
  const factory WatchlistEvent.removeRequested(String ticker) = RemoveRequested;
  const factory WatchlistEvent.loadRequested() = LoadRequested;
  const factory WatchlistEvent.reset() = Reset;
}
