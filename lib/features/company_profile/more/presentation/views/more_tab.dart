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
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_section_divider.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/foundation.dart';
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
      final safeIndex = _safeFeatureIndex(_tabsBloc.state.moreTabIndex);
      _reportSubTabView(_features[safeIndex].analyticsName);
    }
    _activateMoreSection();
  }

  @override
  void didUpdateWidget(MoreTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.moreTabs, widget.moreTabs) ||
        oldWidget.ticker != widget.ticker) {
      _features = _buildFeatures();
      _activateMoreSection();
    }
  }

  List<MoreFeature> _buildFeatures() =>
      widget.moreTabs.map(moreFeatureFromTab).toList();

  int _safeFeatureIndex(int moreTabIndex) =>
      moreTabIndex.clamp(0, _features.length - 1);

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
      return const _MoreTabEmptyState();
    }

    return BlocBuilder<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      buildWhen: (previous, current) =>
          previous.moreTabIndex != current.moreTabIndex,
      builder: (context, state) {
        final safeIndex = _safeFeatureIndex(state.moreTabIndex);
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
    final bizziePlusTabs = _tabsBloc.state.bizziePlusTabs;

    showModalBottomSheet(
      context: outerContext,
      isScrollControlled: true,
      builder: (modalContext) {
        return AppBottomModal(
          title: 'Select Feature',
          minChildSize: 0.875,
          builder: (_, scrollController) => _FeatureSelectorModalContent(
            scrollController: scrollController,
            features: _features,
            currentSelection: currentSelection,
            bizziePlusTabs: bizziePlusTabs,
            onBizziePlusItemTap: (tab) =>
                _onBizziePlusItemTapped(modalContext, outerContext, tab),
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

  void _onBizziePlusItemTapped(
    BuildContext modalContext,
    BuildContext outerContext,
    CompanyProfileTab tab,
  ) {
    Navigator.pop(modalContext);
    PaywallHelper.showLockedTabPaywall(
      outerContext,
      tabName: tab.analyticsName,
      featureName: tab.paywallFeatureName,
    );
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
      bizziePlusTabs: tabsState.bizziePlusTabs,
      onSaved: (savedLayout) {
        if (!mounted) return;
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
  final int currentSelection;
  final List<CompanyProfileTab> bizziePlusTabs;
  final ValueChanged<CompanyProfileTab> onBizziePlusItemTap;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onEditTap;

  const _FeatureSelectorModalContent({
    required this.scrollController,
    required this.features,
    required this.currentSelection,
    required this.bizziePlusTabs,
    required this.onBizziePlusItemTap,
    required this.onItemSelected,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final rows = [
      const TabSectionDivider(label: 'More'),
      for (final (index, feature) in features.indexed)
        AppModalListItem(
          label: feature.label,
          isSelected: index == currentSelection,
          onTap: () => onItemSelected(index),
        ),
      if (bizziePlusTabs.isNotEmpty) ...[
        const TabSectionDivider(label: 'Bizzie Plus'),
        for (final tab in bizziePlusTabs)
          AppModalListItem(
            label: tab.label,
            isSelected: false,
            suffix: const _BizziePlusLockIcon(),
            onTap: () => onBizziePlusItemTap(tab),
          ),
      ],
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: rows.length,
            itemBuilder: (context, index) => rows[index],
          ),
        ),
        Padding(
          padding: AppConstants.moreTabModalEditButtonPadding,
          child: BizziePrimaryButton(title: 'Edit Tabs', onPressed: onEditTap),
        ),
      ],
    );
  }
}

class _BizziePlusLockIcon extends StatelessWidget {
  const _BizziePlusLockIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.authLockIcon,
      width: AppConstants.moreTabLockIconSize,
      height: AppConstants.moreTabLockIconSize,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}

class _MoreTabEmptyState extends StatelessWidget {
  const _MoreTabEmptyState();

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
