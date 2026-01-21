import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/free_cash_flow_stats.dart';

@lazySingleton
class GetFreeCashFlowStatsUseCase
    implements UseCase<Either<Failure, FreeCashFlowStats>, String> {
  final IFinancialRepository _repository;

  GetFreeCashFlowStatsUseCase(this._repository);

  @override
  Future<Either<Failure, FreeCashFlowStats>> call(String ticker) {
    return _repository.getFreeCashFlowStats(ticker);
  }
}
