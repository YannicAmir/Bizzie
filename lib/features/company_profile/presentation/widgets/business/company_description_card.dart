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
  final ScrollController _scrollController = ScrollController();

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

              final double availableWidth = constraints.maxWidth - 16.0;

              final tp = TextPainter(
                text: span,
                textDirection: TextDirection.ltr,
                maxLines: 6,
                textScaler: textScaler,
              );
              tp.layout(maxWidth: availableWidth);

              final bool isOverflowing = tp.didExceedMaxLines;
              final double collapsedHeight = tp.height;

              final tpFull = TextPainter(
                text: span,
                textDirection: TextDirection.ltr,
                textScaler: textScaler,
              );
              tpFull.layout(maxWidth: availableWidth);
              final double fullHeight = tpFull.height + 8.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    height: _isExpanded
                        ? (fullHeight > 400 ? 400 : fullHeight)
                        : collapsedHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: _isExpanded && fullHeight > 400,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: _isExpanded && fullHeight > 400
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            widget.description,
                            style: textStyle,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isOverflowing)
                    GestureDetector(
                      onTap: _toggleExpand,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
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
