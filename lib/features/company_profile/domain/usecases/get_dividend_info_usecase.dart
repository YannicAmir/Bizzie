import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_info.dart';

@lazySingleton
class GetDividendInfoUseCase
    implements UseCase<Either<Failure, DividendInfo>, String> {
  final IFinancialRepository _repository;

  GetDividendInfoUseCase(this._repository);

  @override
  Future<Either<Failure, DividendInfo>> call(String ticker) {
    return _repository.getDividendInfo(ticker);
  }
}
