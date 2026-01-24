import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/eps_stats.dart';

@lazySingleton
class GetEpsStatsUseCase implements UseCase<Either<Failure, EpsStats>, String> {
  final IFinancialRepository _repository;

  GetEpsStatsUseCase(this._repository);

  @override
  Future<Either<Failure, EpsStats>> call(String ticker) {
    return _repository.getEpsStats(ticker);
  }
}
