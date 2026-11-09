import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bizzie/shared/widgets/modals/report_summary_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const String _kTenKFormType = '10-K';
const String _kTenQFormType = '10-Q';
const String _kEightKFormType = '8-K';
const double _kActionIconSize = 16;
const double _kLockIconSize = 15;
const double _kInProgressModalRadius = 24;
const EdgeInsets _kSectionPadding = EdgeInsets.all(16);
const EdgeInsets _kActionsPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);
const EdgeInsets _kInProgressModalPadding = EdgeInsets.all(24);
const SizedBox _kFinancialLabelSpacing = SizedBox(height: 4);

class SecFilingCard extends StatelessWidget {
  final SecFiling filing;
  final FinancialReport? financialReport;
  final DateTime? lastViewed;
  final String summaryButtonLabel;
  final bool isSummaryLocked;
  final VoidCallback? onCompanyTapped;
  final VoidCallback? onViewReportTapped;
  final VoidCallback? onLockedSummaryTapped;
  final ValueChanged<bool>? onSummaryRequested;

  const SecFilingCard({
    super.key,
    required this.filing,
    required this.summaryButtonLabel,
    required this.isSummaryLocked,
    this.financialReport,
    this.lastViewed,
    this.onCompanyTapped,
    this.onViewReportTapped,
    this.onLockedSummaryTapped,
    this.onSummaryRequested,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool showFinancials =
        (filing.isEarnings ||
            filing.formType == _kTenQFormType ||
            filing.formType == _kTenKFormType) &&
        filing.revenue != null &&
        filing.eps != null;

    final currencyCode = financialReport?.summary.reportingCurrency ?? 'USD';
    final simpleFormat = NumberFormat.simpleCurrency(name: currencyCode);
    final symbol = simpleFormat.currencySymbol;

    final currencyFormatter = NumberFormat.compactCurrency(symbol: symbol);
    final epsFormatter = NumberFormat.currency(symbol: symbol);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width:
              theme.dividerTheme.thickness ?? AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilingCardHeader(
            ticker: filing.symbol,
            companyName: filing.companyName,
            formType: filing.formType,
            filingDate: filing.filingDate,
            createdAt: filing.createdAt,
            lastViewed: lastViewed,
            topic: filing.topic,
            onCompanyTapped: onCompanyTapped,
          ),
          if (showFinancials) ...[
            _FinancialsRow(
              filing: filing,
              currencyFormatter: currencyFormatter,
              epsFormatter: epsFormatter,
            ),
          ],
          Padding(
            padding: _kSectionPadding,
            child: Text(
              filing.summary,
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: _kActionsPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (filing.formType != _kEightKFormType || filing.isEarnings)
                  _SummarizeButton(
                    financialReport: financialReport,
                    filingLink: filing.link,
                    label: summaryButtonLabel,
                    isLocked: isSummaryLocked,
                    onLockedTapped: onLockedSummaryTapped,
                    onRequested: onSummaryRequested,
                  ),
                _ActionButton(
                  icon: Icon(
                    Icons.description_outlined,
                    size: _kActionIconSize,
                    color: theme.colorScheme.primary,
                  ),
                  label: 'View Full Report',
                  onTap: () {
                    onViewReportTapped?.call();
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
      padding: _kSectionPadding,
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
                _kFinancialLabelSpacing,
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
                _kFinancialLabelSpacing,
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
  final String filingLink;
  final String label;
  final bool isLocked;
  final VoidCallback? onLockedTapped;
  final ValueChanged<bool>? onRequested;

  const _SummarizeButton({
    required this.financialReport,
    required this.filingLink,
    required this.label,
    required this.isLocked,
    required this.onLockedTapped,
    required this.onRequested,
  });

  void _onTap(BuildContext context, Color scrimColor) {
    if (isLocked) {
      onLockedTapped?.call();
      return;
    }

    final report = financialReport;
    onRequested?.call(report != null);

    if (report != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: scrimColor,
        builder: (context) =>
            ReportSummaryModal(report: report, filingUrl: filingLink),
      );
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: scrimColor,
        builder: (context) => const _AnalysisInProgressModal(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _ActionButton(
      icon: isLocked
          ? SvgPicture.asset(
              AppAssets.authLockIcon,
              width: _kLockIconSize,
              height: _kLockIconSize,
              excludeFromSemantics: true,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            )
          : Image.asset(
              AppAssets.sparkleIcon,
              width: _kActionIconSize,
              height: _kActionIconSize,
              color: theme.colorScheme.primary,
              excludeFromSemantics: true,
            ),
      label: label,
      onTap: () => _onTap(context, theme.colorScheme.scrim),
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
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_kInProgressModalRadius),
        ),
      ),
      padding: _kInProgressModalPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Analysis in Progress', style: theme.textTheme.displaySmall),
          AppConstants.subSectionSpacing,
          Text(
            'Our AI is currently analyzing this report. Please check back shortly.',
            style: theme.textTheme.bodyMedium,
          ),
          AppConstants.mainSectionSpacing,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.cardBorderRadius,
                  ),
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
          AppConstants.subSectionHorizontalSpacing,
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
