import 'package:bizzie/shared/widgets/buttons/app_dropdown_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/app_modal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialStatementSelector<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onItemSelected;
  final String Function(T) dateStringExtractor;
  final String Function(T)? periodExtractor;
  final String dateFormat;

  const FinancialStatementSelector({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.dateStringExtractor,
    this.periodExtractor,
    this.dateFormat = 'MMM d, yyyy', // Default used in Income Statement
  });

  String _formatItemLabel(T item) {
    final dateStr = dateStringExtractor(item);
    final date = DateTime.tryParse(dateStr);
    String formatted = date != null
        ? DateFormat(dateFormat).format(date)
        : dateStr;

    if (periodExtractor != null) {
      final period = periodExtractor!(item);
      if (period.isNotEmpty && period.startsWith('Q')) {
        formatted += ' - $period';
      }
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final formattedLabel = _formatItemLabel(selectedItem);

    return AppDropdownButton(
      label: title.isNotEmpty ? '$title - $formattedLabel' : formattedLabel,
      onTap: () => _showSelectorModal(context),
    );
  }

  void _showSelectorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AppBottomModal(
          title: 'Select Period', // Could be parameter if needed
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final label = _formatItemLabel(item);
                final isSelected = item == selectedItem;

                return AppModalListItem(
                  label: label,
                  isSelected: isSelected,
                  onTap: () {
                    onItemSelected(item);
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
