import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';

extension FinancialDataPointListX on List<FinancialDataPoint> {
  double get averageValue {
    if (isEmpty) return 0.0;
    return fold<double>(0.0, (sum, item) => sum + item.value) / length;
  }

  double? getAverageOfLatest(int count) {
    if (length < count) return null;

    final sorted = List<FinancialDataPoint>.from(this)
      ..sort((a, b) => b.date.compareTo(a.date));

    final latest = sorted.take(count);
    return latest.fold<double>(0.0, (sum, item) => sum + item.value) / count;
  }
}
