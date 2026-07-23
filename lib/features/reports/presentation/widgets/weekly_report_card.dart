import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/widgets/filing_card_header.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/features/reports/presentation/widgets/weekly_report_modal.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WeeklyReportCard extends StatelessWidget {
  static const String _kFilingType = 'EOTW Summary';

  final WeeklyReport report;
  final DateTime? lastViewed;

  const WeeklyReportCard({super.key, required this.report, this.lastViewed});

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
            formType: _kFilingType,
            badgeStyle: AppBadgeStyle.warning,
            filingDate: report.createdAt,
            createdAt: report.createdAt,
            lastViewed: lastViewed,
            onCompanyTapped: () {
              context.read<ReportsBloc>().add(
                ReportsEvent.filingCardCompanyClicked(
                  ticker: report.ticker ?? '',
                ),
              );
              context.goNamed(
                AppRoutes.companyProfileReports,
                pathParameters: {'ticker': report.ticker ?? ''},
                extra: Company(
                  ticker: report.ticker ?? '',
                  name: report.companyName ?? '',
                ),
              );
            },
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
            child: _WeeklyReportActionButton(report: report),
          ),
        ],
      ),
    );
  }
}

class _WeeklyReportActionButton extends StatelessWidget {
  final WeeklyReport report;

  const _WeeklyReportActionButton({required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

        return InkWell(
          onTap: () {
            if (!isSubscribed) {
              context.read<ReportsBloc>().add(
                ReportsEvent.summarizeLockedClicked(
                  ticker: report.ticker ?? '',
                  filingType: WeeklyReportCard._kFilingType,
                ),
              );
              PaywallHelper.showPaywallSequence(
                context,
                source: PaywallSource.reports,
              );
              return;
            }

            context.read<ReportsBloc>().add(
              ReportsEvent.linkOpened(
                ticker: report.ticker ?? '',
                filingType: WeeklyReportCard._kFilingType,
              ),
            );

            final rootContext = rootNavigatorKey.currentContext;
            if (rootContext != null && rootContext.mounted) {
              showModalBottomSheet(
                context: rootContext,
                isScrollControlled: true,
                backgroundColor: theme.colorScheme.scrim,
                builder: (context) => WeeklyReportModal(report: report),
              );
            }
          },
          child: Row(
            children: [
              if (isSubscribed)
                Icon(
                  Icons.description_outlined,
                  size: 16,
                  color: theme.colorScheme.primary,
                )
              else
                SvgPicture.asset(
                  AppAssets.authLockIcon,
                  width: 15,
                  height: 15,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
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
      },
    );
  }
}
