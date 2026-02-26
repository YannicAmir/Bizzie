import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/pfcf_ratio.dart';

abstract class IPfcfRatioRepository {
  Future<Either<Failure, (List<PfcfRatio>, CompanyProfileDataOrigin)>>
  getPfcfRatios(String ticker, {String period = 'annual'});
}
