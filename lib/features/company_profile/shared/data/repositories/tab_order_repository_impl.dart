import 'package:bizzie/core/data/dtos/company_tabs_config.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
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
  final IConfigService _configService;

  TabOrderRepositoryImpl(this._localDataSource, this._configService);

  @override
  Either<Failure, TabLayout> getTabLayout({required bool isSubscribed}) {
    try {
      final defaults = _defaultLayout(isSubscribed: isSubscribed);
      final stored = _storedLayout(defaults, isSubscribed: isSubscribed);
      return Right(stored ?? defaults);
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

  TabLayout? _storedLayout(
    TabLayout defaults, {
    required bool isSubscribed,
  }) {
    final storedMain = _localDataSource.getMainTabs();
    final storedMore = _localDataSource.getMoreTabs();
    if (storedMain == null && storedMore == null) return null;

    final plusSet = defaults.bizziePlusTabs.toSet();
    final mainTabs = _without(
      storedMain == null ? defaults.mainTabs : _decode(storedMain),
      plusSet,
    );
    final moreTabs = TabLayout.reconcileMoreTabs(
      mainTabs,
      storedMore == null ? defaults.moreTabs : _decode(storedMore),
      excludedTabs: plusSet,
    );
    if (!_isValidForTier(mainTabs, moreTabs, isSubscribed: isSubscribed)) {
      _logger.warning(
        'Stored tab layout is invalid for the current tier, using defaults',
      );
      return null;
    }
    return TabLayout(
      mainTabs: mainTabs,
      moreTabs: moreTabs,
      bizziePlusTabs: defaults.bizziePlusTabs,
    );
  }

  TabLayout _defaultLayout({required bool isSubscribed}) {
    final config = _tierConfig(isSubscribed: isSubscribed);
    final bizziePlusTabs = isSubscribed
        ? const <CompanyProfileTab>[]
        : _tabsFromNames(config.bizziePlusTabs);
    final plusSet = bizziePlusTabs.toSet();
    final mainTabs = _without(_tabsFromNames(config.mainTabs), plusSet);
    final moreTabs = TabLayout.reconcileMoreTabs(
      mainTabs,
      _tabsFromNames(config.moreTabs),
      excludedTabs: plusSet,
    );
    if (!_isValidForTier(mainTabs, moreTabs, isSubscribed: isSubscribed)) {
      _logger.warning(
        'Remote tab config is invalid for the current tier, '
        'falling back to bundled defaults',
      );
      return TabLayout.defaults(isSubscribed: isSubscribed);
    }
    return TabLayout(
      mainTabs: mainTabs,
      moreTabs: moreTabs,
      bizziePlusTabs: bizziePlusTabs,
    );
  }

  CompanyTabsConfig _tierConfig({required bool isSubscribed}) => isSubscribed
      ? _configService.paidUsersCompanyTabsConfig
      : _configService.freeUsersCompanyTabsConfig;

  bool _isValidForTier(
    List<CompanyProfileTab> mainTabs,
    List<CompanyProfileTab> moreTabs, {
    required bool isSubscribed,
  }) =>
      TabLayout.isValidMainTabCount(
        mainTabs.length,
        isSubscribed: isSubscribed,
      ) &&
      TabLayout.isValidMoreTabCount(
        moreTabs.length,
        isSubscribed: isSubscribed,
      );

  List<CompanyProfileTab> _tabsFromNames(List<String> names) {
    final seen = <CompanyProfileTab>{};
    return TabLayout.sanitise(
      CompanyProfileTab.fromNames(names),
    ).where(seen.add).toList();
  }

  List<CompanyProfileTab> _without(
    List<CompanyProfileTab> tabs,
    Set<CompanyProfileTab> excludedTabs,
  ) => tabs.where((tab) => !excludedTabs.contains(tab)).toList();

  String _encode(List<CompanyProfileTab> tabs) =>
      tabs.map((t) => t.name).join(',');

  List<CompanyProfileTab> _decode(String encoded) {
    if (encoded.isEmpty) return [];
    final tabByName = CompanyProfileTab.values.asNameMap();
    final names = encoded.split(',');
    final tabs = names.map((name) => tabByName[name]).nonNulls.toList();
    if (tabs.length != names.length) {
      _logger.warning(
        'Skipped ${names.length - tabs.length} unknown stored tab name(s)',
      );
    }
    return TabLayout.sanitise(tabs);
  }
}
