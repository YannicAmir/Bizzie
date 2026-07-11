import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';

abstract class IDividendsFirestoreDataSource {
  Future<result.CacheResult<List<DividendDto>>> syncDividends(
    String ticker, {
    required Future<List<DividendDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<DividendDto>, CompanyProfileDataOrigin)?> getCachedDividends(
    String ticker,
  );
}
