import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IWatchlistEventsRepository {
  Future<Either<Failure, Map<String, WatchlistEventStatus>>> getWatchlistEvents(
    List<String> tickers,
  );
}
