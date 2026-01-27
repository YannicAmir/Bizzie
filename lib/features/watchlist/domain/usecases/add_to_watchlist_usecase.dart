import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/add_to_watchlist_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToWatchlistUseCase implements UseCase<void, AddToWatchlistParams> {
  final IWatchlistRepository _repository;

  AddToWatchlistUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AddToWatchlistParams params) async {
    return _repository.addToWatchlist(params.company, params.uid);
  }
}
