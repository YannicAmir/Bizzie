import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

typedef HighlightCardData = ({
  String title,
  String valueText,
  Color? valueColor,
  Color? backgroundColor,
});

typedef FinancialHighlightsData = ({
  HighlightCardData primary,
  HighlightCardData? secondary,
});

typedef GrowthHighlight = ({GrowthBand band, int years});

typedef _SecondaryMetric = ({
  String title,
  TtmGrowthOutcome outcome,
  double percentage,
  int years,
});

typedef _TtmSnapshot = ({double ttmValue, _SecondaryMetric? metric});

abstract class FinancialHighlightsResolver {
  static const double _lowGrowthThreshold = 6.0;
  static const double _midGrowthThreshold = 13.0;
  static const String _percentPattern = '0.##';
  static const String _oneYearGrowthTitle = '1Y Growth Rate';
  static const int _oneYearGrowthYears = 1;
  static const int _minAnnualDataPoints = 2;

  static FinancialHighlightsData? resolveAnnual({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
    required String ttmTitle,
    required String currency,
    required String locale,
  }) => _resolveHighlights(
    _annualSnapshot(annualData: annualData, quarterlyData: quarterlyData),
    ttmTitle: ttmTitle,
    currency: currency,
    locale: locale,
  );

  static FinancialHighlightsData? resolveQuarterly({
    required List<FinancialDataPoint> quarterlyData,
    required String ttmTitle,
    required String currency,
    required String locale,
  }) => _resolveHighlights(
    _ttmSnapshot(quarterlyData, _oneYearMetric(quarterlyData)),
    ttmTitle: ttmTitle,
    currency: currency,
    locale: locale,
  );

  static GrowthHighlight? resolveAnnualGrowth({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
  }) {
    final metric = _annualSnapshot(
      annualData: annualData,
      quarterlyData: quarterlyData,
    )?.metric;
    if (metric == null) return null;

    final band = _growthBand(metric);
    if (band == null) return null;

    return (band: band, years: metric.years);
  }

  static _TtmSnapshot? _annualSnapshot({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
  }) => _ttmSnapshot(
    quarterlyData,
    _annualMetric(annualData: annualData, quarterlyData: quarterlyData),
  );

  static _TtmSnapshot? _ttmSnapshot(
    List<FinancialDataPoint> quarterlyData,
    _SecondaryMetric? metric,
  ) {
    final ttmValue = quarterlyData.trailingTwelveMonthsTotal();
    if (ttmValue == null) return null;

    return (ttmValue: ttmValue, metric: metric);
  }

  static FinancialHighlightsData? _resolveHighlights(
    _TtmSnapshot? snapshot, {
    required String ttmTitle,
    required String currency,
    required String locale,
  }) {
    if (snapshot == null) return null;

    final metric = snapshot.metric;

    return (
      primary: (
        title: ttmTitle,
        valueText: CurrencyFormatter.formatCompactFixed(
          snapshot.ttmValue,
          currency,
          locale: locale,
        ),
        valueColor: null,
        backgroundColor: null,
      ),
      secondary: metric == null ? null : _secondaryCard(metric, locale),
    );
  }

  static _SecondaryMetric? _annualMetric({
    required List<FinancialDataPoint> annualData,
    required List<FinancialDataPoint> quarterlyData,
  }) {
    if (annualData.length < _minAnnualDataPoints) return null;

    final cagr = quarterlyData.trailingTwelveMonthsCagr();
    if (cagr == null) return _oneYearMetric(quarterlyData);

    return (
      title: '${cagr.years}Y CAGR',
      outcome: TtmGrowthOutcome.numeric,
      percentage: cagr.percentage,
      years: cagr.years,
    );
  }

  static _SecondaryMetric? _oneYearMetric(
    List<FinancialDataPoint> quarterlyData,
  ) {
    final growth = quarterlyData.trailingTwelveMonthsGrowth();
    if (growth == null) return null;

    return (
      title: _oneYearGrowthTitle,
      outcome: growth.outcome,
      percentage: growth.percentage,
      years: _oneYearGrowthYears,
    );
  }

  static HighlightCardData _secondaryCard(
    _SecondaryMetric metric,
    String locale,
  ) {
    final band = _growthBand(metric);
    final colors = band == null
        ? (textColor: AppColors.slate700, backgroundColor: AppColors.slate100)
        : _growthColors(band);

    return (
      title: metric.title,
      valueText: switch (metric.outcome) {
        TtmGrowthOutcome.numeric => _formatPercentage(
          metric.percentage,
          locale,
        ),
        TtmGrowthOutcome.turnedPositive => 'Turned Positive',
        TtmGrowthOutcome.turnedNegative => 'Turned Negative',
        TtmGrowthOutcome.notMeaningful => 'N/M',
      },
      valueColor: colors.textColor,
      backgroundColor: colors.backgroundColor,
    );
  }

  static GrowthBand? _growthBand(_SecondaryMetric metric) =>
      switch (metric.outcome) {
        TtmGrowthOutcome.numeric => _numericGrowthBand(metric.percentage),
        TtmGrowthOutcome.turnedPositive => GrowthBand.turnedPositive,
        TtmGrowthOutcome.turnedNegative => GrowthBand.turnedNegative,
        TtmGrowthOutcome.notMeaningful => null,
      };

  static GrowthBand _numericGrowthBand(double percentage) {
    if (percentage < 0) return GrowthBand.negative;
    if (percentage < _lowGrowthThreshold) return GrowthBand.low;
    if (percentage < _midGrowthThreshold) return GrowthBand.moderate;
    return GrowthBand.high;
  }

  static String _formatPercentage(double percentage, String locale) {
    final sign = percentage >= 0 ? '+' : '';
    final percentFormat = NumberFormat(_percentPattern, locale);
    return '$sign${percentFormat.format(percentage)}%';
  }

  static ({Color textColor, Color backgroundColor}) _growthColors(
    GrowthBand band,
  ) => switch (band) {
    GrowthBand.negative || GrowthBand.turnedNegative => (
      textColor: AppColors.red800,
      backgroundColor: AppColors.red100,
    ),
    GrowthBand.low => (
      textColor: AppColors.orange700,
      backgroundColor: AppColors.orange100,
    ),
    GrowthBand.moderate => (
      textColor: AppColors.yellowHighlightText,
      backgroundColor: AppColors.yellowHighlightBackground,
    ),
    GrowthBand.high || GrowthBand.turnedPositive => (
      textColor: AppColors.successText,
      backgroundColor: AppColors.successIconBackground,
    ),
  };
}
