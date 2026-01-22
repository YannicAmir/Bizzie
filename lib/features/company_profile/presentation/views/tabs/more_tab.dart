import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/models/more_feature.dart';
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
  int _selectedIndex = 0;

  List<MoreFeature> get _features =>
      widget.features.isEmpty ? defaultMoreFeatures : widget.features;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_features.isEmpty) {
      return _MoreTabEmptyState(ticker: widget.ticker);
    }

    return Column(
      children: [
        Padding(
          padding: AppConstants.moreTabDropdownButtonPadding,
          child: AppDropdownButton(
            label: _features[_selectedIndex].label,
            onTap: () => _showSelectorModal(context),
          ),
        ),
        Expanded(child: _features[_selectedIndex].builder(widget.ticker)),
      ],
    );
  }

  void _showSelectorModal(BuildContext context) {
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
                final isSelected = index == _selectedIndex;

                return AppModalListItem(
                  label: item.label,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
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
