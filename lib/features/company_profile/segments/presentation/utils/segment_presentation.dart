import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/segments/domain/extensions/revenue_segment_extensions.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/growth_display_formatter.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_pie_chart.dart';
import 'package:flutter/material.dart';

abstract class SegmentPresentation {
  static Color colorFor(String topic, Map<String, int> colorIndices) {
    final index = colorIndices[topic] ?? 0;
    return AppColors.chartCategoricalPool[index %
        AppColors.chartCategoricalPool.length];
  }

  static List<BizziePieChartData> chartData(
    RevenueSegment segment,
    Map<String, int> colorIndices,
  ) {
    final entries = _entriesByValueDesc(
      segment.data.entries.where((entry) => entry.value > 0),
    );

    return entries
        .map(
          (entry) => BizziePieChartData(
            label: entry.key,
            value: entry.value,
            color: colorFor(entry.key, colorIndices),
          ),
        )
        .toList();
  }

  static List<FinancialStatementTableRow> tableRows({
    required RevenueSegment? current,
    required RevenueSegment? previous,
    required Map<String, int> colorIndices,
    required String currency,
    required String locale,
  }) {
    if (current == null && previous == null) return const [];

    final topics = <String>[
      ...?_sortedTopics(current),
      ...?_sortedTopics(previous),
    ];
    final seen = <String>{};

    return [
      for (final topic in topics)
        if (seen.add(topic))
          _buildRow(
            topic: topic,
            current: current?.data[topic],
            previous: previous?.data[topic],
            growthPercent: current?.growthPercentFor(topic, previous: previous),
            colorIndices: colorIndices,
            currency: currency,
            locale: locale,
          ),
    ];
  }

  static List<String>? _sortedTopics(RevenueSegment? segment) {
    if (segment == null) return null;
    return _entriesByValueDesc(
      segment.data.entries,
    ).map((entry) => entry.key).toList();
  }

  static List<MapEntry<String, double>> _entriesByValueDesc(
    Iterable<MapEntry<String, double>> entries,
  ) => entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  static FinancialStatementTableRow _buildRow({
    required String topic,
    required double? current,
    required double? previous,
    required double? growthPercent,
    required Map<String, int> colorIndices,
    required String currency,
    required String locale,
  }) {
    final growth = GrowthDisplayFormatter.format(growthPercent);

    return FinancialStatementTableRow(
      metric: topic,
      amount: _format(current, currency, locale),
      secondaryValue: _format(previous, currency, locale),
      growth: growth.text,
      growthColor: growth.color,
      indicatorColor: colorFor(topic, colorIndices),
    );
  }

  static String _format(double? value, String currency, String locale) =>
      value == null
      ? '-'
      : CurrencyFormatter.formatCompact(value, currency, locale: locale);
}
