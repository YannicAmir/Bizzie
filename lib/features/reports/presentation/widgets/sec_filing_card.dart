import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/presentation/widgets/report_summary_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class SecFilingCard extends StatelessWidget {
  final SecFiling filing;
  final FinancialReport? financialReport;
  final DateTime? lastViewed;

  const SecFilingCard({
    super.key,
    required this.filing,
    this.financialReport,
    this.lastViewed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool showFinancials =
        (filing.isEarnings ||
            filing.formType == '10-Q' ||
            filing.formType == '10-K') &&
        filing.revenue != null &&
        filing.eps != null;

    final currencyCode = financialReport?.summary.reportingCurrency ?? 'USD';
    final simpleFormat = NumberFormat.simpleCurrency(name: currencyCode);
    final symbol = simpleFormat.currencySymbol;

    final currencyFormatter = NumberFormat.compactCurrency(symbol: symbol);
    final epsFormatter = NumberFormat.currency(symbol: symbol);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
          width: theme.dividerTheme.thickness ?? .665,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(filing: filing, lastViewed: lastViewed),
          if (showFinancials) ...[
            _FinancialsRow(
              filing: filing,
              currencyFormatter: currencyFormatter,
              epsFormatter: epsFormatter,
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              filing.summary,
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (filing.formType != '8-K' || filing.isEarnings)
                  _SummarizeButton(
                    financialReport: financialReport,
                    filing: filing,
                  ),
                _ActionButton(
                  icon: Icon(
                    Icons.description_outlined,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  label: 'View Full Report',
                  onTap: () {
                    if (filing.link.isNotEmpty) {
                      launchUrl(Uri.parse(filing.link));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final SecFiling filing;
  final DateTime? lastViewed;

  const _Header({required this.filing, this.lastViewed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (lastViewed != null &&
                  filing.createdAt != null &&
                  filing.createdAt!.isAfter(lastViewed!))
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'UNREAD',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(filing.symbol, style: theme.textTheme.headlineMedium),
              const SizedBox(width: 8),
              AppBadge(
                text: filing.formType,
                style: AppBadgeStyle.neutral,
                isLarge: true,
              ),
              if (filing.topic != null) ...[
                const SizedBox(width: 8),
                Text(filing.topic ?? '', style: theme.textTheme.bodyMedium),
              ],
              const Spacer(),
              if (filing.filingDate != null)
                Text(
                  DateFormat('MMM d, yyyy').format(filing.filingDate!),
                  style: theme.textTheme.bodyMedium,
                )
              else
                Text('Date Unknown', style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            filing.companyName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialsRow extends StatelessWidget {
  final SecFiling filing;
  final NumberFormat currencyFormatter;
  final NumberFormat epsFormatter;

  const _FinancialsRow({
    required this.filing,
    required this.currencyFormatter,
    required this.epsFormatter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Revenue',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currencyFormatter.format(filing.revenue),
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earnings',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  epsFormatter.format(filing.eps),
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummarizeButton extends StatelessWidget {
  final FinancialReport? financialReport;
  final SecFiling filing;

  const _SummarizeButton({required this.financialReport, required this.filing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _ActionButton(
      icon: Image.asset(
        AppAssets.sparkleIcon,
        width: 16,
        height: 16,
        color: theme.colorScheme.primary,
      ),
      label: 'Summarize',
      onTap: () {
        if (financialReport != null) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ReportSummaryModal(
              report: financialReport!,
              filingUrl: filing.link,
            ),
          );
        } else {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const _AnalysisInProgressModal(),
          );
        }
      },
    );
  }
}

class _AnalysisInProgressModal extends StatelessWidget {
  const _AnalysisInProgressModal();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Analysis in Progress', style: theme.textTheme.displaySmall),
          const SizedBox(height: 8),
          Text(
            'Our AI is currently analyzing this report. Please check back shortly.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.slate500,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
