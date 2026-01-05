import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserLocalDataSource {
  Future<void> cacheFavoriteSector(String sector);
  String? getCachedFavoriteSector();
}

@Injectable(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  final SharedPreferences _prefs;

  static const _kFavoriteSectorKey = 'user_favorite_sector';

  UserLocalDataSource(this._prefs);

  @override
  Future<void> cacheFavoriteSector(String sector) async {
    await _prefs.setString(_kFavoriteSectorKey, sector);
  }

  @override
  String? getCachedFavoriteSector() {
    return _prefs.getString(_kFavoriteSectorKey);
  }
}
