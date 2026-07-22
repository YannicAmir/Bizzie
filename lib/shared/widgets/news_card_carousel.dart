import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/carousel_page_indicator.dart';
import 'package:flutter/material.dart';

const double _carouselHeight = 250;


class NewsCardCarousel extends StatelessWidget {
  static const double viewportFraction = 0.9;

  final PageController controller;
  final int itemCount;
  final IndexedWidgetBuilder cardBuilder;
  final Color indicatorColor;
  final ValueChanged<int>? onPageChanged;

  const NewsCardCarousel({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.cardBuilder,
    required this.indicatorColor,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _carouselHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bleedWidth =
                  constraints.maxWidth + AppConstants.pagePadding.horizontal;
              return OverflowBox(
                minWidth: bleedWidth,
                maxWidth: bleedWidth,
                child: PageView.builder(
                  controller: controller,
                  padEnds: false,
                  onPageChanged: onPageChanged,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index != itemCount - 1
                          ? const EdgeInsets.only(
                              left: AppConstants.newsPagePadding,
                            )
                          : const EdgeInsets.symmetric(
                              horizontal: AppConstants.newsPagePadding,
                            ),
                      child: cardBuilder(context, index),
                    );
                  },
                ),
              );
            },
          ),
        ),
        AppConstants.secondarySectionSpacing,
        Center(
          child: CarouselPageIndicator(
            controller: controller,
            count: itemCount,
            dotColor: indicatorColor,
          ),
        ),
      ],
    );
  }
}
