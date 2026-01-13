import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: theme.dividerTheme.color ?? AppColors.inputBorder,
                    width: 0.665,
                  ),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    earnings.companyName,
                    style: AppTextStyles.bodyLargeBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    earnings.symbol,
                    style: AppTextStyles.bodySmallMedium.copyWith(
                      fontSize: 13,
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ReportsDateFormatter.getRelativeDateLabel(earnings.date),
                  style: AppTextStyles.bodyMediumBold.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Earnings • ${ReportsDateFormatter.formatReportDate(earnings.date)}',
                  style: AppTextStyles.bodySmallMedium.copyWith(
                    color: AppColors.slate500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
