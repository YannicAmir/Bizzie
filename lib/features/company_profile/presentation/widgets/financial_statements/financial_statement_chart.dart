import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  const FinancialStatementChart({
    super.key,
    required this.data,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: SfCartesianChart(
        enableSideBySideSeriesPlacement: false,
        plotAreaBorderWidth: 0,
        margin: EdgeInsets.zero,
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0), // Hide X axis line
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.textTertiary,
          ),
          axisLabelFormatter: (AxisLabelRenderDetails args) {
            // Check if label needs wrapping (e.g. "Net Income")
            // Actually Syncfusion supports auto wrapping if configured, but short labels are fine.
            return ChartAxisLabel(args.text, args.textStyle);
          },
        ),
        primaryYAxis: NumericAxis(
          opposedPosition: false, // Left side
          majorGridLines: const MajorGridLines(
            width: 0.665,
            color: AppColors.slate100,
            dashArray: [4, 4],
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: AppColors.textTertiary,
          ),
          numberFormat: NumberFormat.compactSimpleCurrency(
            locale: Localizations.localeOf(context).toString(),
            name: currency,
          ),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          format: 'point.x: point.y', // "Revenue : $564M"
          textStyle: GoogleFonts.inter(fontSize: 12, color: Colors.white),
        ),
        series: <CartesianSeries>[
          // Positive Values
          ColumnSeries<FinancialStatementChartData, String>(
            dataSource: data,
            xValueMapper: (FinancialStatementChartData datum, _) => datum.label,
            yValueMapper: (FinancialStatementChartData datum, _) =>
                datum.value >= 0 ? datum.value : null,
            pointColorMapper: (FinancialStatementChartData datum, _) =>
                datum.color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            width: 0.7,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
            animationDuration: AppConstants.kChartAnimationDuration,
            enableTooltip: true,
          ),
          // Negative Values
          ColumnSeries<FinancialStatementChartData, String>(
            dataSource: data,
            xValueMapper: (FinancialStatementChartData datum, _) => datum.label,
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
    );
  }
}
