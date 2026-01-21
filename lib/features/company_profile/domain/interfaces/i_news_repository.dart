import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/company_news.dart';

abstract class INewsRepository {
  // Tab 3: News
  Future<Either<Failure, CompanyNews>> getCompanyNews(String ticker);
}
