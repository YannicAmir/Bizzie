import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_action_button.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_content.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bizzie/shared/widgets/modals/weekly_report_modal.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeeklyReportCard extends StatelessWidget {
  static const String filingType = 'EOTW Summary';

  final WeeklyReport report;
  final bool isLocked;
  final String? logoUrl;
  final VoidCallback? onCompanyTapped;
  final VoidCallback? onLockedTapped;
  final VoidCallback? onReportOpened;

  const WeeklyReportCard({
    super.key,
    required this.report,
    required this.isLocked,
    this.logoUrl,
    this.onCompanyTapped,
    this.onLockedTapped,
    this.onReportOpened,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilingCardHeader(
          ticker: report.ticker ?? '',
          companyName: report.companyName ?? '',
          filingDate: report.createdAt,
          releasedAt: report.createdAt,
          logoUrl: logoUrl,
          onCompanyTapped: onCompanyTapped,
        ),
        FilingCardContent(
          formType: filingType,
          badgeStyle: AppBadgeStyle.warning,
          body: [
            Text(
              report.messageShortSummary ?? '',
              style: theme.textTheme.bodyMedium,
            ),
          ],
          actions: FilingCardActionsRow(
            trailing: _WeeklyReportActionButton(
              report: report,
              isLocked: isLocked,
              onLockedTapped: onLockedTapped,
              onReportOpened: onReportOpened,
            ),
          ),
        ),
      ],
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
    return FilingCardActionButton(
      iconBuilder: (color) => isLocked
          ? SvgPicture.asset(
              AppAssets.authLockIcon,
              width: 20,
              height: 20,
              excludeFromSemantics: true,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          : Icon(Icons.description_outlined, size: 22, color: color),
      label: 'View Full Report',
      style: FilingCardActionStyle.primary,
      alignment: Alignment.centerRight,
      onTap: () => _onTap(theme.colorScheme.scrim),
    );
  }
}
