import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import '../interfaces/i_pfcf_ratio_repository.dart';
import '../models/pfcf_ratio.dart';

@lazySingleton
class GetPfcfRatioUseCase
    implements
        UseCase<
          Either<Failure, (List<PfcfRatio>, CompanyProfileDataOrigin)>,
          String
        > {
  final IPfcfRatioRepository _repository;

  GetPfcfRatioUseCase(this._repository);

  @override
  Future<Either<Failure, (List<PfcfRatio>, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) async {
    return _repository.getPfcfRatios(ticker);
  }
}
