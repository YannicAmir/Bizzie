import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/eps_stats.dart';

abstract class IEpsRepository {
  Future<Either<Failure, EpsStats>> getEpsStats(String ticker);
}
