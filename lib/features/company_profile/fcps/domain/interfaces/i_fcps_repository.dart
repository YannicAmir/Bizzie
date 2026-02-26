import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../models/fcps_stats.dart';

abstract class IFcpsRepository {
  Future<Either<Failure, (FcpsStats, CompanyProfileDataOrigin)>> getFcpsStats(
    String ticker,
  );
}
