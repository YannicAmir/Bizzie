import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class UpcomingEarningsCard extends StatelessWidget {
  final UpcomingEarnings earnings;
  final VoidCallback onTap;

  const UpcomingEarningsCard({
    super.key,
    required this.earnings,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = earnings.date;

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
                    text: earnings.symbol,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(text: ' - ', style: theme.textTheme.bodyMedium),
                  TextSpan(
                    text: earnings.companyName,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const AppBadge(text: 'Earnings', style: AppBadgeStyle.neutral),
                if (date != null) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      BizzieDateFormatter.formatHumanFriendlyDate(date),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
