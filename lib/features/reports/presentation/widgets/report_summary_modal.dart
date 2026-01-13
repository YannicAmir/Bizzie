import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/financial_report_extensions.dart';
import 'package:bizzie/features/reports/presentation/widgets/metric_card.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/bottom_modal_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportSummaryModal extends StatelessWidget {
  final FinancialReport report;
  final String? filingUrl;

  const ReportSummaryModal({super.key, required this.report, this.filingUrl});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.875,
      minChildSize: 0.5,
      maxChildSize: 0.875,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              BottomModalHeader(
                title: 'AI Summary',
                subtitle: Text(
                  '${report.ticker} • ${report.filingDate != null ? DateFormat('MMM d, yyyy').format(report.filingDate!) : 'Date Unknown'} • ${report.formType}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text('Operations', style: theme.textTheme.displaySmall),
                    const SizedBox(height: 16),
                    MetricCard.fromMetricWithDriver(
                      title: 'Revenue',
                      metric: report.income.revenue,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetric(
                      title: 'Cost of Revenue',
                      metric: report.income.costOfRevenue,
                      isInverse: true,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetricWithDriver(
                      title: 'Total Expenses',
                      metric: report.income.totalExpenses,
                      isInverse: true,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetricWithDriver(
                      title: 'Net Income',
                      metric: report.income.netIncome,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetric(
                      title: 'Earnings Per Share',
                      metric: report.income.eps,
                      currencyCode: report.summary.reportingCurrency,
                    ),

                    const SizedBox(height: 32),

                    Text('Balance Sheet', style: theme.textTheme.displaySmall),
                    const SizedBox(height: 16),
                    MetricCard.fromMetric(
                      title: 'Total Assets',
                      metric: report.balanceSheet.totalAssets,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetric(
                      title: 'Total Liabilities',
                      metric: report.balanceSheet.totalLiabilities,
                      isInverse: true,
                      currencyCode: report.summary.reportingCurrency,
                    ),
                    const SizedBox(height: 12),
                    MetricCard.fromMetric(
                      title: 'Stockholder\'s Equity',
                      metric: report.balanceSheet.equity,
                      currencyCode: report.summary.reportingCurrency,
                    ),

                    const SizedBox(height: 32),

                    Text('Cash Flow', style: theme.textTheme.displaySmall),
                    const SizedBox(height: 16),
                    MetricCard.fromMetricWithDriver(
                      title: 'Free Cash Flow',
                      metric: report.cashFlow.freeCashFlow,
                      currencyCode: report.summary.reportingCurrency,
                    ),

                    const SizedBox(height: 32),

                    if (!report.formType.contains('8-K')) ...[
                      Text(
                        'Stock Repurchasing',
                        style: theme.textTheme.displaySmall,
                      ),
                      const SizedBox(height: 16),
                      _StockActivityCard(activity: report.stockActivity),
                      const SizedBox(height: 32),
                    ],

                    Text(
                      'Forward Looking Statements',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 16),
                    _ForwardLookingSection(text: report.summary.forwardLooking),
                    const SizedBox(height: 32),

                    const _AiDisclaimerSection(),
                    if (filingUrl != null) ...[
                      const SizedBox(height: 32),
                      BizziePrimaryButton(
                        onPressed: () {
                          launchUrl(Uri.parse(filingUrl!));
                        },
                        title: 'View Full SEC Filing',
                        height: 48,
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StockActivityCard extends StatelessWidget {
  final ReportStockActivity activity;

  const _StockActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final formatter = NumberFormat.compact();

    String formatShares(double? shares) {
      if (shares == null) return '-';
      return formatter.format(shares);
    }

    final isGood = activity.isBuyback;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActivityColumn(
                label: 'Repurchased',
                value: formatShares(activity.repurchasedShares),
              ),
              _ActivityColumn(
                label: 'Issued',
                value: formatShares(activity.issuedShares),
              ),
              _ActivityColumn(
                label: 'Net Change',
                value: formatShares(activity.netStockChangeShares),
                valueColor: isGood
                    ? badgeTheme?.goodText ?? Colors.green
                    : theme.colorScheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ActivityColumn({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelSmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.displaySmall?.copyWith(
            fontSize: 15,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _ForwardLookingSection extends StatelessWidget {
  final String text;

  const _ForwardLookingSection({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodyMedium?.color,
          height: 1.5,
        ),
      ),
    );
  }
}

class _AiDisclaimerSection extends StatelessWidget {
  const _AiDisclaimerSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: theme.hintColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'AI-Generated Summary',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: 14,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This summary was produced by AI and may contain inaccuracies. It is not financial advice. Always verify key data against the full SEC filing before making investment decisions.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodyMedium?.color,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
