import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/financial_report_extensions.dart';
import 'package:bizzie/shared/widgets/cards/metric_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const String _kDateFormat = 'MMM d, yyyy';
const String _kDateUnknownLabel = 'Date Unknown';
const String _kEightKFormType = '8-K';
const double _kFilingButtonHeight = 48;
const double _kDisclaimerIconSize = 20;
const double _kForwardLookingLineHeight = 1.5;
const double _kForwardLookingFillAlpha = 0.05;
const double _kForwardLookingBorderAlpha = 0.1;
const double _kDisclaimerFillAlpha = 0.3;
const EdgeInsets _kSectionPadding = EdgeInsets.all(16);
const SizedBox _kSectionSpacing = SizedBox(height: 32);
const SizedBox _kLabelSpacing = SizedBox(height: 4);

class ReportSummaryModal extends StatelessWidget {
  final FinancialReport report;
  final String? filingUrl;

  const ReportSummaryModal({super.key, required this.report, this.filingUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filingDate = report.filingDate;
    final filingDateLabel = filingDate != null
        ? DateFormat(_kDateFormat).format(filingDate)
        : _kDateUnknownLabel;
    return AppBottomModal(
      title: 'AI Summary',
      subtitle: Text(
        '${report.ticker} • $filingDateLabel • ${report.formType}',
        style: AppTextStyles.bodyMediumSecondary,
        overflow: TextOverflow.ellipsis,
      ),
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: AppConstants.reportModalPadding,
          children: [
            _MetricSection(
              title: 'Operations',
              cards: [
                if (report.income.revenue.amount != 0)
                  MetricCard.fromMetricWithDriver(
                    title: 'Revenue',
                    metric: report.income.revenue,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.income.costOfRevenue.amount != 0)
                  MetricCard.fromMetric(
                    title: 'Cost of Revenue',
                    metric: report.income.costOfRevenue,
                    isInverse: true,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.income.totalExpenses.amount != 0)
                  MetricCard.fromMetricWithDriver(
                    title: 'Total Expenses',
                    metric: report.income.totalExpenses,
                    isInverse: true,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.income.netIncome.amount != 0)
                  MetricCard.fromMetricWithDriver(
                    title: 'Net Income',
                    metric: report.income.netIncome,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.income.eps.amount != 0)
                  MetricCard.fromMetric(
                    title: 'Earnings Per Share',
                    metric: report.income.eps,
                    currencyCode: report.summary.reportingCurrency,
                  ),
              ],
            ),
            _MetricSection(
              title: 'Balance Sheet',
              cards: [
                if (report.balanceSheet.totalAssets.amount != 0)
                  MetricCard.fromMetric(
                    title: 'Total Assets',
                    metric: report.balanceSheet.totalAssets,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.balanceSheet.totalLiabilities.amount != 0)
                  MetricCard.fromMetric(
                    title: 'Total Liabilities',
                    metric: report.balanceSheet.totalLiabilities,
                    isInverse: true,
                    currencyCode: report.summary.reportingCurrency,
                  ),
                if (report.balanceSheet.equity.amount != 0)
                  MetricCard.fromMetric(
                    title: 'Stockholder\'s Equity',
                    metric: report.balanceSheet.equity,
                    currencyCode: report.summary.reportingCurrency,
                  ),
              ],
            ),
            _MetricSection(
              title: 'Cash Flow',
              cards: [
                if (report.cashFlow.freeCashFlow.amount != 0)
                  MetricCard.fromMetricWithDriver(
                    title: 'Free Cash Flow',
                    metric: report.cashFlow.freeCashFlow,
                    currencyCode: report.summary.reportingCurrency,
                  ),
              ],
            ),

            if (!report.formType.contains(_kEightKFormType)) ...[
              Text('Stock Repurchasing', style: theme.textTheme.displaySmall),
              AppConstants.secondarySectionSpacing,
              _StockActivityCard(activity: report.stockActivity),
              _kSectionSpacing,
              Text(
                'Forward Looking Statements',
                style: theme.textTheme.displaySmall,
              ),
              AppConstants.secondarySectionSpacing,
              _ForwardLookingSection(text: report.summary.forwardLooking),
              _kSectionSpacing,
            ],

            const _AiDisclaimerSection(),
            if (filingUrl case final url?) ...[
              _kSectionSpacing,
              BizziePrimaryButton(
                onPressed: () {
                  launchUrl(Uri.parse(url));
                },
                title: 'View full SEC filing',
                height: _kFilingButtonHeight,
              ),
            ],
            _kSectionSpacing,
          ],
        );
      },
    );
  }
}

class _MetricSection extends StatelessWidget {
  final String title;
  final List<MetricCard> cards;

  const _MetricSection({required this.title, required this.cards});

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        for (final card in cards) ...[
          AppConstants.secondarySectionSpacing,
          card,
        ],
        _kSectionSpacing,
      ],
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
      padding: _kSectionPadding,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
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
                    ? badgeTheme?.goodText ?? AppColors.success
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
        Text(
          label,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.hintColor,
          ),
        ),
        _kLabelSpacing,
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(color: valueColor),
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
      padding: _kSectionPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: _kForwardLookingFillAlpha,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(
            alpha: _kForwardLookingBorderAlpha,
          ),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodyMedium?.color,
          height: _kForwardLookingLineHeight,
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
      padding: _kSectionPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: _kDisclaimerFillAlpha,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
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
                size: _kDisclaimerIconSize,
              ),
              AppConstants.subSectionHorizontalSpacing,
              Expanded(
                child: Text(
                  'AI-Generated Summary',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ),
            ],
          ),
          AppConstants.subSectionSpacing,
          Text(
            'This summary was produced by AI and may contain inaccuracies. It is not financial advice. Always verify key data against the full SEC filing before making investment decisions.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
