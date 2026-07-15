import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import '../interfaces/i_pfcf_ratio_repository.dart';
import '../models/pfcf_ratio_stats.dart';
import '../services/pfcf_ratio_stats_service.dart';

@lazySingleton
class GetPfcfRatioUseCase
    implements
        UseCase<
          Either<Failure, (PfcfRatioStats, CompanyProfileDataOrigin)>,
          String
        > {
  final IPfcfRatioRepository _repository;
  final PfcfRatioStatsService _statsService;

  GetPfcfRatioUseCase(this._repository, this._statsService);

  @override
  Future<Either<Failure, (PfcfRatioStats, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) async {
    final result = await _repository.getPfcfRatios(ticker);
    return result.map((tuple) => (_statsService.compute(tuple.$1), tuple.$2));
  }
}
