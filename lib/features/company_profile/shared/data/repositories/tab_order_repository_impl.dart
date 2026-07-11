import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_tab_order_local_datasource.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_tab_order_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('TabOrderRepositoryImpl');

@LazySingleton(as: ITabOrderRepository)
class TabOrderRepositoryImpl implements ITabOrderRepository {
  final ITabOrderLocalDataSource _localDataSource;

  TabOrderRepositoryImpl(this._localDataSource);

  @override
  Either<Failure, TabLayout> getTabLayout() {
    try {
      return Right(
        TabLayout(mainTabs: _readMainTabs(), moreTabs: _readMoreTabs()),
      );
    } catch (e) {
      _logger.warning('Failed to decode stored tab layout', e);
      return Left(Failure.cache(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTabLayout(TabLayout layout) async {
    try {
      await _localDataSource.setMainTabs(_encode(layout.mainTabs));
      await _localDataSource.setMoreTabs(_encode(layout.moreTabs));
      return const Right(null);
    } catch (e) {
      _logger.severe('Failed to save tab layout', e);
      return Left(Failure.cache(e.toString()));
    }
  }

  List<CompanyProfileTab> _readMainTabs() {
    final stored = _localDataSource.getMainTabs();
    if (stored == null) return TabLayout.defaults().mainTabs;
    final tabs = _decode(stored);
    if (!TabLayout.isValidMainTabCount(tabs.length)) {
      return TabLayout.defaults().mainTabs;
    }
    return tabs;
  }

  List<CompanyProfileTab> _readMoreTabs() {
    final stored = _localDataSource.getMoreTabs();
    if (stored == null) return TabLayout.defaults().moreTabs;
    return _decode(stored);
  }

  String _encode(List<CompanyProfileTab> tabs) =>
      tabs.map((t) => t.name).join(',');

  List<CompanyProfileTab> _decode(String encoded) {
    if (encoded.isEmpty) return [];
    final tabs = encoded
        .split(',')
        .map(
          (name) => CompanyProfileTab.values.firstWhere((t) => t.name == name),
        )
        .toList();
    return TabLayout.sanitise(tabs);
  }
}
