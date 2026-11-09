import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CurrencyConversionNotice extends StatelessWidget {
  final String? originalCurrency;
  final String displayedCurrency;

  const CurrencyConversionNotice({
    super.key,
    required this.originalCurrency,
    required this.displayedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final original = originalCurrency;
    if (original == null || original == displayedCurrency) {
      return AppConstants.mainSectionSpacing;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppConstants.subSectionSpacing,
        Text(
          'Original currency $original, converted to $displayedCurrency',
          style: AppTextStyles.bodySmallSecondary,
          textAlign: TextAlign.center,
        ),
        AppConstants.subSectionSpacing,
      ],
    );
  }
}
