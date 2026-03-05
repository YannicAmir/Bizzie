import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/dividend_info.dart';

abstract class IDividendRepository {
  Future<Either<Failure, (DividendInfo, CompanyProfileDataOrigin)>>
  getDividendInfo(String ticker);
}
