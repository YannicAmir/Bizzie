import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';

abstract class ISecurityFirestoreDataSource {
  Future<result.CacheResult<List<HistoricalPriceDto>>> syncPrices(
    String ticker, {
    required Future<List<HistoricalPriceDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<HistoricalPriceDto>, CompanyProfileDataOrigin)?> getCachedPrices(
    String ticker,
  );

  Future<result.CacheResult<List<HistoricalPriceEodDto>>>
  syncHistoricalEodPrices(
    String ticker, {
    required Future<List<HistoricalPriceEodDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<HistoricalPriceEodDto>, CompanyProfileDataOrigin)?>
  getCachedHistoricalEodPrices(String ticker);

  Future<result.CacheResult<List<EarningsReportDto>>> syncEarningsReports(
    String ticker, {
    required Future<List<EarningsReportDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<EarningsReportDto>, CompanyProfileDataOrigin)?>
  getCachedEarningsReports(String ticker);
}
