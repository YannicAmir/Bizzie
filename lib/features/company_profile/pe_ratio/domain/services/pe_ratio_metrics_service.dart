import 'package:injectable/injectable.dart';

import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';

@lazySingleton
class PeRatioMetricsService {
  static const int _referenceWindowYears = 5;
  static const double _growthEpsilon = 0.001;

  List<FinancialDataPoint> extractSortedDataPoints(List<PeRatio> ratios) {
    final dataPoints = ratios
        .map(
          (r) => FinancialDataPoint(
            date: r.date,
            period: r.period,
            value: r.priceToEarningsRatio,
          ),
        )
        .toList();
    return dataPoints..sort((a, b) => a.date.compareTo(b.date));
  }

  FinancialDataPoint findReferencePoint(
    List<FinancialDataPoint> sortedPoints,
    FinancialDataPoint currentPoint,
  ) {
    var referencePoint = sortedPoints.first;
    final currentDate = DateTime.tryParse(currentPoint.date);

    if (currentDate != null && sortedPoints.length > 1) {
      final cutoffDate = DateTime(
        currentDate.year - _referenceWindowYears,
        currentDate.month,
        currentDate.day,
      );
      for (final p in sortedPoints) {
        final d = DateTime.tryParse(p.date);
        if (d != null && (d.isAfter(cutoffDate) || d == cutoffDate)) {
          referencePoint = p;
          break;
        }
      }
    }
    return referencePoint;
  }

  ({double delta, double percentage}) calculateGrowth(
    double currentValue,
    double referenceValue,
  ) {
    final delta = currentValue - referenceValue;
    final percentage = referenceValue.abs() < _growthEpsilon
        ? 0.0
        : (delta / referenceValue.abs()) * 100;
    return (delta: delta, percentage: percentage);
  }
}
