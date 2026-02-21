import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/price_history.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';

abstract class IPriceRepository {
  Future<Either<Failure, (PriceHistory, CompanyProfileDataOrigin)>>
  getPriceHistory(String ticker);

  Future<Either<Failure, (List<HistoricalPriceEod>, CompanyProfileDataOrigin)>>
  getHistoricalEodPrices(String ticker);
}
