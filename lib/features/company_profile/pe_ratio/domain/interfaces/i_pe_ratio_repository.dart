import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/pe_ratio.dart';

abstract class IPeRatioRepository {
  Future<Either<Failure, List<PeRatio>>> getPeRatios(
    String ticker, {
    String period = 'annual',
  });
}
