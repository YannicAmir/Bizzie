import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/revenue_stats.dart';

@lazySingleton
class GetRevenueStatsUseCase
    implements UseCase<Either<Failure, RevenueStats>, String> {
  final IFinancialRepository _repository;

  GetRevenueStatsUseCase(this._repository);

  @override
  Future<Either<Failure, RevenueStats>> call(String ticker) {
    return _repository.getRevenueStats(ticker);
  }
}
