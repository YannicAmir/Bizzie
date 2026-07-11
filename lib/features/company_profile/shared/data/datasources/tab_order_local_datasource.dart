import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_tab_order_local_datasource.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('TabOrderLocalDataSource');

@Injectable(as: ITabOrderLocalDataSource)
class TabOrderLocalDataSource implements ITabOrderLocalDataSource {
  static const String _kMainTabsKey = StorageConstants.companyProfileMainTabs;
  static const String _kMoreTabsKey = StorageConstants.companyProfileMoreTabs;

  final ILocalStorageService _storage;

  TabOrderLocalDataSource(this._storage);

  @override
  String? getMainTabs() => _storage.getString(_kMainTabsKey);

  @override
  String? getMoreTabs() => _storage.getString(_kMoreTabsKey);

  @override
  Future<void> setMainTabs(String encoded) {
    _logger.info('Persisting main tab order');
    return _storage.setString(_kMainTabsKey, encoded);
  }

  @override
  Future<void> setMoreTabs(String encoded) {
    _logger.info('Persisting more tab order');
    return _storage.setString(_kMoreTabsKey, encoded);
  }
}
