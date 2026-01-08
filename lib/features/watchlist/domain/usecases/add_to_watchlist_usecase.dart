import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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

class AddToWatchlistParams extends Equatable {
  final Company company;
  final String uid;

  const AddToWatchlistParams({required this.company, required this.uid});

  @override
  List<Object?> get props => [company, uid];
}
