import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/roe.dart';

abstract class IRoeRepository {
  Future<Either<Failure, (List<Roe>, CompanyProfileDataOrigin)>> getRoeMetrics(
    String ticker, {
    String period = 'annual',
  });
}
