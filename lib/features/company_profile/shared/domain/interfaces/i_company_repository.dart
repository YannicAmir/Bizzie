import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';

abstract class ICompanyRepository {
  Future<Either<Failure, CompanyProfile>> getProfile(String ticker);
  Future<Either<Failure, StockQuote>> getQuote(String ticker);
}
