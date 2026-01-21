import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';

@lazySingleton
class GetHistoricalEodPricesUseCase
    implements UseCase<Either<Failure, List<HistoricalPriceEod>>, String> {
  final IPriceRepository _repository;

  GetHistoricalEodPricesUseCase(this._repository);

  @override
  Future<Either<Failure, List<HistoricalPriceEod>>> call(String params) async {
    return await _repository.getHistoricalEodPrices(params);
  }
}
