import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tabs_state.freezed.dart';

@freezed
abstract class CompanyProfileTabsState with _$CompanyProfileTabsState {
  const factory CompanyProfileTabsState.initial({
    @Default(TabLayout.defaultMainTabs) List<CompanyProfileTab> mainTabs,
    @Default(TabLayout.defaultMoreTabs) List<CompanyProfileTab> moreTabs,
    @Default(0) int moreTabIndex,
    @Default(false) bool isBizzieChatEnabled,
  }) = _Initial;

  const factory CompanyProfileTabsState.loaded({
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    @Default(0) int moreTabIndex,
    required bool isBizzieChatEnabled,
  }) = _Loaded;

  const CompanyProfileTabsState._();

  List<CompanyProfileTab> get tabs => [
    CompanyProfileTab.security,
    ...mainTabs,
    CompanyProfileTab.more,
  ];
}

extension TabLayoutToState on TabLayout {
  CompanyProfileTabsState toTabsState({required bool isBizzieChatEnabled}) =>
      CompanyProfileTabsState.loaded(
        mainTabs: mainTabs,
        moreTabs: moreTabs,
        isBizzieChatEnabled: isBizzieChatEnabled,
      );
}
