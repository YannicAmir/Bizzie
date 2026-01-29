import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/eps/domain/interfaces/i_eps_repository.dart';
import '../models/eps_stats.dart';

@lazySingleton
class GetEpsStatsUseCase implements UseCase<Either<Failure, EpsStats>, String> {
  final IEpsRepository _repository;

  GetEpsStatsUseCase(this._repository);

  @override
  Future<Either<Failure, EpsStats>> call(String ticker) {
    return _repository.getEpsStats(ticker);
  }
}
