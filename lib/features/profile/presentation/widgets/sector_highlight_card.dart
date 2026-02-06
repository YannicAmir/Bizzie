import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class SectorHighlightCard extends StatelessWidget {
  final String sectorName;
  final String sectorDescription;
  final double? sectorPe;
  final double? sectorAverageChange;
  final DateTime? marketDataDate;

  const SectorHighlightCard({
    super.key,
    required this.sectorName,
    required this.sectorDescription,
    this.sectorPe,
    this.sectorAverageChange,
    this.marketDataDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectorName, style: theme.textTheme.displaySmall),
        if (sectorPe != null || sectorAverageChange != null) ...[
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sectorPe != null)
                Expanded(
                  child: _StatItem(
                    label: 'Sector P/E',
                    value: sectorPe!.toStringAsFixed(2),
                    style: AppBadgeStyle.neutral,
                    isExtraLarge: true,
                  ),
                ),
              if (sectorAverageChange != null)
                Expanded(
                  child: _StatItem(
                    label: 'Avg. Change',
                    value: '${sectorAverageChange!.toStringAsFixed(2)}%',
                    style: sectorAverageChange! >= 0
                        ? AppBadgeStyle.good
                        : AppBadgeStyle.critical,
                    isExtraLarge: true,
                  ),
                ),
            ],
          ),
        ],
        if (marketDataDate != null) ...[
          const SizedBox(height: 16),
          Text(
            'P/E & Avg. Change as of ${BizzieDateFormatter.formatMonthYearFull(marketDataDate!.toIso8601String())}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 24),
        Text(sectorDescription, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final AppBadgeStyle style;
  final bool isExtraLarge;

  const _StatItem({
    required this.label,
    required this.value,
    required this.style,
    this.isExtraLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        AppBadge(text: value, style: style, isExtraLarge: isExtraLarge),
      ],
    );
  }
}
