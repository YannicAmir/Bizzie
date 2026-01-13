import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_empty_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_modal.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_tile.dart';
import 'package:flutter/material.dart';

class UpcomingEarningsSection extends StatelessWidget {
  final List<UpcomingEarnings> earnings;
  final String mascotAsset;

  const UpcomingEarningsSection({
    super.key,
    required this.earnings,
    this.mascotAsset = AppAssets.defaultMascot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const int maxVisibleItems = 4;
    final bool showViewMore = earnings.length > maxVisibleItems;
    final displayedEarnings = showViewMore
        ? earnings.take(maxVisibleItems).toList()
        : earnings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Upcoming', style: AppTextStyles.sectionHeader),
        ),
        if (earnings.isEmpty)
          ReportsEmptyState(
            mascotAsset: mascotAsset,
            message: 'There are no upcoming notifications',
          )
        else
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate300, width: 0.665),
            ),
            child: Column(
              children: [
                ...List.generate(displayedEarnings.length, (index) {
                  final isLastItem =
                      !showViewMore && index == displayedEarnings.length - 1;

                  return UpcomingEarningsTile(
                    earnings: displayedEarnings[index],
                    isLast: isLastItem,
                  );
                }),
                if (showViewMore)
                  InkWell(
                    onTap: () => _showAllEarningsModal(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'View More',
                        style: AppTextStyles.bodyMediumBold.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  void _showAllEarningsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UpcomingEarningsModal(earnings: earnings),
    );
  }
}
