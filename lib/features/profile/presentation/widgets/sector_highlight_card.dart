import 'package:bizzie/shared/constants/app_constants.dart';
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

    final hasStats = sectorPe != null || sectorAverageChange != null;
    final hasDate = marketDataDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstants.subSectionSpacing,
        Text(sectorName, style: theme.textTheme.displaySmall),
        AppConstants.secondarySectionSpacing,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(
            AppConstants.mainSectionContainerPadding,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: theme.dividerColor,
              width: theme.dividerTheme.thickness ??
                  AppConstants.defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.cardBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasStats)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sectorPe != null)
                      Expanded(
                        child: _StatItem(
                          label: 'Sector P/E',
                          value: sectorPe!.toStringAsFixed(2),
                          style: AppBadgeStyle.neutral,
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
                        ),
                      ),
                  ],
                ),
              if (hasDate) ...[
                if (hasStats) AppConstants.secondarySectionSpacing,
                Text(
                  'P/E & Avg. Change as of ${BizzieDateFormatter.formatMonthYearFull(marketDataDate!.toIso8601String())}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (hasStats || hasDate) AppConstants.mainSectionSpacing,
              Text(sectorDescription, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final AppBadgeStyle style;

  const _StatItem({
    required this.label,
    required this.value,
    required this.style,
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
        AppConstants.subSectionSpacing,
        AppBadge(text: value, style: style, isExtraLarge: true),
      ],
    );
  }
}
