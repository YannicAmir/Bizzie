import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/models/chart_data_point.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_chart_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BizzieLineChart extends StatelessWidget {
  final List<ChartDataPoint> data;
  final Color? lineColor;
  final Color? tooltipColor;
  final BadgeThemeExtension? badgeTheme;
  final double height;
  final int maximumXLabels;
  final int maximumYLabels;
  final String Function(String)? xLabelFormatter;
  final String Function(String)? tooltipLabelFormatter;
  final NumberFormat? numberFormat;
  final double? minY;
  final double? maxY;
  final bool showHorizontalGridLines;
  final bool showTrackballLines;

  const BizzieLineChart({
    super.key,
    required this.data,
    this.lineColor,
    this.tooltipColor,
    this.badgeTheme,
    this.height = 250,
    this.maximumXLabels = 2,
    this.maximumYLabels = 2,
    this.xLabelFormatter,
    this.tooltipLabelFormatter,
    this.numberFormat,
    this.minY,
    this.maxY,
    this.showHorizontalGridLines = false,
    this.showTrackballLines = false,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    final firstValue = data.first.value;
    final lastValue = data.last.value;
    final isPositive = lastValue >= firstValue;

    final effectiveLineColor =
        lineColor ??
        (isPositive
            ? (badgeTheme?.goodText ?? AppColors.goodText)
            : (badgeTheme?.criticalText ?? AppColors.criticalText));

    final calculatedMinY =
        minY ?? data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final calculatedMaxY =
        maxY ?? data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: SfCartesianChart(
        key: ValueKey(
          'line_chart_${data.length}_${data.isNotEmpty ? data.first.label : ''}',
        ),
        margin: EdgeInsets.zero,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          isVisible: true,
          labelPlacement: LabelPlacement.onTicks,
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: AppTextStyles.bodySmallSecondary,
          maximumLabels: maximumXLabels,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          axisLabelFormatter: xLabelFormatter != null
              ? (AxisLabelRenderDetails args) {
                  return ChartAxisLabel(
                    xLabelFormatter!(args.text),
                    args.textStyle,
                  );
                }
              : null,
        ),
        primaryYAxis: NumericAxis(
          isVisible: true,
          opposedPosition: true,
          majorGridLines: MajorGridLines(
            width: showHorizontalGridLines ? 0.67 : 0,
            color: theme.dividerColor,
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: AppTextStyles.bodySmallSecondary,
          minimum: calculatedMinY,
          maximum: calculatedMaxY,
          decimalPlaces: 2,
          maximumLabels: maximumYLabels,
          plotOffsetStart: AppConstants.chartPlotOffsetStart,
          plotOffsetEnd: AppConstants.chartPlotOffsetStart,
        ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: InteractiveTooltip(
            enable: true,
            color: tooltipColor ?? theme.colorScheme.inverseSurface,
          ),
          markerSettings: TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible,
            color: effectiveLineColor.withValues(alpha: 0.2),
            width: 10,
            height: 10,
          ),
          lineType: showTrackballLines
              ? TrackballLineType.vertical
              : TrackballLineType.none,
          lineColor: theme.colorScheme.onSurfaceVariant,
          lineDashArray: const <double>[5, 5],
          builder: (BuildContext context, TrackballDetails trackballDetails) {
            final point = trackballDetails.point;
            if (point == null) {
              return const SizedBox.shrink();
            }

            final xValue = point.x;
            final yValue = point.y;
            if (xValue == null || yValue == null) {
              return const SizedBox.shrink();
            }

            final label = tooltipLabelFormatter != null
                ? tooltipLabelFormatter!(xValue as String)
                : xValue as String;

            return BizzieChartTooltip(
              label: label,
              value: yValue.toDouble(),
              backgroundColor: tooltipColor,
              numberFormat: numberFormat,
            );
          },
        ),
        series: <CartesianSeries>[
          SplineSeries<ChartDataPoint, String>(
            dataSource: data,
            xValueMapper: (ChartDataPoint data, _) => data.label,
            yValueMapper: (ChartDataPoint data, _) => data.value,
            color: effectiveLineColor,
            width: AppConstants.chartLineWidth,
            animationDuration: AppConstants.kChartAnimationDuration,
          ),
        ],
      ),
    );
  }
}
