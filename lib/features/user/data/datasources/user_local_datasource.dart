import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/user/data/interfaces/i_user_local_datasource.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('UserLocalDataSource');

@Injectable(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  final ILocalStorageService _storage;

  static const _kFavoriteSectorKey = StorageConstants.userFavoriteSector;

  UserLocalDataSource(this._storage);

  @override
  Future<void> cacheFavoriteSector(String sector) async {
    _logger.info('Caching favorite sector: $sector');
    await _storage.setString(_kFavoriteSectorKey, sector);
  }

  @override
  String? getCachedFavoriteSector() {
    final sector = _storage.getString(_kFavoriteSectorKey);
    _logger.info('Retrieved cached favorite sector: $sector');
    return sector;
  }
}
