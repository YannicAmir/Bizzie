import 'package:bizzie/features/reports/presentation/models/reports_feed_item.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_filing_card.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_weekly_report_card.dart';
import 'package:material_ui/material_ui.dart';

class ReportsFeedItemCard extends StatelessWidget {
  final ReportsFeedItem item;

  const ReportsFeedItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      ReportsFeedFilingItem(:final viewModel) => ReportsFilingCard(
        filing: viewModel.filing,
        financialReport: viewModel.report,
      ),
      ReportsFeedWeeklyItem(:final report) => ReportsWeeklyReportCard(
        report: report,
      ),
    };
  }
}
