import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_utils.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String amount;
  final String changeAmount;
  final String changePercent;
  final String? driver;
  final bool isPositive;
  final bool isInverse;

  const MetricCard({
    super.key,
    required this.title,
    required this.amount,
    required this.changeAmount,
    required this.changePercent,
    this.driver,
    required this.isPositive,
    this.isInverse = false,
  });

  factory MetricCard.fromMetric({
    required String title,
    required FinancialMetric metric,
    bool isInverse = false,
    String currencyCode = 'USD',
  }) {
    final formattedAmount = formatReportCurrency(metric.amount, currencyCode);
    final formattedChange = formatReportCurrency(
      metric.changeAmount,
      currencyCode,
    );
    final formattedPercent = formatReportPercentage(metric.changePercent);

    final isPos = metric.changeAmount >= 0;

    return MetricCard(
      title: title,
      amount: formattedAmount,
      changeAmount: formattedChange,
      changePercent: formattedPercent,
      isPositive: isPos,
      isInverse: isInverse,
    );
  }

  factory MetricCard.fromMetricWithDriver({
    required String title,
    required FinancialMetricWithDriver metric,
    bool isInverse = false,
    String currencyCode = 'USD',
  }) {
    final formattedAmount = formatReportCurrency(metric.amount, currencyCode);
    final formattedChange = formatReportCurrency(
      metric.changeAmount,
      currencyCode,
    );
    final formattedPercent = formatReportPercentage(metric.changePercent);

    final isPos = metric.changeAmount >= 0;

    return MetricCard(
      title: title,
      amount: formattedAmount,
      changeAmount: formattedChange,
      changePercent: formattedPercent,
      driver: metric.driver,
      isPositive: isPos,
      isInverse: isInverse,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGood = isInverse ? !isPositive : isPositive;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor, width: 0.665),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(title: title, amount: amount),
          const SizedBox(height: 8),
          _TrendRow(
            changeAmount: changeAmount,
            changePercent: changePercent,
            isPositive: isPositive,
            isGood: isGood,
          ),
          if (driver != null && driver!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _DriverSection(driver: driver!),
          ],
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final String title;
  final String amount;

  const _HeaderRow({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          amount,
          style: theme.textTheme.headlineSmall?.copyWith(fontSize: 15),
        ),
      ],
    );
  }
}

class _TrendRow extends StatelessWidget {
  final String changeAmount;
  final String changePercent;
  final bool isPositive;
  final bool isGood;

  const _TrendRow({
    required this.changeAmount,
    required this.changePercent,
    required this.isPositive,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final trendColor = isGood
        ? badgeTheme?.goodText ?? Colors.green
        : theme.colorScheme.error;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Row(
      children: [
        Icon(trendIcon, size: 14, color: trendColor),
        const SizedBox(width: 4),
        Text(
          changeAmount,
          style: theme.textTheme.bodySmall?.copyWith(
            color: trendColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: trendColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            changePercent,
            style: theme.textTheme.labelSmall?.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _DriverSection extends StatelessWidget {
  final String driver;

  const _DriverSection({required this.driver});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1),
        const SizedBox(height: 12),
        Text(
          driver,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodyMedium?.color, // Use standard body color
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
