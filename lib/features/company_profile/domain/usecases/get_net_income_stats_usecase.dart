import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/net_income_stats.dart';

@lazySingleton
class GetNetIncomeStatsUseCase
    implements UseCase<Either<Failure, NetIncomeStats>, String> {
  final IFinancialRepository _repository;

  GetNetIncomeStatsUseCase(this._repository);

  @override
  Future<Either<Failure, NetIncomeStats>> call(String ticker) {
    return _repository.getNetIncomeStats(ticker);
  }
}
