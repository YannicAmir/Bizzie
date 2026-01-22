import 'package:bizzie/features/company_profile/presentation/models/more_feature.dart';
import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:flutter/material.dart';

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
      return const Center(child: Text('No features available'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
