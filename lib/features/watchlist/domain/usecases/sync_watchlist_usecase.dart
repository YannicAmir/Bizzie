import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/sync_watchlist_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncWatchlistUseCase implements UseCase<void, SyncWatchlistParams> {
  final IWatchlistRepository _repository;

  SyncWatchlistUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(SyncWatchlistParams params) async {
    return _repository.syncSubscriptions(params.activeTickers);
  }
}
