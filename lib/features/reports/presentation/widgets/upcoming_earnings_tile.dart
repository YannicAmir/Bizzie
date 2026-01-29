import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpcomingEarningsTile extends StatelessWidget {
  final UpcomingEarnings earnings;
  final bool isLast;

  const UpcomingEarningsTile({
    super.key,
    required this.earnings,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoutes.companyProfileReports,
          pathParameters: {'ticker': earnings.symbol},
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    earnings.companyName,
                    style: theme.textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    earnings.symbol,
                    style: AppTextStyles.bodyMediumSecondary,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ReportsDateFormatter.getRelativeDateLabel(earnings.date),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Earnings • ${ReportsDateFormatter.formatReportDate(earnings.date)}',
                  style: AppTextStyles.bodyMediumSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
