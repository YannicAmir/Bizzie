import 'package:injectable/injectable.dart';

import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../models/pfcf_ratio.dart';
import '../models/pfcf_ratio_stats.dart';

@lazySingleton
class PfcfRatioStatsService {
  static const int _referenceLookbackYears = 5;
  static const double _minReferenceValue = 0.001;

  PfcfRatioStats compute(List<PfcfRatio> ratios) {
    final dataPoints =
        ratios
            .where((r) => r.priceToFreeCashFlowRatio != 0)
            .map(
              (r) => FinancialDataPoint(
                date: r.date,
                period: r.period,
                value: r.priceToFreeCashFlowRatio,
              ),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    if (dataPoints.isEmpty) {
      return const PfcfRatioStats(
        dataPoints: [],
        currentValue: 0,
        growthPercentage: 0,
        absoluteDelta: 0,
        isPositive: false,
        referenceDate: '',
      );
    }

    final currentPoint = dataPoints.last;
    final referencePoint = _findReferencePoint(dataPoints, currentPoint);
    final delta = currentPoint.value - referencePoint.value;
    final percentage = referencePoint.value.abs() < _minReferenceValue
        ? 0.0
        : (delta / referencePoint.value.abs()) * 100;

    return PfcfRatioStats(
      dataPoints: dataPoints,
      currentValue: currentPoint.value,
      growthPercentage: percentage,
      absoluteDelta: delta.abs(),
      isPositive: delta >= 0,
      referenceDate: referencePoint.date,
    );
  }

  FinancialDataPoint _findReferencePoint(
    List<FinancialDataPoint> sortedPoints,
    FinancialDataPoint currentPoint,
  ) {
    var referencePoint = sortedPoints.first;
    final currentDate = DateTime.tryParse(currentPoint.date);

    if (currentDate != null && sortedPoints.length > 1) {
      final cutoffDate = DateTime(
        currentDate.year - _referenceLookbackYears,
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
}
