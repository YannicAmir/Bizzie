import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_chart_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class FinancialStatementChartData {
  final String label;
  final double value;
  final Color color;

  FinancialStatementChartData(this.label, this.value, this.color);
}

class FinancialStatementChart extends StatelessWidget {
  final List<FinancialStatementChartData> data;
  final String currency;
  final String title;

  const FinancialStatementChart({
    super.key,
    required this.data,
    required this.currency,
    this.title = 'Chart',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.compactSimpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      name: currency,
    );

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3),
          AppConstants.secondarySectionSpacing,
          SfCartesianChart(
            enableSideBySideSeriesPlacement: false,
            plotAreaBorderWidth: 0,
            margin: EdgeInsets.zero,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: AppTextStyles.bodySmallSecondary,
            ),
            primaryYAxis: NumericAxis(
              opposedPosition: false,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: AppTextStyles.bodySmallSecondary,
              maximumLabels: 1,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              numberFormat: numberFormat,
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              canShowMarker: false,
              builder: (data, point, series, pointIndex, seriesIndex) {
                final item = data as FinancialStatementChartData;
                return BizzieChartTooltip(
                  label: item.label,
                  value: item.value,
                  numberFormat: numberFormat,
                );
              },
            ),
            series: <CartesianSeries>[
              // Positive Values
              ColumnSeries<FinancialStatementChartData, String>(
                dataSource: data,
                xValueMapper: (FinancialStatementChartData datum, _) =>
                    datum.label,
                yValueMapper: (FinancialStatementChartData datum, _) =>
                    datum.value >= 0 ? datum.value : null,
                pointColorMapper: (FinancialStatementChartData datum, _) =>
                    datum.color,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                width: 0.7,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                animationDuration: AppConstants.kChartAnimationDuration,
                enableTooltip: true,
              ),
              // Negative Values
              ColumnSeries<FinancialStatementChartData, String>(
                dataSource: data,
                xValueMapper: (FinancialStatementChartData datum, _) =>
                    datum.label,
                yValueMapper: (FinancialStatementChartData datum, _) =>
                    datum.value < 0 ? datum.value : null,
                pointColorMapper: (FinancialStatementChartData datum, _) =>
                    datum.color,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
                width: 0.7,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                animationDuration: AppConstants.kChartAnimationDuration,
                enableTooltip: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
