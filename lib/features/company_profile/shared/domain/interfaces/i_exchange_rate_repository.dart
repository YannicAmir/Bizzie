import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IExchangeRateRepository {
  Future<
    Either<
      Failure,
      (({double multiplier, String targetCurrency}), CompanyProfileDataOrigin)
    >
  >
  getMultiplier({required String? reportedCurrency, required String ticker});
}
