import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_shares_repository.dart';
import '../models/share_stats.dart';

@lazySingleton
class GetSharesUseCase implements UseCase<Either<Failure, ShareStats>, String> {
  final ISharesRepository _repository;

  GetSharesUseCase(this._repository);

  @override
  Future<Either<Failure, ShareStats>> call(String ticker) async {
    return _repository.getShareStats(ticker);
  }
}
