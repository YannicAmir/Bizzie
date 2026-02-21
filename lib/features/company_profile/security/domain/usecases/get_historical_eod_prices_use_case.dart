import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/core/enums/data_origin.dart';

@lazySingleton
class GetHistoricalEodPricesUseCase
    implements
        UseCase<
          Either<Failure, (List<HistoricalPriceEod>, CompanyProfileDataOrigin)>,
          String
        > {
  final IPriceRepository _repository;

  GetHistoricalEodPricesUseCase(this._repository);

  @override
  Future<Either<Failure, (List<HistoricalPriceEod>, CompanyProfileDataOrigin)>>
  call(String ticker) {
    return _repository.getHistoricalEodPrices(ticker);
  }
}
