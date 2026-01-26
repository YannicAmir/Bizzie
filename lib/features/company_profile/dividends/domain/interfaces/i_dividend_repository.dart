import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/dividend_info.dart';

abstract class IDividendRepository {
  Future<Either<Failure, DividendInfo>> getDividendInfo(String ticker);
}
