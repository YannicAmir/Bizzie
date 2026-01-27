import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class FinancialHistoryHeader extends StatelessWidget {
  final String label;
  final String header1;
  final String header2;
  final String header3;

  const FinancialHistoryHeader({
    super.key,
    required this.label,
    required this.header1,
    required this.header2,
    required this.header3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            header1,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            header2,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            header3,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
      ],
    );
  }
}

class FinancialHistoryRow extends StatelessWidget {
  final String label;
  final String value1;
  final String value2;
  final String value3;
  final Color? value3Color;

  const FinancialHistoryRow({
    super.key,
    required this.label,
    required this.value1,
    required this.value2,
    required this.value3,
    this.value3Color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value1,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value2,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value3,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMediumBold.copyWith(
              color: value3Color ?? AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
