import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselPageIndicator extends StatelessWidget {
  static const double _dotSize = 6;
  final PageController controller;
  final int count;
  final Color? dotColor;

  const CarouselPageIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotHeight: _dotSize,
        dotWidth: _dotSize,
        activeDotColor: theme.colorScheme.primary,
        dotColor: dotColor ?? theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
