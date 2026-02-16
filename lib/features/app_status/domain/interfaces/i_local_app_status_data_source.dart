abstract class ILocalAppStatusDataSource {
  Future<void> cacheMinAppVersion(String version);
  String? getCachedMinAppVersion();

  Future<void> cacheAppStoreLink(String url);
  String? getCachedAppStoreLink();

  Future<void> cachePlayStoreLink(String url);
  String? getCachedPlayStoreLink();
}
