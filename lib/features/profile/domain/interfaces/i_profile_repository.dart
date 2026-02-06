import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IProfileRepository {
  Future<Either<Failure, String>> getSectorDescription(String sectorName);
  Future<Either<Failure, String>> getSectorDisplayName(String sectorName);
}
