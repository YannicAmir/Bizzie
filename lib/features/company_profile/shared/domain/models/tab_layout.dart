import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_layout.freezed.dart';

@freezed
abstract class TabLayout with _$TabLayout {
  const factory TabLayout({
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
  }) = _TabLayout;

  const TabLayout._();

  static const int minMainTabs = 4;
  static const int maxMainTabs = 12;

  static const List<CompanyProfileTab> pinnedTabs = [
    CompanyProfileTab.security,
    CompanyProfileTab.more,
  ];

  static List<CompanyProfileTab> sanitise(List<CompanyProfileTab> tabs) =>
      tabs.where((tab) => !pinnedTabs.contains(tab)).toList();

  static List<CompanyProfileTab> reconcileMoreTabs(
    List<CompanyProfileTab> mainTabs,
    List<CompanyProfileTab> moreTabs,
  ) {
    final mainSet = mainTabs.toSet();
    final visible = sanitise(
      moreTabs,
    ).where((tab) => !mainSet.contains(tab)).toList();
    final known = {...mainSet, ...visible, ...pinnedTabs};
    return [
      ...visible,
      ...CompanyProfileTab.values.where((tab) => !known.contains(tab)),
    ];
  }

  static bool isValidMainTabCount(int mainTabCount) {
    final totalIncludingSecurity = mainTabCount + 1;
    return totalIncludingSecurity >= minMainTabs &&
        totalIncludingSecurity <= maxMainTabs;
  }

  static const List<CompanyProfileTab> defaultMainTabs = [
    CompanyProfileTab.chat,
    CompanyProfileTab.business,
    CompanyProfileTab.segments,
    CompanyProfileTab.revenue,
    CompanyProfileTab.netIncome,
    CompanyProfileTab.freeCash,
  ];

  static const List<CompanyProfileTab> defaultMoreTabs = [
    CompanyProfileTab.news,
    CompanyProfileTab.financialStatements,
    CompanyProfileTab.dividends,
    CompanyProfileTab.eps,
    CompanyProfileTab.fcps,
    CompanyProfileTab.shares,
    CompanyProfileTab.roe,
    CompanyProfileTab.peRatio,
    CompanyProfileTab.pfcfRatio,
  ];

  factory TabLayout.defaults() => const TabLayout(
    mainTabs: defaultMainTabs,
    moreTabs: defaultMoreTabs,
  );
}
