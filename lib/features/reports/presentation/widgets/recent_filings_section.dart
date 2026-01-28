import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/reports/presentation/models/filing_view_model.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/sec_filing_card.dart';
import 'package:flutter/material.dart';

class RecentFilingsSection extends StatelessWidget {
  final List<FilingViewModel> filings;
  final DateTime? lastViewed;
  final String mascotAsset;

  const RecentFilingsSection({
    super.key,
    required this.filings,
    this.lastViewed,
    this.mascotAsset = AppAssets.defaultMascot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recentFilings = filings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Recent', style: theme.textTheme.displaySmall),
        ),
        if (recentFilings.isEmpty)
          BizzieEmptyState(
            mascotAsset: mascotAsset,
            message: 'There are no recent reports',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentFilings.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final viewModel = recentFilings[index];
              return SecFilingCard(
                filing: viewModel.filing,
                financialReport: viewModel.report,
                lastViewed: lastViewed,
              );
            },
          ),
      ],
    );
  }
}
