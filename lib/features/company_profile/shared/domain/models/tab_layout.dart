import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_layout.freezed.dart';

@freezed
abstract class TabLayout with _$TabLayout {
  const factory TabLayout({
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    @Default(<CompanyProfileTab>[]) List<CompanyProfileTab> bizziePlusTabs,
  }) = _TabLayout;

  const TabLayout._();

  static const int freeMinMainTabs = 4;
  static const int freeMaxMainTabs = 5;
  static const int freeMinMoreTabs = 2;
  static const int paidMinMainTabs = 3;
  static const int paidMaxMainTabs = 12;
  static const int paidMinMoreTabs = 3;

  static const List<CompanyProfileTab> pinnedTabs = [
    CompanyProfileTab.security,
    CompanyProfileTab.more,
  ];

  static int minMainTabsFor({required bool isSubscribed}) =>
      isSubscribed ? paidMinMainTabs : freeMinMainTabs;

  static int maxMainTabsFor({required bool isSubscribed}) =>
      isSubscribed ? paidMaxMainTabs : freeMaxMainTabs;

  static int minMoreTabsFor({required bool isSubscribed}) =>
      isSubscribed ? paidMinMoreTabs : freeMinMoreTabs;

  static List<CompanyProfileTab> sanitise(List<CompanyProfileTab> tabs) =>
      tabs.where((tab) => !pinnedTabs.contains(tab)).toList();

  static List<CompanyProfileTab> reconcileMoreTabs(
    List<CompanyProfileTab> mainTabs,
    List<CompanyProfileTab> moreTabs, {
    Set<CompanyProfileTab> excludedTabs = const {},
  }) {
    final mainSet = mainTabs.toSet();
    final visible = sanitise(moreTabs)
        .where((tab) => !mainSet.contains(tab) && !excludedTabs.contains(tab))
        .toList();
    final known = {...mainSet, ...visible, ...excludedTabs, ...pinnedTabs};
    return [
      ...visible,
      ...CompanyProfileTab.values.where((tab) => !known.contains(tab)),
    ];
  }

  static bool isValidMainTabCount(
    int mainTabCount, {
    required bool isSubscribed,
  }) {
    final totalIncludingSecurity = mainTabCount + 1;
    return totalIncludingSecurity >=
            minMainTabsFor(isSubscribed: isSubscribed) &&
        totalIncludingSecurity <= maxMainTabsFor(isSubscribed: isSubscribed);
  }

  static bool isValidMoreTabCount(
    int moreTabCount, {
    required bool isSubscribed,
  }) => moreTabCount >= minMoreTabsFor(isSubscribed: isSubscribed);

  static const List<CompanyProfileTab> freeDefaultMainTabs = [
    CompanyProfileTab.business,
    CompanyProfileTab.news,
    CompanyProfileTab.dividends,
    CompanyProfileTab.revenue,
  ];

  static const List<CompanyProfileTab> freeDefaultMoreTabs = [
    CompanyProfileTab.netIncome,
    CompanyProfileTab.eps,
  ];

  static const List<CompanyProfileTab> freeDefaultBizziePlusTabs = [
    CompanyProfileTab.chat,
    CompanyProfileTab.segments,
    CompanyProfileTab.freeCash,
    CompanyProfileTab.fcps,
    CompanyProfileTab.shares,
    CompanyProfileTab.financialStatements,
    CompanyProfileTab.roe,
    CompanyProfileTab.peRatio,
    CompanyProfileTab.pfcfRatio,
  ];

  static const List<CompanyProfileTab> paidDefaultMainTabs = [
    CompanyProfileTab.business,
    CompanyProfileTab.news,
    CompanyProfileTab.dividends,
    CompanyProfileTab.revenue,
    CompanyProfileTab.segments,
    CompanyProfileTab.netIncome,
    CompanyProfileTab.eps,
    CompanyProfileTab.freeCash,
    CompanyProfileTab.fcps,
    CompanyProfileTab.shares,
    CompanyProfileTab.financialStatements,
  ];

  static const List<CompanyProfileTab> paidDefaultMoreTabs = [
    CompanyProfileTab.roe,
    CompanyProfileTab.peRatio,
    CompanyProfileTab.pfcfRatio,
    CompanyProfileTab.chat,
  ];

  factory TabLayout.defaults({required bool isSubscribed}) => isSubscribed
      ? const TabLayout(
          mainTabs: paidDefaultMainTabs,
          moreTabs: paidDefaultMoreTabs,
        )
      : const TabLayout(
          mainTabs: freeDefaultMainTabs,
          moreTabs: freeDefaultMoreTabs,
          bizziePlusTabs: freeDefaultBizziePlusTabs,
        );
}
