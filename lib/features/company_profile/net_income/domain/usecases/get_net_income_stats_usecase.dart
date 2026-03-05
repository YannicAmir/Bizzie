import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart';
import '../models/net_income_stats.dart';

@lazySingleton
class GetNetIncomeStatsUseCase
    implements
        UseCase<
          Either<Failure, (NetIncomeStats, CompanyProfileDataOrigin)>,
          String
        > {
  final INetIncomeRepository _repository;

  GetNetIncomeStatsUseCase(this._repository);

  @override
  Future<Either<Failure, (NetIncomeStats, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) {
    return _repository.getNetIncomeStats(ticker);
  }
}
