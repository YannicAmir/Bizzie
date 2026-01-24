import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CompanyDescriptionCard extends StatefulWidget {
  final String description;

  const CompanyDescriptionCard({super.key, required this.description});

  @override
  State<CompanyDescriptionCard> createState() => _CompanyDescriptionCardState();
}

class _CompanyDescriptionCardState extends State<CompanyDescriptionCard> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = AppTextStyles.bodyMedium;

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
          Text('About', style: AppTextStyles.h3),
          AppConstants.subSectionSpacing,
          LayoutBuilder(
            builder: (context, constraints) {
              final span = TextSpan(text: widget.description, style: textStyle);
              final textScaler = MediaQuery.textScalerOf(context);

              final tp = TextPainter(
                text: span,
                textDirection: TextDirection.ltr,
                maxLines: 6,
                textScaler: textScaler,
              );
              tp.layout(maxWidth: constraints.maxWidth);

              final bool isOverflowing = tp.didExceedMaxLines;
              final double collapsedHeight = tp.height;

              final tpFull = TextPainter(
                text: span,
                textDirection: TextDirection.ltr,
                textScaler: textScaler,
              );
              tpFull.layout(maxWidth: constraints.maxWidth);
              final double fullHeight = tpFull.height + 20.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    height: _isExpanded ? fullHeight : collapsedHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Text(
                      widget.description,
                      style: textStyle,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  if (isOverflowing)
                    GestureDetector(
                      onTap: _toggleExpand,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _isExpanded ? 'View Less' : 'View All',
                          style: AppTextStyles.bodyMediumBold.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
