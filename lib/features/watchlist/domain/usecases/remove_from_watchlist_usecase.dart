import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromWatchlistUseCase
    implements UseCase<void, RemoveFromWatchlistParams> {
  final IWatchlistRepository _repository;

  RemoveFromWatchlistUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RemoveFromWatchlistParams params) async {
    return _repository.removeFromWatchlist(params.ticker, params.uid);
  }
}

class RemoveFromWatchlistParams extends Equatable {
  final String ticker;
  final String uid;

  const RemoveFromWatchlistParams({required this.ticker, required this.uid});

  @override
  List<Object?> get props => [ticker, uid];
}
