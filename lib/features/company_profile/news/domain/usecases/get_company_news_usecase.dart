import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/news/domain/interfaces/i_news_repository.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

@lazySingleton
class GetCompanyNewsUseCase
    implements UseCase<Either<Failure, CompanyNews>, String> {
  final INewsRepository _repository;

  GetCompanyNewsUseCase(this._repository);

  @override
  Future<Either<Failure, CompanyNews>> call(String ticker) {
    return _repository.getCompanyNews(ticker);
  }
}
