import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_presentation.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/carousel_page_indicator.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_pie_chart.dart';
import 'package:flutter/material.dart';

class SegmentBreakdownSection extends StatefulWidget {
  final String title;
  final RevenueSegment? current;
  final RevenueSegment? previous;
  final String currentLabel;
  final String? previousLabel;
  final Map<String, int> colorIndices;
  final String currency;
  final bool isAnnual;

  const SegmentBreakdownSection({
    super.key,
    required this.title,
    required this.current,
    required this.previous,
    required this.currentLabel,
    required this.previousLabel,
    required this.colorIndices,
    required this.currency,
    required this.isAnnual,
  });

  @override
  State<SegmentBreakdownSection> createState() =>
      _SegmentBreakdownSectionState();
}

class _SegmentBreakdownSectionState extends State<SegmentBreakdownSection> {
  static const String _fiscalYearPrefix = 'FY';
  static const String _segmentMetricHeader = 'Segment';
  static const String _missingHeaderPlaceholder = '-';

  final PageController _pageController = PageController();

  String? _locale;
  List<FinancialStatementTableRow> _rows = const [];
  List<BizziePieChartData>? _currentChartData;
  List<BizziePieChartData>? _previousChartData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).toString();
    if (locale != _locale) {
      _locale = locale;
      _recomputeViewData();
    }
  }

  @override
  void didUpdateWidget(SegmentBreakdownSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final inputsChanged =
        widget.current != oldWidget.current ||
        widget.previous != oldWidget.previous ||
        widget.colorIndices != oldWidget.colorIndices ||
        widget.currency != oldWidget.currency;
    if (inputsChanged) {
      _recomputeViewData();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _recomputeViewData() {
    final locale = _locale;
    if (locale == null) return;

    final current = widget.current;
    final previous = widget.previous;

    _currentChartData = current != null
        ? SegmentPresentation.chartData(current, widget.colorIndices)
        : null;
    _previousChartData = previous != null
        ? SegmentPresentation.chartData(previous, widget.colorIndices)
        : null;
    _rows = SegmentPresentation.tableRows(
      current: current,
      previous: previous,
      colorIndices: widget.colorIndices,
      currency: widget.currency,
      locale: locale,
    );
  }

  String _periodLabel(String label) =>
      widget.isAnnual ? '$_fiscalYearPrefix $label' : label;

  List<Widget> _buildSlides() {
    final currentChartData = _currentChartData;
    final previousChartData = _previousChartData;
    final previousLabel = widget.previousLabel;

    final currentPeriod = _periodLabel(widget.currentLabel);
    final previousPeriod = previousLabel != null
        ? _periodLabel(previousLabel)
        : null;

    return <Widget>[
      if (currentChartData != null)
        _ChartSlide(
          key: ValueKey('${widget.title}_$currentPeriod'),
          title: widget.title,
          currency: widget.currency,
          data: currentChartData,
          periodLabel: currentPeriod,
        ),
      if (previousChartData != null && previousPeriod != null)
        _ChartSlide(
          key: ValueKey('${widget.title}_$previousPeriod'),
          title: widget.title,
          currency: widget.currency,
          data: previousChartData,
          periodLabel: previousPeriod,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final slides = _buildSlides();

    if (slides.isEmpty && _rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (slides.isNotEmpty)
          _ChartCarousel(controller: _pageController, slides: slides),
        FinancialStatementsTable(
          title: widget.title,
          rows: _rows,
          metricHeader: _segmentMetricHeader,
          amountHeader: widget.currentLabel,
          percentageHeader: widget.previousLabel ?? _missingHeaderPlaceholder,
          amountAlignment: Alignment.centerRight,
          amountTextAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _ChartCarousel extends StatelessWidget {
  final PageController controller;
  final List<Widget> slides;

  const _ChartCarousel({required this.controller, required this.slides});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstants.chartCarouselHeight,
          child: PageView(controller: controller, children: slides),
        ),
        if (slides.length > 1) ...[
          AppConstants.secondarySectionSpacing,
          Center(
            child: CarouselPageIndicator(
              controller: controller,
              count: slides.length,
            ),
          ),
        ],
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}

class _ChartSlide extends StatelessWidget {
  final String title;
  final String currency;
  final List<BizziePieChartData> data;
  final String periodLabel;

  const _ChartSlide({
    super.key,
    required this.title,
    required this.currency,
    required this.data,
    required this.periodLabel,
  });

  @override
  Widget build(BuildContext context) {
    return BizziePieChart(
      title: title,
      currency: currency,
      data: data,
      centerWidget: Text(
        periodLabel,
        textAlign: TextAlign.center,
        style: AppTextStyles.h3,
      ),
    );
  }
}
