import 'package:bizzie/core/enums/data_origin.dart';

abstract class IBusinessFirestoreDataSource {
  Future<void> cacheProxyUrl(String ticker, String? url);
  Future<(String?, CompanyProfileDataOrigin)?> getCachedProxyUrl(String ticker);
}
