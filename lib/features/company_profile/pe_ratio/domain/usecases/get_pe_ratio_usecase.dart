import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import '../interfaces/i_pe_ratio_repository.dart';
import '../models/pe_ratio.dart';

@lazySingleton
class GetPeRatioUseCase
    implements
        UseCase<
          Either<Failure, (List<PeRatio>, CompanyProfileDataOrigin)>,
          String
        > {
  final IPeRatioRepository _repository;

  GetPeRatioUseCase(this._repository);

  @override
  Future<Either<Failure, (List<PeRatio>, CompanyProfileDataOrigin)>> call(
    String ticker,
  ) async {
    return _repository.getPeRatios(ticker);
  }
}
