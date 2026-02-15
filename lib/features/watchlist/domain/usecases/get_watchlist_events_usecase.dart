import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/i_watchlist_events_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWatchlistEventsUseCase
    implements
        UseCase<
          Either<Failure, Map<String, WatchlistEventStatus>>,
          List<String>
        > {
  final IWatchlistEventsRepository _repository;

  GetWatchlistEventsUseCase(this._repository);

  @override
  Future<Either<Failure, Map<String, WatchlistEventStatus>>> call(
    List<String> params,
  ) {
    return _repository.getWatchlistEvents(params);
  }
}
