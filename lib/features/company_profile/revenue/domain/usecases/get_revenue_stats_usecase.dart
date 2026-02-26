import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/revenue/domain/interfaces/i_revenue_repository.dart';
import 'package:bizzie/features/company_profile/revenue/domain/models/revenue_stats.dart';

@lazySingleton
class GetRevenueStatsUseCase
    implements
        UseCase<
          Either<Failure, (RevenueStats, CompanyProfileDataOrigin)>,
          String
        > {
  final IRevenueRepository _repository;

  GetRevenueStatsUseCase(this._repository);

  @override
  Future<Either<Failure, (RevenueStats, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) {
    return _repository.getRevenueStats(ticker);
  }
}
