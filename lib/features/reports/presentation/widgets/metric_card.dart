import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_utils.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
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
      padding: EdgeInsets.all(AppConstants.mainSectionContainerPadding),
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
            const SizedBox(height: 16),
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
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.hintColor,
          ),
        ),
        Text(amount, style: theme.textTheme.headlineMedium),
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
    final trendColor = isGood ? badgeTheme?.goodText : badgeTheme?.criticalText;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Row(
      children: [
        Icon(trendIcon, size: 20, color: trendColor),
        const SizedBox(width: 4),
        Text(
          changeAmount,
          style: theme.textTheme.headlineMedium?.copyWith(color: trendColor),
        ),
        const Spacer(),
        AppBadge(
          text: changePercent,
          style: isGood ? AppBadgeStyle.good : AppBadgeStyle.critical,
          isLarge: true,
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
        const SizedBox(height: 16),
        Text(driver, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
