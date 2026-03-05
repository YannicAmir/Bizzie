import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/net_income_stats.dart';

abstract class INetIncomeRepository {
  Future<Either<Failure, (NetIncomeStats, CompanyProfileDataOrigin)>>
  getNetIncomeStats(String ticker);
}
