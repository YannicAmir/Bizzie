import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_chart_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const String _innerRadius = '80%';
const String _radius = '58%';
const int _topCenterAngle = 270;
const double _segmentStrokeWidth = 3;
const String _connectorLength = '20%';
const double _connectorWidth = 0;

class BizziePieChartData {
  final String label;
  final double value;
  final Color color;

  const BizziePieChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class ChartCenterMetric extends StatelessWidget {
  final String label;
  final String value;

  const ChartCenterMetric({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.chartCenterMetricLabel),
        Text(
          value,
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class BizziePieChart extends StatefulWidget {
  final String title;
  final List<BizziePieChartData> data;
  final String currency;
  final Widget? centerWidget;

  const BizziePieChart({
    super.key,
    required this.title,
    required this.data,
    required this.currency,
    this.centerWidget,
  });

  @override
  State<BizziePieChart> createState() => _BizziePieChartState();
}

class _BizziePieChartState extends State<BizziePieChart> {
  late final TooltipBehavior _tooltipBehavior;

  String get _locale => Localizations.localeOf(context).toString();

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic pointData, _, _, _, _) {
        final item = pointData as BizziePieChartData;
        return BizzieChartTooltip(
          label: item.label,
          value: item.value,
          numberFormat: NumberFormat.compactSimpleCurrency(
            locale: _locale,
            name: widget.currency,
          ),
        );
      },
    );
  }

  void _onDataLabelRender(DataLabelRenderArgs args) {
    final int index = args.pointIndex;
    if (index < 0 || index >= widget.data.length) {
      return;
    }
    args.textStyle = AppTextStyles.chartDataLabel.copyWith(
      color: widget.data[index].color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget? center = widget.centerWidget;
    final String locale = _locale;

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
          Text(widget.title, style: AppTextStyles.h3),
          AppConstants.secondarySectionSpacing,
          SfCircularChart(
            margin: EdgeInsets.zero,
            annotations: <CircularChartAnnotation>[
              if (center != null) CircularChartAnnotation(widget: center),
            ],
            tooltipBehavior: _tooltipBehavior,
            onDataLabelRender: _onDataLabelRender,
            series: <CircularSeries>[
              DoughnutSeries<BizziePieChartData, String>(
                dataSource: widget.data,
                xValueMapper: (BizziePieChartData data, _) => data.label,
                yValueMapper: (BizziePieChartData data, _) => data.value,
                pointColorMapper: (BizziePieChartData data, _) => data.color,
                dataLabelMapper: (BizziePieChartData data, _) {
                  final formattedValue = CurrencyFormatter.formatCompact(
                    data.value,
                    widget.currency,
                    locale: locale,
                  );
                  return '${data.label}\n$formattedValue';
                },
                innerRadius: _innerRadius,
                radius: _radius,
                startAngle: _topCenterAngle,
                endAngle: _topCenterAngle,
                strokeColor: AppColors.white,
                strokeWidth: _segmentStrokeWidth,
                cornerStyle: CornerStyle.bothCurve,
                animationDuration: AppConstants.kChartAnimationDuration,
                enableTooltip: true,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelIntersectAction: LabelIntersectAction.shift,
                  connectorLineSettings: ConnectorLineSettings(
                    type: ConnectorType.line,
                    length: _connectorLength,
                    width: _connectorWidth,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
