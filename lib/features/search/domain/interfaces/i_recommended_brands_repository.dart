import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:dartz/dartz.dart';

abstract class IRecommendedBrandsRepository {
  Future<Either<Failure, List<Company>>> getBrandsBySector(String sector);
}
