import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/fcps_stats.dart';

@lazySingleton
class GetFcpsStatsUseCase
    implements UseCase<Either<Failure, FcpsStats>, String> {
  final IFinancialRepository _repository;

  GetFcpsStatsUseCase(this._repository);

  @override
  Future<Either<Failure, FcpsStats>> call(String ticker) async {
    return _repository.getFcpsStats(ticker);
  }
}
