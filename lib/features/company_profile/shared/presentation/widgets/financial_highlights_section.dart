import 'dart:math';

import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialHighlightsSection extends StatelessWidget {
  final List<FinancialDataPoint> annualData;
  final List<FinancialDataPoint> quarterlyData;
  final String ttmTitle;
  final String currency;
  final bool isAnnual;

  const FinancialHighlightsSection({
    super.key,
    required this.annualData,
    required this.quarterlyData,
    required this.ttmTitle,
    required this.currency,
    this.isAnnual = true,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Availability Check: If < 4 quarters, hide section.
    if (quarterlyData.length < 4) {
      return const SizedBox.shrink();
    }

    // 2. TTM Calculation: Sum of last 4 quarters.
    final sortedQuarterly = List<FinancialDataPoint>.from(quarterlyData)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Ensure we have enough data for TTM
    if (sortedQuarterly.length < 4) return const SizedBox.shrink();

    final last4 = sortedQuarterly.take(4);
    final ttmValue = last4.fold(0.0, (sum, e) => sum + e.value);

    // 3. Secondary Card Logic (CAGR or 1Y Growth)
    Widget? secondaryCard;
    if (isAnnual) {
      // 5Y CAGR
      final showCagr = annualData.length >= 2; // Need at least start and end
      if (showCagr) {
        secondaryCard =
            _buildCagrCard(annualData, quarterlyData) ??
            _build1YGrowthCard(sortedQuarterly);
      }
    } else {
      // 1Y Growth (Quarterly)
      // We need at least 5 quarters to compare Q(now) vs Q(now-4)
      if (sortedQuarterly.length >= 5) {
        secondaryCard = _build1YGrowthCard(sortedQuarterly);
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _HighlightCard(
                title: ttmTitle,
                value: ttmValue,
                isCurrency: true,
                currency: currency,
              ),
            ),
            if (secondaryCard != null) ...[
              const SizedBox(width: 8),
              Expanded(child: secondaryCard),
            ],
          ],
        ),
      ],
    );
  }

  Widget? _buildCagrCard(
    List<FinancialDataPoint> annualData,
    List<FinancialDataPoint> quarterlyData,
  ) {
    // True Quarterly TTM-based CAGR for N years
    // We need at least 8 quarters to do a 1-year Growth (which is handled by 1Y Growth widget)
    // For CAGR, we usually want 2+ years.
    // Length requirements:
    // 2 Years: need 4 (current) + 4 (gap) + 4 (past) = 12? No.
    // TTM Now: indices 0..3
    // TTM 1Y Ago: indices 4..7
    // TTM 2Y Ago: indices 8..11

    // Formula: User defines "NY CAGR" as comparing Year N vs Year 1 (which is a time delta of N-1 years).
    // e.g. 5Y CAGR uses 5 years of data, comparing Year 5 (Current) vs Year 1 (4 years ago).

    final sortedQuarterly = List<FinancialDataPoint>.from(quarterlyData)
      ..sort((a, b) => b.date.compareTo(a.date));

    // We need at least 2 years of data (8 quarters) to show a "2Y CAGR" (1 year gap)
    if (sortedQuarterly.length < 8) return null;

    int maxYears = (sortedQuarterly.length / 4).floor();
    if (maxYears < 2) return null;

    // Iterate backwards from 5 down to 2
    for (int years = min(5, maxYears); years >= 2; years--) {
      // Skip Years * 4 quarters
      final skipCount = years * 4;

      final endVal = sortedQuarterly
          .take(4)
          .fold(0.0, (sum, e) => sum + e.value);
      final startVal = sortedQuarterly
          .skip(skipCount)
          .take(4)
          .fold(0.0, (sum, e) => sum + e.value);

      // Rule: If start value is negative (or zero), treat as if it does not exist
      // and keep doing this until we reach a positive value.
      if (startVal <= 0) continue;

      // Exponent is 1 / years (User defined logic)
      final cagr = (pow(endVal / startVal, 1 / years) as double) - 1;
      final percentage = (cagr * 100);

      // If result is NaN (shouldn't happen with startVal > 0 check, but safe guard)
      if (percentage.isNaN) continue;

      final colors = _getGrowthColors(percentage);

      return _HighlightCard(
        title: '${years}Y CAGR',
        value: percentage,
        isPercentage: true,
        valueColor: colors.textColor,
        backgroundColor: colors.bgColor,
      );
    }

    return null;
  }

  Widget? _build1YGrowthCard(List<FinancialDataPoint> sortedQuarterly) {
    // We need 8 quarters to compare "Latest Year (4 quarters)" vs "Previous Year (4 quarters)"
    if (sortedQuarterly.length < 8) return null;

    final ttmCurrent = sortedQuarterly
        .take(4)
        .fold(0.0, (sum, e) => sum + e.value);
    final ttmPrevious = sortedQuarterly
        .skip(4)
        .take(4)
        .fold(0.0, (sum, e) => sum + e.value);

    if (ttmPrevious == 0) return null;

    final growth = (ttmCurrent - ttmPrevious) / ttmPrevious;
    final percentage = growth * 100;

    final colors = _getGrowthColors(percentage);

    return _HighlightCard(
      title: '1Y Growth Rate',
      value: percentage,
      isPercentage: true,
      valueColor: colors.textColor,
      backgroundColor: colors.bgColor,
    );
  }

  ({Color textColor, Color bgColor}) _getGrowthColors(double percentage) {
    if (percentage < 0) {
      return (textColor: AppColors.red800, bgColor: AppColors.red100);
    } else if (percentage < 6.0) {
      // 0 - 5.99
      return (textColor: AppColors.orange700, bgColor: AppColors.orange100);
    } else if (percentage < 13.0) {
      // 6 - 12.99
      return (
        textColor: AppColors.yellowHighlightText,
        bgColor: AppColors.yellowHighlightBackground,
      );
    } else {
      // 13+
      return (
        textColor: AppColors.successText,
        bgColor: AppColors.successIconBackground,
      );
    }
  }
}

class _HighlightCard extends StatelessWidget {
  final String title;
  final double value;
  final bool isCurrency;
  final String? currency;
  final bool isPercentage;
  final Color? valueColor;
  final Color? backgroundColor;

  const _HighlightCard({
    required this.title,
    required this.value,
    this.isCurrency = false,
    this.currency,
    this.isPercentage = false,
    this.valueColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String valueStr;
    if (isCurrency) {
      valueStr = CurrencyFormatter.formatCompactFixed(
        value,
        currency,
        locale: Localizations.localeOf(context).toString(),
      );
    } else if (isPercentage) {
      final sign = value >= 0 ? '+' : '';
      final f = NumberFormat("0.##", "en_US");
      valueStr = '$sign${f.format(value)}%';
    } else {
      valueStr = value.toString();
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: backgroundColor ?? theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.bodyMediumBoldSecondary),
          AppConstants.subSectionSpacing,
          Text(
            valueStr,
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
