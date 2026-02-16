import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = BizzieLogger('UserLocalDataSource');

abstract class IUserLocalDataSource {
  Future<void> cacheFavoriteSector(String sector);
  String? getCachedFavoriteSector();
}

@Injectable(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  final SharedPreferences _prefs;

  static const _kFavoriteSectorKey = StorageConstants.userFavoriteSector;

  UserLocalDataSource(this._prefs);

  @override
  Future<void> cacheFavoriteSector(String sector) async {
    _logger.info('Caching favorite sector: $sector');
    await _prefs.setString(_kFavoriteSectorKey, sector);
  }

  @override
  String? getCachedFavoriteSector() {
    final sector = _prefs.getString(_kFavoriteSectorKey);
    _logger.info('Retrieved cached favorite sector: $sector');
    return sector;
  }
}
