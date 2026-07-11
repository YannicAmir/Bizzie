import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/edit_tabs_modal.dart';
import 'package:bizzie/features/company_profile/more/presentation/models/more_feature.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreTab extends StatefulWidget {
  final String ticker;
  final List<CompanyProfileTab> moreTabs;

  const MoreTab({super.key, required this.ticker, required this.moreTabs});

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> with AutomaticKeepAliveClientMixin {
  late final CompanyProfileBloc _profileBloc;
  late final CompanyProfileTabsBloc _tabsBloc;
  late List<MoreFeature> _features;

  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<CompanyProfileBloc>();
    _tabsBloc = context.read<CompanyProfileTabsBloc>();
    _features = _buildFeatures();
    if (_features.isNotEmpty) {
      final safeIdx = _tabsBloc.state.moreTabIndex.clamp(
        0,
        _features.length - 1,
      );
      _reportSubTabView(_features[safeIdx].analyticsName);
    }
    _activateMoreSection();
  }

  @override
  void didUpdateWidget(MoreTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.moreTabs != widget.moreTabs ||
        oldWidget.ticker != widget.ticker) {
      _features = _buildFeatures();
      _activateMoreSection();
    }
  }

  List<MoreFeature> _buildFeatures() =>
      widget.moreTabs.map(moreFeatureFromTab).toList();

  void _activateMoreSection() {
    if (widget.moreTabs.isEmpty) return;
    _tabsBloc.add(
      CompanyProfileTabsEvent.tabActivated(
        tab: CompanyProfileTab.more,
        ticker: widget.ticker,
      ),
    );
  }

  void _reportSubTabView(String subTabName) {
    _profileBloc.add(CompanyProfileEvent.tabViewed(tabName: subTabName));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_features.isEmpty) {
      return _MoreTabEmptyState(ticker: widget.ticker);
    }

    return BlocBuilder<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      buildWhen: (previous, current) =>
          previous.moreTabIndex != current.moreTabIndex,
      builder: (context, state) {
        final safeIndex = state.moreTabIndex.clamp(0, _features.length - 1);
        return Column(
          children: [
            Padding(
              padding: AppConstants.moreTabDropdownButtonPadding,
              child: AppDropdownButton(
                label: _features[safeIndex].label,
                onTap: () => _showSelectorModal(context, safeIndex),
              ),
            ),
            Expanded(child: _features[safeIndex].builder(widget.ticker)),
          ],
        );
      },
    );
  }

  void _showSelectorModal(BuildContext outerContext, int currentSelection) {
    final isSubscribed = context.read<UserBloc>().state.isSubscribed;

    showModalBottomSheet(
      context: outerContext,
      isScrollControlled: true,
      builder: (modalContext) {
        return AppBottomModal(
          title: 'Select Feature',
          builder: (_, scrollController) => _FeatureSelectorModalContent(
            scrollController: scrollController,
            features: _features,
            moreTabs: widget.moreTabs,
            currentSelection: currentSelection,
            isSubscribed: isSubscribed,
            onLockedItemTap: () =>
                _onLockedItemTapped(modalContext, outerContext),
            onItemSelected: (index) => _onItemSelected(modalContext, index),
            onEditTap: () => _onEditTapped(
              modalContext,
              outerContext,
              isSubscribed: isSubscribed,
            ),
          ),
        );
      },
    );
  }

  void _onLockedItemTapped(
    BuildContext modalContext,
    BuildContext outerContext,
  ) {
    Navigator.pop(modalContext);
    PaywallHelper.showBizzieChatPaywall(outerContext);
  }

  void _onItemSelected(BuildContext modalContext, int index) {
    _tabsBloc.add(
      CompanyProfileTabsEvent.moreTabIndexChanged(
        index: index,
        ticker: widget.ticker,
      ),
    );
    _reportSubTabView(_features[index].analyticsName);
    Navigator.pop(modalContext);
  }

  void _onEditTapped(
    BuildContext modalContext,
    BuildContext outerContext, {
    required bool isSubscribed,
  }) {
    _profileBloc.add(
      CompanyProfileEvent.editTabsOpened(isSubscribed: isSubscribed),
    );
    Navigator.pop(modalContext);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _openEditTabsModal(outerContext);
    });
  }

  void _openEditTabsModal(BuildContext context) {
    final tabsState = _tabsBloc.state;
    EditTabsModal.show(
      context,
      mainTabs: tabsState.mainTabs,
      moreTabs: tabsState.moreTabs,
      onSaved: (savedLayout) {
        _profileBloc.add(
          CompanyProfileEvent.tabOrderSaved(
            isSubscribed: this.context.read<UserBloc>().state.isSubscribed,
            mainTabs: savedLayout.mainTabs
                .map((tab) => tab.analyticsName)
                .toList(),
            moreTabs: savedLayout.moreTabs
                .map((tab) => tab.analyticsName)
                .toList(),
          ),
        );
        _tabsBloc.add(const CompanyProfileTabsEvent.tabOrderChanged());
      },
    );
  }
}

class _FeatureSelectorModalContent extends StatelessWidget {
  final ScrollController scrollController;
  final List<MoreFeature> features;
  final List<CompanyProfileTab> moreTabs;
  final int currentSelection;
  final bool isSubscribed;
  final VoidCallback onLockedItemTap;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onEditTap;

  const _FeatureSelectorModalContent({
    required this.scrollController,
    required this.features,
    required this.moreTabs,
    required this.currentSelection,
    required this.isSubscribed,
    required this.onLockedItemTap,
    required this.onItemSelected,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: features.length,
            itemBuilder: (context, index) {
              final item = features[index];
              final isSelected = index == currentSelection;
              final isChatTab = moreTabs[index] == CompanyProfileTab.chat;
              final isLocked = isChatTab && !isSubscribed;

              return AppModalListItem(
                label: item.label,
                isSelected: isSelected,
                suffix: isLocked
                    ? SvgPicture.asset(
                        AppAssets.authLockIcon,
                        width: AppConstants.moreTabLockIconSize,
                        height: AppConstants.moreTabLockIconSize,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      )
                    : null,
                onTap: () =>
                    isLocked ? onLockedItemTap() : onItemSelected(index),
              );
            },
          ),
        ),
        Padding(
          padding: AppConstants.moreTabModalEditButtonPadding,
          child: BizziePrimaryButton(title: 'Edit', onPressed: onEditTap),
        ),
      ],
    );
  }
}

class _MoreTabEmptyState extends StatelessWidget {
  final String ticker;

  const _MoreTabEmptyState({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.mascotAsset,
      builder: (context, mascot) {
        return LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: BizzieEmptyState(
                mascotAsset: mascot,
                title: 'No more features',
                message: 'Select more features to show here',
                isFullPage: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
