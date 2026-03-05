import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';
import 'package:bizzie/features/company_profile/more/presentation/models/more_feature.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreTab extends StatefulWidget {
  final String ticker;
  final List<MoreFeature> features;

  const MoreTab({super.key, required this.ticker, this.features = const []});

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> with AutomaticKeepAliveClientMixin {
  late CompanyProfileBloc _profileBloc;

  List<MoreFeature> get _features =>
      widget.features.isEmpty ? defaultMoreFeatures : widget.features;

  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<CompanyProfileBloc>();
    if (_features.isNotEmpty) {
      final state = _profileBloc.state;
      state.maybeMap(
        active: (s) =>
            _reportSubTabView(_features[s.moreTabIndex].analyticsName),
        orElse: () {},
      );
    }
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

    return BlocSelector<CompanyProfileBloc, CompanyProfileState, int>(
      selector: (state) =>
          state.maybeMap(active: (s) => s.moreTabIndex, orElse: () => 0),
      builder: (context, selectedIndex) {
        return Column(
          children: [
            Padding(
              padding: AppConstants.moreTabDropdownButtonPadding,
              child: AppDropdownButton(
                label: _features[selectedIndex].label,
                onTap: () => _showSelectorModal(context, selectedIndex),
              ),
            ),
            Expanded(child: _features[selectedIndex].builder(widget.ticker)),
          ],
        );
      },
    );
  }

  void _showSelectorModal(BuildContext context, int currentSelection) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AppBottomModal(
          title: 'Select Feature',
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: _features.length,
              itemBuilder: (context, index) {
                final item = _features[index];
                final isSelected = index == currentSelection;

                return AppModalListItem(
                  label: item.label,
                  isSelected: isSelected,
                  onTap: () {
                    _profileBloc.add(
                      CompanyProfileEvent.moreTabIndexChanged(index: index),
                    );
                    _reportSubTabView(item.analyticsName);
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _MoreTabEmptyState extends StatelessWidget {
  final String ticker;

  const _MoreTabEmptyState({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
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
