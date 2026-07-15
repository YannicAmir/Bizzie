import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_events_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEnrichedWatchlistUseCase
    implements
        StreamUseCase<
          Either<Failure, (List<Company>, Map<String, WatchlistEventStatus>)>,
          String
        > {
  final GetWatchlistUseCase _getWatchlistUseCase;
  final GetWatchlistEventsUseCase _getWatchlistEventsUseCase;

  GetEnrichedWatchlistUseCase(
    this._getWatchlistUseCase,
    this._getWatchlistEventsUseCase,
  );

  @override
  Stream<Either<Failure, (List<Company>, Map<String, WatchlistEventStatus>)>>
  call(String uid) async* {
    final stream = await _getWatchlistUseCase(uid);

    yield* stream.asyncMap((result) async {
      return await result.fold((failure) async => Left(failure), (
        companies,
      ) async {
        final eventsResult = await _getWatchlistEventsUseCase(
          companies.map((c) => c.ticker).toList(),
        );
        return eventsResult.fold(
          (_) => Right((companies, <String, WatchlistEventStatus>{})),
          (events) => Right((companies, events)),
        );
      });
    });
  }
}
