import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_chart_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceSheetPieChartData {
  final String label;
  final double value;
  final Color color;

  BalanceSheetPieChartData(this.label, this.value, this.color);
}

class BalanceSheetPieChart extends StatelessWidget {
  final String title;
  final List<BalanceSheetPieChartData> data;
  final double? totalValue;
  final String currency;

  const BalanceSheetPieChart({
    super.key,
    this.title = 'Chart',
    required this.data,
    this.totalValue,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.compactSimpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      name: currency,
    );

    // Tooltip behavior for the chart with shared widget
    final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      builder:
          (
            dynamic data,
            dynamic point,
            dynamic series,
            int pointIndex,
            int seriesIndex,
          ) {
            final item = data as BalanceSheetPieChartData;
            return BizzieChartTooltip(
              label: item.label,
              value: item.value,
              numberFormat: numberFormat,
            );
          },
    );

    final equityItem = data.where((e) => e.label == 'Equity').firstOrNull;
    final currentAssetsItem = data
        .where((e) => e.label == 'Current Assets')
        .firstOrNull;
    final currentLiabilitiesItem = data
        .where((e) => e.label == 'Current Liabilities')
        .firstOrNull;
    final ltDebtItem = data.where((e) => e.label == 'L.T. Debt').firstOrNull;
    final stDebtItem = data.where((e) => e.label == 'S.T. Debt').firstOrNull;

    Widget? centerWidget;

    if (currentAssetsItem != null && currentLiabilitiesItem != null) {
      final ratio = currentLiabilitiesItem.value != 0
          ? currentAssetsItem.value / currentLiabilitiesItem.value
          : 0.0;
      centerWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Current Ratio',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ratio.toStringAsFixed(2),
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ],
      );
    } else if (equityItem != null &&
        (ltDebtItem != null || stDebtItem != null)) {
      final totalDebt = (ltDebtItem?.value ?? 0) + (stDebtItem?.value ?? 0);
      final ratio = equityItem.value != 0 ? totalDebt / equityItem.value : 0.0;
      centerWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Debt-to-Equity',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ratio.toStringAsFixed(2),
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ],
      );
    } else if (equityItem != null) {
      centerWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Equity',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            _formatValue(equityItem.value),
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ],
      );
    }

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
          SfCircularChart(
            margin: EdgeInsets.zero,
            annotations: <CircularChartAnnotation>[
              if (centerWidget != null)
                CircularChartAnnotation(widget: centerWidget),
            ],
            tooltipBehavior: tooltipBehavior, // Enable tooltips
            series: <CircularSeries>[
              DoughnutSeries<BalanceSheetPieChartData, String>(
                dataSource: data,
                xValueMapper: (BalanceSheetPieChartData data, _) => data.label,
                yValueMapper: (BalanceSheetPieChartData data, _) => data.value,
                pointColorMapper: (BalanceSheetPieChartData data, _) =>
                    data.color,
                innerRadius: '80%',
                radius: '58%', // Reduced radius to afford more label space
                startAngle: 270,
                endAngle: 270,
                strokeColor: Colors.white,
                strokeWidth: 3,
                cornerStyle: CornerStyle.bothCurve,
                animationDuration: AppConstants.kChartAnimationDuration,
                enableTooltip: true, // Ensure series allows tooltips
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelIntersectAction: LabelIntersectAction.shift,
                  connectorLineSettings: const ConnectorLineSettings(
                    type: ConnectorType.line,
                    length: '20%', // Push labels out further
                    width: 0,
                    color: Colors.transparent,
                  ),
                  builder:
                      (
                        dynamic data,
                        dynamic point,
                        dynamic series,
                        int pointIndex,
                        int seriesIndex,
                      ) {
                        final item = data as BalanceSheetPieChartData;
                        // Percent removed per user request

                        final formattedValue = _formatValue(item.value);

                        return Text(
                          '${item.label}\n$formattedValue',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: item.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12, // Larger font
                            height: 1.2,
                          ),
                        );
                      },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatValue(double value) {
    final absVal = value.abs();
    if (absVal >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(1)}B';
    } else if (absVal >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(1)}M';
    } else if (absVal >= 1e3) {
      return '\$${(value / 1e3).toStringAsFixed(1)}K';
    }
    return '\$${value.toStringAsFixed(0)}';
  }
}
