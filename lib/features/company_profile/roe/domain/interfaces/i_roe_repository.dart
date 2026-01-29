import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/roe.dart';

abstract class IRoeRepository {
  Future<Either<Failure, List<Roe>>> getRoeMetrics(
    String ticker, {
    String period = 'annual',
  });
}
