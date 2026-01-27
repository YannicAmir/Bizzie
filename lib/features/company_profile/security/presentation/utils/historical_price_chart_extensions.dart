import 'dart:math';

import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';

extension HistoricalPriceListX on List<HistoricalPriceEod> {
  List<HistoricalPriceEod> filterByTimeFrame(ChartTimeFrame frame) {
    if (isEmpty) return [];

    final sorted = List<HistoricalPriceEod>.from(this)
      ..sort((a, b) => a.date.compareTo(b.date));

    final newestDate = DateTime.parse(sorted.last.date);
    DateTime? cutoff;

    switch (frame) {
      case ChartTimeFrame.d5:
        if (sorted.length > 5) {
          return sorted.sublist(sorted.length - 5);
        }
        return sorted;
      case ChartTimeFrame.m1:
        cutoff = newestDate.subtract(const Duration(days: 30));
        break;
      case ChartTimeFrame.m6:
        cutoff = newestDate.subtract(const Duration(days: 180));
        break;
      case ChartTimeFrame.y1:
        cutoff = newestDate.subtract(const Duration(days: 365));
        break;
      case ChartTimeFrame.y5:
        cutoff = newestDate.subtract(const Duration(days: 365 * 5));
        break;
      case ChartTimeFrame.all:
        cutoff = null;
        break;
    }

    if (cutoff != null) {
      return sorted.where((e) {
        final d = DateTime.tryParse(e.date);
        return d != null && d.isAfter(cutoff!);
      }).toList();
    }
    return sorted;
  }

  List<HistoricalPriceEod> downsample({int limit = 150}) {
    if (length <= limit) return List.from(this);

    final step = (length / limit).ceil();
    final sample = <HistoricalPriceEod>[];

    for (int i = 0; i < length; i += step) {
      sample.add(this[i]);
    }

    if (sample.last != last) {
      sample.add(last);
    }

    return sample;
  }

  double get minPrice {
    if (isEmpty) return 0;
    return map((e) => e.price).reduce(min) * 0.99;
  }

  double get maxPrice {
    if (isEmpty) return 0;
    return map((e) => e.price).reduce(max) * 1.01;
  }
}
