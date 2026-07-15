import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/roe/data/dtos/key_metrics_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_dto.dart';

abstract class IRatiosFirestoreDataSource {
  Future<result.CacheResult<List<RatiosDto>>> syncRatios(
    String ticker, {
    required bool isTtm,
    required Future<List<RatiosDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<RatiosDto>, CompanyProfileDataOrigin)?> getCachedRatios(
    String ticker, {
    required bool isTtm,
  });

  Future<result.CacheResult<List<KeyMetricsDto>>> syncKeyMetrics(
    String ticker, {
    required bool isTtm,
    required Future<List<KeyMetricsDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<KeyMetricsDto>, CompanyProfileDataOrigin)?> getCachedKeyMetrics(
    String ticker, {
    required bool isTtm,
  });
}
