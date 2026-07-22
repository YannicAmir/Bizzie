import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/utils/ytd_price_change_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class WatchlistYtdCard extends StatelessWidget {
  final YtdPriceChange change;
  final VoidCallback onTap;

  const WatchlistYtdCard({
    super.key,
    required this.change,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = change.isPositive;
    final changeColor = isPositive
        ? AppColors.goodText
        : AppColors.criticalText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.dividerColor,
            width:
                theme.dividerTheme.thickness ?? AppConstants.defaultBorderWidth,
          ),
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: change.ticker,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(text: ' - ', style: theme.textTheme.bodyMedium),
                  TextSpan(
                    text: change.companyName,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            AppConstants.compactSectionSpacing,
            Row(
              children: [
                Transform.flip(
                  flipY: !isPositive,
                  child: Image.asset(
                    AppAssets.arrowUpIcon,
                    width: 16,
                    height: 16,
                    color: changeColor,
                  ),
                ),
                AppConstants.subSectionHorizontalSpacing,
                AppBadge(
                  text: change.formattedYtdChangePercent,
                  style: isPositive
                      ? AppBadgeStyle.good
                      : AppBadgeStyle.critical,
                  isLarge: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
