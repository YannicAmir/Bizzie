import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWatchlistUseCase
    implements UseCase<Stream<Either<Failure, List<Company>>>, String> {
  final IWatchlistRepository _repository;

  GetWatchlistUseCase(this._repository);

  @override
  Future<Stream<Either<Failure, List<Company>>>> call(String uid) async {
    return _repository.getWatchlistStream(uid);
  }
}
