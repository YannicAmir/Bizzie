abstract class ITabOrderLocalDataSource {
  String? getMainTabs();
  String? getMoreTabs();
  Future<void> setMainTabs(String encoded);
  Future<void> setMoreTabs(String encoded);
}
