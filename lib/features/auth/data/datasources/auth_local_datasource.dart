import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/data/interfaces/i_auth_local_datasource.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('AuthLocalDataSource');

@Injectable(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  final ILocalStorageService _storage;

  AuthLocalDataSource(this._storage);

  @override
  Future<void> clearAll() {
    _logger.info('Clearing all local preferences');
    return _storage.clear();
  }
}
