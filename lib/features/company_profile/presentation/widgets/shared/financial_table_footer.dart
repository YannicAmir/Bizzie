import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class FinancialTableFooter extends StatelessWidget {
  final List<FinancialTableFooterColumnData> columns;

  const FinancialTableFooter({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final (index, column) in columns.indexed) ...[
          FinancialTableFooterColumn(label: column.label, value: column.value),
          if (index < columns.length - 1) const Spacer(),
        ],
      ],
    );
  }
}

class FinancialTableFooterColumn extends StatelessWidget {
  final String label;
  final String value;

  const FinancialTableFooterColumn({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMediumBoldSecondary),
        AppConstants.subSectionSpacing,
        Text(value, style: AppTextStyles.bodyLargeBold),
      ],
    );
  }
}

class FinancialTableFooterColumnData {
  final String label;
  final String value;

  FinancialTableFooterColumnData({required this.label, required this.value});
}
