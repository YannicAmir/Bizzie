import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_chart_tooltip.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BizzieChartData {
  final String label;
  final double value;
  final Color? color;

  BizzieChartData(this.label, this.value, {this.color});
}

class BizzieBarChart extends StatelessWidget {
  final List<BizzieChartData> data;
  final Color positiveColor;
  final Color negativeColor;
  final double height;
  final int? visibleCount;
  final NumberFormat? numberFormat;

  const BizzieBarChart({
    super.key,
    required this.data,
    this.positiveColor = AppColors.primary,
    this.negativeColor = AppColors.error,
    this.height = 250,
    this.visibleCount = 8,
    this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final isSubscribed = state.maybeMap(
            loaded: (s) => s.user.isSubscribed,
            orElse: () => false,
          );

          return SfCartesianChart(
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: isSubscribed && visibleCount != null,
              enablePinching: false,
              zoomMode: ZoomMode.x,
            ),
            enableSideBySideSeriesPlacement: false,
            plotAreaBorderWidth: 0,
            margin: EdgeInsets.zero,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: AppTextStyles.bodySmallSecondary,
              maximumLabels: 1,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              autoScrollingDelta: visibleCount,
              autoScrollingMode: AutoScrollingMode.end,
            ),
            primaryYAxis: NumericAxis(
              isVisible: true,
              opposedPosition: true,
              anchorRangeToVisiblePoints: true,
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: AppTextStyles.bodySmallSecondary,
              numberFormat:
                  numberFormat ?? NumberFormat.simpleCurrency(decimalDigits: 2),
              maximumLabels: 1,
            ),
            series: <CartesianSeries<BizzieChartData, String>>[
              ColumnSeries<BizzieChartData, String>(
                dataSource: data,
                xValueMapper: (BizzieChartData data, _) => data.label,
                yValueMapper: (BizzieChartData data, _) =>
                    data.value >= 0 ? data.value : null,
                pointColorMapper: (BizzieChartData data, _) =>
                    data.color ?? positiveColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.chartBarBorderRadius),
                  topRight: Radius.circular(AppConstants.chartBarBorderRadius),
                ),
                width: 0.8,
                enableTooltip: true,
                animationDuration: AppConstants.kChartAnimationDuration,
              ),
              ColumnSeries<BizzieChartData, String>(
                dataSource: data,
                xValueMapper: (BizzieChartData data, _) => data.label,
                yValueMapper: (BizzieChartData data, _) =>
                    data.value < 0 ? data.value : null,
                pointColorMapper: (BizzieChartData data, _) =>
                    data.color ?? negativeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    AppConstants.chartBarBorderRadius,
                  ),
                  bottomRight: Radius.circular(
                    AppConstants.chartBarBorderRadius,
                  ),
                ),
                width: 0.8,
                enableTooltip: true,
                animationDuration: AppConstants.kChartAnimationDuration,
              ),
            ],
            tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              canShowMarker: false,
              builder: (data, point, series, pointIndex, seriesIndex) {
                return BizzieChartTooltip(
                  label: point.x as String,
                  value: (point.y as num).toDouble(),
                  numberFormat: numberFormat,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
