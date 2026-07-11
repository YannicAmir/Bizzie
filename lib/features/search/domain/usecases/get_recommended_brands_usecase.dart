import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/search/domain/interfaces/i_recommended_brands_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRecommendedBrandsUseCase
    implements UseCase<Either<Failure, List<Company>>, String> {
  final IRecommendedBrandsRepository _repository;

  GetRecommendedBrandsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Company>>> call(String sector) {
    return _repository.getBrandsBySector(sector);
  }
}
