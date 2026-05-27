import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/features/reports/presentation/models/filing_view_model.dart';
import 'package:bizzie/features/reports/presentation/widgets/sec_filing_card.dart';
import 'package:bizzie/features/reports/presentation/widgets/weekly_report_card.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';

class RecentFilingsSection extends StatelessWidget {
  final List<FilingViewModel> filings;
  final List<WeeklyReport> weeklyReports;
  final DateTime? lastViewed;
  final String mascotAsset;

  const RecentFilingsSection({
    super.key,
    required this.filings,
    this.weeklyReports = const [],
    this.lastViewed,
    this.mascotAsset = AppAssets.defaultMascot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (filings.isEmpty && weeklyReports.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text('Recent', style: theme.textTheme.displaySmall),
          ),
          BizzieEmptyState(
            mascotAsset: mascotAsset,
            message: 'There are no recent reports for the companies on your watchlist',
          ),
        ],
      );
    }

    final List<_RecentItem> items = [
      ...filings.map(
        (vm) => _RecentItem(
          createdAt: vm.filing.createdAt,
          filing: vm,
        ),
      ),
      ...weeklyReports.map(
        (r) => _RecentItem(
          createdAt: r.createdAt,
          weekly: r,
        ),
      ),
    ];

    items.sort((a, b) {
      final aDate = a.createdAt ?? DateTime(0);
      final bDate = b.createdAt ?? DateTime(0);
      return bDate.compareTo(aDate);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Recent', style: theme.textTheme.displaySmall),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = items[index];
            if (item.filing != null) {
              return SecFilingCard(
                filing: item.filing!.filing,
                financialReport: item.filing!.report,
                lastViewed: lastViewed,
              );
            }
            return WeeklyReportCard(
              report: item.weekly!,
              lastViewed: lastViewed,
            );
          },
        ),
      ],
    );
  }
}

class _RecentItem {
  final DateTime? createdAt;
  final FilingViewModel? filing;
  final WeeklyReport? weekly;

  const _RecentItem({this.createdAt, this.filing, this.weekly});
}
