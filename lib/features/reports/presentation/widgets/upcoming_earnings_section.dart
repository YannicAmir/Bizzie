import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_modal.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';

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
          child: Text('Upcoming', style: theme.textTheme.displaySmall),
        ),
        if (earnings.isEmpty)
          BizzieEmptyState(
            mascotAsset: mascotAsset,
            message:
                'There are no upcoming notifications for the companies on your watchlist',
          )
        else
          Column(
            children: [
              ...List.generate(displayedEarnings.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: UpcomingEarningsTile(
                    earnings: displayedEarnings[index],
                    isLast:
                        !showViewMore && index == displayedEarnings.length - 1,
                  ),
                );
              }),
              if (showViewMore)
                InkWell(
                  onTap: () {
                    context.read<ReportsBloc>().add(
                      const ReportsEvent.upcomingExpanded(),
                    );
                    _showAllEarningsModal(context);
                  },
                  splashColor: theme.colorScheme.scrim,
                  highlightColor: theme.colorScheme.scrim,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      'View All',
                      style: AppTextStyles.bodyMediumBold.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  void _showAllEarningsModal(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UpcomingEarningsModal(earnings: earnings),
    );
  }
}
