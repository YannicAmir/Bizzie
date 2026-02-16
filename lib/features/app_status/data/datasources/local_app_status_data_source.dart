import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/features/app_status/domain/interfaces/i_local_app_status_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ILocalAppStatusDataSource)
class LocalAppStatusDataSource implements ILocalAppStatusDataSource {
  final SharedPreferences _prefs;

  LocalAppStatusDataSource(this._prefs);

  static const _keyCachedMinAppVersion = StorageConstants.cachedMinAppVersion;
  static const _keyCachedAppStoreLink = StorageConstants.cachedAppStoreLink;
  static const _keyCachedPlayStoreLink = StorageConstants.cachedPlayStoreLink;

  @override
  Future<void> cacheMinAppVersion(String version) async {
    await _prefs.setString(_keyCachedMinAppVersion, version);
  }

  @override
  String? getCachedMinAppVersion() {
    return _prefs.getString(_keyCachedMinAppVersion);
  }

  @override
  Future<void> cacheAppStoreLink(String url) async {
    await _prefs.setString(_keyCachedAppStoreLink, url);
  }

  @override
  String? getCachedAppStoreLink() {
    return _prefs.getString(_keyCachedAppStoreLink);
  }

  @override
  Future<void> cachePlayStoreLink(String url) async {
    await _prefs.setString(_keyCachedPlayStoreLink, url);
  }

  @override
  String? getCachedPlayStoreLink() {
    return _prefs.getString(_keyCachedPlayStoreLink);
  }
}
