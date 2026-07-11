import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/news/data/dtos/news_dto.dart';

abstract class INewsFirestoreDataSource {
  Future<result.CacheResult<List<NewsDto>>> syncStockNews(
    String ticker, {
    required Future<List<NewsDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<NewsDto>, CompanyProfileDataOrigin)?> getCachedStockNews(
    String ticker,
  );
}
