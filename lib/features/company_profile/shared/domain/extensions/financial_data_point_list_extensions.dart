import 'dart:math';

import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';

enum TtmGrowthOutcome {
  numeric,
  turnedPositive,
  turnedNegative,
  notMeaningful,
}

const int _quartersPerYear = 4;
const int _minCagrYears = 2;
const int _maxCagrYears = 5;

extension FinancialDataPointListX on List<FinancialDataPoint> {
  double get averageValue {
    if (isEmpty) return 0.0;
    return fold<double>(0.0, (sum, item) => sum + item.value) / length;
  }

  List<FinancialDataPoint> sortedByDateDescending() {
    return List<FinancialDataPoint>.from(this)
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<FinancialDataPoint> sortedUniqueByDateDescending() {
    final seenDates = <String>{};
    return [
      for (final point in sortedByDateDescending())
        if (seenDates.add(point.date)) point,
    ];
  }

  double? getAverageOfLatest(int count) {
    if (count <= 0) return null;

    final latest = sortedUniqueByDateDescending();
    if (latest.length < count) return null;

    return latest
            .take(count)
            .fold<double>(0.0, (sum, item) => sum + item.value) /
        count;
  }

  double? trailingTwelveMonthsTotal() {
    final sorted = sortedUniqueByDateDescending();
    if (sorted.length < _quartersPerYear) return null;

    return sorted
        .take(_quartersPerYear)
        .fold<double>(0.0, (sum, item) => sum + item.value);
  }

  ({int years, double percentage})? trailingTwelveMonthsCagr() {
    final sorted = sortedUniqueByDateDescending();

    final maxYears = sorted.length ~/ _quartersPerYear;
    if (maxYears < _minCagrYears) return null;

    for (var years = min(_maxCagrYears, maxYears);
        years >= _minCagrYears;
        years--) {
      final skipCount = years * _quartersPerYear;
      if (sorted.length < skipCount + _quartersPerYear) continue;

      final endValue = sorted
          .take(_quartersPerYear)
          .fold<double>(0.0, (sum, item) => sum + item.value);
      final startValue = sorted
          .skip(skipCount)
          .take(_quartersPerYear)
          .fold<double>(0.0, (sum, item) => sum + item.value);

      if (startValue <= 0) continue;

      final cagr = (pow(endValue / startValue, 1 / years) as double) - 1;
      final percentage = cagr * 100;
      if (!percentage.isFinite) continue;

      return (years: years, percentage: percentage);
    }

    return null;
  }

  ({TtmGrowthOutcome outcome, double percentage})? trailingTwelveMonthsGrowth() {
    final sorted = sortedUniqueByDateDescending();
    if (sorted.length < _quartersPerYear * 2) return null;

    final current = sorted
        .take(_quartersPerYear)
        .fold<double>(0.0, (sum, item) => sum + item.value);
    final previous = sorted
        .skip(_quartersPerYear)
        .take(_quartersPerYear)
        .fold<double>(0.0, (sum, item) => sum + item.value);

    final previousIsProfit = previous > 0;
    final currentIsProfit = current >= 0;

    if (previousIsProfit && currentIsProfit) {
      final percentage = (current - previous) / previous * 100;
      return (outcome: TtmGrowthOutcome.numeric, percentage: percentage);
    }
    if (previousIsProfit && !currentIsProfit) {
      return (outcome: TtmGrowthOutcome.turnedNegative, percentage: 0.0);
    }
    if (!previousIsProfit && currentIsProfit) {
      return (outcome: TtmGrowthOutcome.turnedPositive, percentage: 0.0);
    }
    return (outcome: TtmGrowthOutcome.notMeaningful, percentage: 0.0);
  }
}
