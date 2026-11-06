import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ICompanyFilingsRepository {
  Stream<Either<Failure, CompanyFilings>> getCompanyFilings(String ticker);
}
