import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_roe_repository.dart';
import '../models/roe_stats.dart';
import '../services/roe_stats_service.dart';

@lazySingleton
class GetRoeUseCase
    implements
        UseCase<
          Either<Failure, (RoeStats, CompanyProfileDataOrigin)>,
          String
        > {
  final IRoeRepository _repository;
  final RoeStatsService _statsService;

  GetRoeUseCase(this._repository, this._statsService);

  @override
  Future<Either<Failure, (RoeStats, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) async {
    final result = await _repository.getRoeMetrics(ticker);
    return result.map((tuple) => (_statsService.compute(tuple.$1), tuple.$2));
  }
}
