import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/pfcf_ratio.dart';

abstract class IPfcfRatioRepository {
  Future<Either<Failure, List<PfcfRatio>>> getPfcfRatios(
    String ticker, {
    String period = 'annual',
  });
}
