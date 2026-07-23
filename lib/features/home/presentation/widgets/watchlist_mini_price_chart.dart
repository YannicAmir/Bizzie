import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const double _sessionOpenMinute = 9 * 60 + 30;
const double _sessionCloseMinute = 16 * 60;

const List<double> _previousCloseDashArray = [3, 3];
const double _previousCloseLineWidth = 1;
const double _splineLineWidth = 1.5;

const double _yRangePaddingFactor = 0.08;
const double _flatSeriesMinYPadding = 0.01;

class WatchlistMiniPriceChart extends StatelessWidget {
  final WatchlistStockPrice stockPrice;

  const WatchlistMiniPriceChart({super.key, required this.stockPrice});

  bool get _isPositive => (stockPrice.changePercent ?? 0) >= 0;

  List<_MiniChartPoint> get _splinePoints => stockPrice.series
      .map(
        (point) => _MiniChartPoint(
          _minutesSinceMidnight(point.time),
          point.close,
        ),
      )
      .where((point) => point.minutes != null)
      .toList();

  static int? _minutesSinceMidnight(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return null;
    final hours = int.tryParse(parts[0]);
    final minutes = int.tryParse(parts[1]);
    if (hours == null || minutes == null) return null;
    return hours * 60 + minutes;
  }

  ({double min, double max}) _yRange(List<_MiniChartPoint> points) {
    final previousClose = stockPrice.previousClose;
    final values = [
      ...points.map((point) => point.close),
      if (previousClose != null) previousClose,
    ];
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final padding = (max - min) == 0
        ? (max.abs() * _yRangePaddingFactor).clamp(
            _flatSeriesMinYPadding,
            double.infinity,
          )
        : (max - min) * _yRangePaddingFactor;
    return (min: min - padding, max: max + padding);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final splinePoints = _splinePoints;
    final previousClose = stockPrice.previousClose;

    if (splinePoints.isEmpty && previousClose == null) {
      return const SizedBox.shrink();
    }

    final lineColor = _isPositive
        ? (badgeTheme?.goodText ?? AppColors.goodText)
        : (badgeTheme?.criticalText ?? AppColors.criticalText);
    final range = _yRange(splinePoints);

    return IgnorePointer(
      child: SfCartesianChart(
        margin: EdgeInsets.zero,
        plotAreaBorderWidth: 0,
        primaryXAxis: const NumericAxis(
          isVisible: false,
          minimum: _sessionOpenMinute,
          maximum: _sessionCloseMinute,
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: range.min,
          maximum: range.max,
        ),
        series: <CartesianSeries<_MiniChartPoint, num>>[
          if (previousClose != null)
            LineSeries<_MiniChartPoint, num>(
              dataSource: [
                _MiniChartPoint(_sessionOpenMinute, previousClose),
                _MiniChartPoint(_sessionCloseMinute, previousClose),
              ],
              xValueMapper: (point, _) => point.minutes,
              yValueMapper: (point, _) => point.close,
              color: theme.colorScheme.onSurfaceVariant,
              width: _previousCloseLineWidth,
              dashArray: _previousCloseDashArray,
              animationDuration: 0,
            ),
          if (splinePoints.isNotEmpty)
            SplineSeries<_MiniChartPoint, num>(
              dataSource: splinePoints,
              xValueMapper: (point, _) => point.minutes,
              yValueMapper: (point, _) => point.close,
              color: lineColor,
              width: _splineLineWidth,
              animationDuration: 0,
            ),
        ],
      ),
    );
  }
}

class _MiniChartPoint {
  final num? minutes;
  final double close;

  const _MiniChartPoint(this.minutes, this.close);
}
