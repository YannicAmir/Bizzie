import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return InkWell(
      onTap: () => _showSelectorModal(context),
      borderRadius: BorderRadius.circular(AppConstants.mainSectionBorderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppConstants.mainSectionBorderRadius,
          ),
          border: Border.all(color: AppColors.slate200, width: 0.665),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // Logic from IncomeStatementView: "$title - $formattedDate"
                  title.isNotEmpty
                      ? '$title - $formattedLabel'
                      : formattedLabel,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.43,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.slate500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AppBottomModal(
          title: 'Select Period', // Could be parameter if needed
          builder: (context, scrollController) {
            return ListView.separated(
              controller: scrollController,
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: AppColors.slate50),
              itemBuilder: (context, index) {
                final item = items[index];
                final label = _formatItemLabel(item);
                final isSelected = item == selectedItem;

                return InkWell(
                  onTap: () {
                    onItemSelected(item);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    color: isSelected ? AppColors.slate50 : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: AppColors.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
