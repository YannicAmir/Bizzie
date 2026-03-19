import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/enums/data_origin.dart';

abstract class BusinessFirestoreDataSource {
  Future<void> cacheProxyUrl(String ticker, String? url);
  Future<(String?, CompanyProfileDataOrigin)?> getCachedProxyUrl(String ticker);
}

@LazySingleton(as: BusinessFirestoreDataSource)
class BusinessFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements BusinessFirestoreDataSource {
  BusinessFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'BusinessFirestoreDataSource');

  @override
  Future<void> cacheProxyUrl(String ticker, String? url) async {
    await saveToCache(
      getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'proxy',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
      {'url': url},
    );
  }

  @override
  Future<(String?, CompanyProfileDataOrigin)?> getCachedProxyUrl(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst<Map<String, dynamic>>(
      getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'proxy',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
    );
    if (res is result.CacheSuccess<Map<String, dynamic>>) {
      return (res.data['url'] as String?, res.origin);
    }
    return null;
  }
}
