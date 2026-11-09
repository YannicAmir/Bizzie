import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bizzie/shared/widgets/modals/weekly_report_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeeklyReportCard extends StatelessWidget {
  static const String filingType = 'EOTW Summary';

  final WeeklyReport report;
  final bool isLocked;
  final DateTime? lastViewed;
  final VoidCallback? onCompanyTapped;
  final VoidCallback? onLockedTapped;
  final VoidCallback? onReportOpened;

  const WeeklyReportCard({
    super.key,
    required this.report,
    required this.isLocked,
    this.lastViewed,
    this.onCompanyTapped,
    this.onLockedTapped,
    this.onReportOpened,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
          width: theme.dividerTheme.thickness ?? .665,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilingCardHeader(
            ticker: report.ticker ?? '',
            companyName: report.companyName ?? '',
            formType: filingType,
            badgeStyle: AppBadgeStyle.warning,
            filingDate: report.createdAt,
            createdAt: report.createdAt,
            lastViewed: lastViewed,
            onCompanyTapped: onCompanyTapped,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              report.messageShortSummary ?? '',
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _WeeklyReportActionButton(
              report: report,
              isLocked: isLocked,
              onLockedTapped: onLockedTapped,
              onReportOpened: onReportOpened,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyReportActionButton extends StatelessWidget {
  final WeeklyReport report;
  final bool isLocked;
  final VoidCallback? onLockedTapped;
  final VoidCallback? onReportOpened;

  const _WeeklyReportActionButton({
    required this.report,
    required this.isLocked,
    required this.onLockedTapped,
    required this.onReportOpened,
  });

  void _onTap(Color scrimColor) {
    if (isLocked) {
      onLockedTapped?.call();
      return;
    }

    onReportOpened?.call();

    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext != null && rootContext.mounted) {
      showModalBottomSheet(
        context: rootContext,
        isScrollControlled: true,
        backgroundColor: scrimColor,
        builder: (context) => WeeklyReportModal(report: report),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _onTap(theme.colorScheme.scrim),
      child: Row(
        children: [
          if (isLocked)
            SvgPicture.asset(
              AppAssets.authLockIcon,
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            )
          else
            Icon(
              Icons.description_outlined,
              size: 16,
              color: theme.colorScheme.primary,
            ),
          const SizedBox(width: 8),
          Text(
            'View Full Report',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
