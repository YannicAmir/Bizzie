import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_action_button.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_content.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bizzie/shared/widgets/modals/report_summary_modal.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const String _kTenKFormType = '10-K';
const String _kTenQFormType = '10-Q';
const String _kEightKFormType = '8-K';
const double _kActionIconSize = 20;
const double _kSummaryIconSize = 22;
const double _kExternalLinkIconSize = 22;
const double _kInProgressModalRadius = 24;
const EdgeInsets _kInProgressModalPadding = EdgeInsets.all(24);
const SizedBox _kFinancialLabelSpacing = SizedBox(height: 4);

class SecFilingCard extends StatelessWidget {
  final SecFiling filing;
  final FinancialReport? financialReport;
  final String? logoUrl;
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
    this.logoUrl,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilingCardHeader(
          ticker: filing.symbol,
          companyName: filing.companyName,
          filingDate: filing.filingDate,
          releasedAt: financialReport?.dateAnalyzed ?? filing.analyzedAt,
          logoUrl: logoUrl,
          onCompanyTapped: onCompanyTapped,
        ),
        FilingCardContent(
          formType: filing.formType,
          topic: filing.topic,
          body: [
            if (showFinancials) ...[
              _FinancialsRow(
                filing: filing,
                currencyFormatter: currencyFormatter,
                epsFormatter: epsFormatter,
              ),
              AppConstants.secondarySectionSpacing,
            ],
            Text(filing.summary, style: theme.textTheme.bodyMedium),
          ],
          actions: FilingCardActionsRow(
            leading: filing.formType != _kEightKFormType || filing.isEarnings
                ? _SummarizeButton(
                    financialReport: financialReport,
                    filingLink: filing.link,
                    label: summaryButtonLabel,
                    isLocked: isSummaryLocked,
                    onLockedTapped: onLockedSummaryTapped,
                    onRequested: onSummaryRequested,
                  )
                : null,
            trailing: FilingCardActionButton(
              iconBuilder: (color) => Icon(
                Icons.open_in_new,
                size: _kExternalLinkIconSize,
                color: color,
              ),
              label: 'View Full Report',
              style: FilingCardActionStyle.secondary,
              alignment: Alignment.centerRight,
              onTap: () {
                onViewReportTapped?.call();
                if (filing.link.isNotEmpty) {
                  launchUrl(Uri.parse(filing.link));
                }
              },
            ),
          ),
        ),
      ],
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
    return Row(
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
    return FilingCardActionButton(
      iconBuilder: (color) => isLocked
          ? SvgPicture.asset(
              AppAssets.authLockIcon,
              width: _kActionIconSize,
              height: _kActionIconSize,
              excludeFromSemantics: true,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          : Icon(
              Icons.description_outlined,
              size: _kSummaryIconSize,
              color: color,
            ),
      label: label,
      style: FilingCardActionStyle.primary,
      alignment: Alignment.centerRight,
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
