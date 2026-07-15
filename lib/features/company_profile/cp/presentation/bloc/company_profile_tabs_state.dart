import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tabs_state.freezed.dart';

@freezed
abstract class CompanyProfileTabsState with _$CompanyProfileTabsState {
  const factory CompanyProfileTabsState.initial({
    @Default(TabLayout.freeDefaultMainTabs) List<CompanyProfileTab> mainTabs,
    @Default(TabLayout.freeDefaultMoreTabs) List<CompanyProfileTab> moreTabs,
    @Default(TabLayout.freeDefaultBizziePlusTabs)
    List<CompanyProfileTab> bizziePlusTabs,
    @Default(0) int moreTabIndex,
    @Default(false) bool isBizzieChatEnabled,
    @Default(false) bool isSubscribed,
  }) = _Initial;

  const factory CompanyProfileTabsState.loaded({
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    @Default(<CompanyProfileTab>[]) List<CompanyProfileTab> bizziePlusTabs,
    @Default(0) int moreTabIndex,
    required bool isBizzieChatEnabled,
    required bool isSubscribed,
  }) = CompanyProfileTabsLoaded;

  const CompanyProfileTabsState._();

  List<CompanyProfileTab> get tabs => [
    CompanyProfileTab.security,
    ...mainTabs,
    CompanyProfileTab.more,
  ];
}

extension TabLayoutToState on TabLayout {
  CompanyProfileTabsState toTabsState({
    required bool isBizzieChatEnabled,
    required bool isSubscribed,
  }) => CompanyProfileTabsState.loaded(
    mainTabs: mainTabs,
    moreTabs: moreTabs,
    bizziePlusTabs: bizziePlusTabs,
    isBizzieChatEnabled: isBizzieChatEnabled,
    isSubscribed: isSubscribed,
  );
}
