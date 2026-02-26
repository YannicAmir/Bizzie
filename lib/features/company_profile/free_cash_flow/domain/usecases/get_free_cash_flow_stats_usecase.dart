import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../interfaces/i_free_cash_flow_repository.dart';
import '../models/free_cash_flow_stats.dart';

@lazySingleton
class GetFreeCashFlowStatsUseCase
    implements
        UseCase<
          Either<Failure, (FreeCashFlowStats, CompanyProfileDataOrigin)>,
          String
        > {
  final IFreeCashFlowRepository _repository;

  GetFreeCashFlowStatsUseCase(this._repository);

  @override
  Future<Either<Failure, (FreeCashFlowStats, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) {
    return _repository.getFreeCashFlowStats(ticker);
  }
}
