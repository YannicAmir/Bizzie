import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class FinancialStatementsTable extends StatelessWidget {
  final String title;
  final List<FinancialStatementTableRow> rows;
  final VoidCallback? onViewAll;
  final bool showPercentage;
  final String growthHeader;
  final AlignmentGeometry amountAlignment;
  final TextAlign amountTextAlign;

  const FinancialStatementsTable({
    super.key,
    this.title = 'Table',
    required this.rows,
    this.onViewAll,
    this.showPercentage = true,
    this.growthHeader = 'Growth',
    this.amountAlignment = Alignment.centerRight,
    this.amountTextAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metricFlex = showPercentage ? 3 : 2;
    final amountFlex = showPercentage ? 2 : 3;
    final growthFlex = showPercentage ? 2 : 1;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: Text(title, style: AppTextStyles.h3),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: metricFlex,
                  child: _buildHeaderCell('Metric', Alignment.centerLeft),
                ),
                Expanded(
                  flex: amountFlex,
                  child: _buildHeaderCell('Amount', amountAlignment),
                ),
                if (showPercentage)
                  Expanded(
                    flex: 2,
                    child: _buildHeaderCell('%', Alignment.centerRight),
                  ),
                Expanded(
                  flex: growthFlex,
                  child: _buildHeaderCell(growthHeader, Alignment.centerRight),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rows.length,
            itemBuilder: (context, index) {
              final row = rows[index];
              return Padding(
                padding: const EdgeInsets.all(
                  AppConstants.mainSectionContainerPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: metricFlex,
                      child: Text(row.metric, style: AppTextStyles.bodyMedium),
                    ),
                    Expanded(
                      flex: amountFlex,
                      child: Text(
                        row.amount,
                        textAlign: amountTextAlign,
                        style: AppTextStyles.bodyMediumBold,
                      ),
                    ),
                    if (showPercentage)
                      Expanded(
                        flex: 2,
                        child: Text(
                          row.percentage,
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodyMediumBold,
                        ),
                      ),
                    Expanded(
                      flex: growthFlex,
                      child: Text(
                        row.growth,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.bodyMediumBold.copyWith(
                          color: row.growthColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (onViewAll != null) ...[
            const Divider(height: 1, color: AppColors.slate50),
            InkWell(
              onTap: onViewAll,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'View All',
                    style: AppTextStyles.bodyMediumBold.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: Text(text, style: AppTextStyles.bodyMediumBoldSecondary),
    );
  }
}

class FinancialStatementTableRow {
  final String metric;
  final String amount;
  final String percentage;
  final String growth;
  final Color growthColor;
  final bool isBold;

  const FinancialStatementTableRow({
    required this.metric,
    required this.amount,
    required this.percentage,
    required this.growth,
    required this.growthColor,
    this.isBold = false,
  });
}
