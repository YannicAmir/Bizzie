import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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

class SyncWatchlistParams extends Equatable {
  final List<String> activeTickers;

  const SyncWatchlistParams({required this.activeTickers});

  @override
  List<Object?> get props => [activeTickers];
}
