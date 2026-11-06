import 'package:bizzie/core/domain/interfaces/i_company_filings_repository.dart';
import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCompanyFilingsUseCase
    implements StreamUseCase<Either<Failure, CompanyFilings>, String> {
  final ICompanyFilingsRepository _repository;

  GetCompanyFilingsUseCase(this._repository);

  @override
  Stream<Either<Failure, CompanyFilings>> call(String ticker) {
    return _repository.getCompanyFilings(ticker);
  }
}
