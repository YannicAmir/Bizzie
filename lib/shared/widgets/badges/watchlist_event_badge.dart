import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class WatchlistEventBadge extends StatelessWidget {
  final WatchlistEventStatus status;

  const WatchlistEventBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(
      status.eventDate.year,
      status.eventDate.month,
      status.eventDate.day,
    );
    final isPast = eventDay.isBefore(today);

    final badgeStyle = (isPast) ? AppBadgeStyle.warning : AppBadgeStyle.neutral;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppBadge(
          text: status.badgeText,
          style: badgeStyle,
          isLarge: true,
          noBackground: true,
        ),
        Text(
          BizzieDateFormatter.formatHumanFriendlyDate(status.eventDate),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
