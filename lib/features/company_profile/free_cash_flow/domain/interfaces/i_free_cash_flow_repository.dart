import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../models/free_cash_flow_stats.dart';

abstract class IFreeCashFlowRepository {
  Future<Either<Failure, FreeCashFlowStats>> getFreeCashFlowStats(
    String ticker,
  );
}
