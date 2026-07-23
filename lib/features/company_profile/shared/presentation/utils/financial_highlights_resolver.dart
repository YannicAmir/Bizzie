import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Presentation view-model for a single financial highlight card.
typedef HighlightCardData = ({
  String title,
  String valueText,
  Color? valueColor,
  Color? backgroundColor,
});

/// Resolved primary (TTM) highlight plus an optional secondary highlight.
typedef FinancialHighlightsData = ({
  HighlightCardData primary,
  HighlightCardData? secondary,
});

/// Derives the financial highlight cards (trailing-twelve-months total plus an
/// optional CAGR / growth-rate secondary) from raw financial data points.
///
/// Keeps this derivation out of the widget layer: the widget only lays out the
/// resolved [FinancialHighlightsData].
abstract class FinancialHighlightsResolver {
  static const double _lowGrowthThreshold = 6.0;
  static const double _midGrowthThreshold = 13.0;
  static const String _percentPattern = '0.##';

  static FinancialHighlightsData? resolve({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
    required String ttmTitle,
    required String currency,
    required bool isAnnual,
    required String locale,
  }) {
    final ttmValue = quarterlyData.trailingTwelveMonthsTotal();
    if (ttmValue == null) return null;

    final primary = (
      title: ttmTitle,
      valueText: CurrencyFormatter.formatCompactFixed(
        ttmValue,
        currency,
        locale: locale,
      ),
      valueColor: null,
      backgroundColor: null,
    );

    return (
      primary: primary,
      secondary: _resolveSecondary(
        annualData: annualData,
        quarterlyData: quarterlyData,
        isAnnual: isAnnual,
        locale: locale,
      ),
    );
  }

  static HighlightCardData? _resolveSecondary({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
    required bool isAnnual,
    required String locale,
  }) {
    if (isAnnual) {
      if (annualData.length < 2) return null;

      final cagr = quarterlyData.trailingTwelveMonthsCagr();
      if (cagr != null) {
        final colors = _growthColors(cagr.percentage);
        return (
          title: '${cagr.years}Y CAGR',
          valueText: _formatPercentage(cagr.percentage, locale),
          valueColor: colors.textColor,
          backgroundColor: colors.bgColor,
        );
      }
    }

    return _resolveGrowth(quarterlyData, locale);
  }

  static HighlightCardData? _resolveGrowth(
    List<FinancialDataPoint> quarterlyData,
    String locale,
  ) {
    final growth = quarterlyData.trailingTwelveMonthsGrowth();
    if (growth == null) return null;

    switch (growth.outcome) {
      case TtmGrowthOutcome.turnedPositive:
        return (
          title: '1Y Growth Rate',
          valueText: 'Turned Positive',
          valueColor: AppColors.successText,
          backgroundColor: AppColors.successIconBackground,
        );
      case TtmGrowthOutcome.turnedNegative:
        return (
          title: '1Y Growth Rate',
          valueText: 'Turned Negative',
          valueColor: AppColors.red800,
          backgroundColor: AppColors.red100,
        );
      case TtmGrowthOutcome.notMeaningful:
        return (
          title: '1Y Growth Rate',
          valueText: 'N/M',
          valueColor: AppColors.slate700,
          backgroundColor: AppColors.slate100,
        );
      case TtmGrowthOutcome.numeric:
        final colors = _growthColors(growth.percentage);
        return (
          title: '1Y Growth Rate',
          valueText: _formatPercentage(growth.percentage, locale),
          valueColor: colors.textColor,
          backgroundColor: colors.bgColor,
        );
    }
  }

  static String _formatPercentage(double percentage, String locale) {
    final sign = percentage >= 0 ? '+' : '';
    final percentFormat = NumberFormat(_percentPattern, locale);
    return '$sign${percentFormat.format(percentage)}%';
  }

  static ({Color textColor, Color bgColor}) _growthColors(double percentage) {
    if (percentage < 0) {
      return (textColor: AppColors.red800, bgColor: AppColors.red100);
    } else if (percentage < _lowGrowthThreshold) {
      return (textColor: AppColors.orange700, bgColor: AppColors.orange100);
    } else if (percentage < _midGrowthThreshold) {
      return (
        textColor: AppColors.yellowHighlightText,
        bgColor: AppColors.yellowHighlightBackground,
      );
    } else {
      return (
        textColor: AppColors.successText,
        bgColor: AppColors.successIconBackground,
      );
    }
  }
}
