import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/price_history.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';

abstract class IPriceRepository {
  Future<Either<Failure, PriceHistory>> getPriceHistory(String ticker);

  Future<Either<Failure, List<HistoricalPriceEod>>> getHistoricalEodPrices(
    String ticker,
  );
}
