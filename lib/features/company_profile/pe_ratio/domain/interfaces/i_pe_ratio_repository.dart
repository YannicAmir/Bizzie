import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/pe_ratio.dart';

abstract class IPeRatioRepository {
  Future<Either<Failure, (List<PeRatio>, CompanyProfileDataOrigin)>>
  getPeRatios(String ticker, {String period = 'annual'});
}
