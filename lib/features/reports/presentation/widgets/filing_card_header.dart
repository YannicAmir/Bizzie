import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double _kUnreadDotSize = 8.0;
const String _kUnreadLabel = 'UNREAD';
const String _kDateUnknownLabel = 'Date Unknown';

class FilingCardHeader extends StatelessWidget {
  final String ticker;
  final String companyName;
  final String formType;
  final AppBadgeStyle badgeStyle;
  final DateTime? filingDate;
  final DateTime? createdAt;
  final DateTime? lastViewed;
  final String? topic;
  final VoidCallback? onCompanyTapped;

  const FilingCardHeader({
    super.key,
    required this.ticker,
    required this.companyName,
    required this.formType,
    this.badgeStyle = AppBadgeStyle.neutral,
    this.filingDate,
    this.createdAt,
    this.lastViewed,
    this.topic,
    this.onCompanyTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread =
        lastViewed != null &&
        createdAt != null &&
        createdAt!.isAfter(lastViewed!);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [if (isUnread) const _UnreadIndicator()]),
          AppConstants.subSectionSpacing,
          Row(
            children: [
              GestureDetector(
                onTap: onCompanyTapped,
                child: Text(ticker, style: theme.textTheme.headlineMedium),
              ),
              AppConstants.subSectionHorizontalSpacing,
              AppBadge(text: formType, style: badgeStyle, isLarge: true),
              if (topic != null) ...[
                AppConstants.subSectionHorizontalSpacing,
                Text(topic!, style: theme.textTheme.bodyMedium),
              ],
              const Spacer(),
              if (filingDate != null)
                Text(
                  DateFormat('MMM d, yyyy').format(filingDate!),
                  style: theme.textTheme.bodyMedium,
                )
              else
                Text(_kDateUnknownLabel, style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            companyName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnreadIndicator extends StatelessWidget {
  const _UnreadIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Container(
            width: _kUnreadDotSize,
            height: _kUnreadDotSize,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          AppConstants.subSectionHorizontalSpacing,
          Text(
            _kUnreadLabel,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
