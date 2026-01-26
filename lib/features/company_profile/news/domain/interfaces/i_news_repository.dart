import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

abstract class INewsRepository {
  Future<Either<Failure, CompanyNews>> getCompanyNews(String ticker);
}
