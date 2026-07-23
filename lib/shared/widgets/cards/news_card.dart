import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/images/bizzie_network_image.dart';
import 'package:flutter/material.dart';

const _metaSeparator = ' • ';
const _imageDarkenAlpha = 0.3;
const _gradientBottomAlpha = 0.8;
const _gradientStops = [0.5, 1.0];
const _mutedMetaAlpha = 0.8;
const _placeholderScale = 120 / 48;
const _titleMaxLines = 3;

enum NewsCardMetaEmphasis { leading, standard, muted }

class NewsCardMetaSegment {
  final String text;
  final NewsCardMetaEmphasis emphasis;

  const NewsCardMetaSegment(this.text, this.emphasis);
}

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final List<NewsCardMetaSegment> metaSegments;
  final VoidCallback onTap;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.metaSegments,
    required this.onTap,
  });

  String get _semanticsLabel {
    final meta = metaSegments
        .map((segment) => segment.text)
        .join(_metaSeparator);
    return '$title. $meta';
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: _semanticsLabel,
      onTap: onTap,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              _NewsCardBackground(imageUrl: imageUrl),
              _NewsCardContent(title: title, metaSegments: metaSegments),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsCardBackground extends StatelessWidget {
  final String? imageUrl;

  const _NewsCardBackground({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(
      AppConstants.mainSectionBorderRadius,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: borderRadius,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BizzieNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.black.withValues(alpha: _imageDarkenAlpha),
                  BlendMode.darken,
                ),
                placeholderScale: _placeholderScale,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.black.withValues(alpha: _gradientBottomAlpha),
                ],
                stops: _gradientStops,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NewsCardContent extends StatelessWidget {
  final String title;
  final List<NewsCardMetaSegment> metaSegments;

  const _NewsCardContent({required this.title, required this.metaSegments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.newsPagePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: _metaSpans)),
          AppConstants.subSectionSpacing,
          Text(
            title,
            style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.white),
            maxLines: _titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  List<InlineSpan> get _metaSpans => [
    for (var i = 0; i < metaSegments.length; i++) ...[
      if (i > 0)
        TextSpan(
          text: _metaSeparator,
          style: _styleFor(NewsCardMetaEmphasis.standard),
        ),
      TextSpan(
        text: metaSegments[i].text,
        style: _styleFor(metaSegments[i].emphasis),
      ),
    ],
  ];

  TextStyle _styleFor(NewsCardMetaEmphasis emphasis) {
    switch (emphasis) {
      case NewsCardMetaEmphasis.leading:
        return AppTextStyles.bodySmallBold.copyWith(color: AppColors.white);
      case NewsCardMetaEmphasis.standard:
        return AppTextStyles.bodySmall.copyWith(color: AppColors.white);
      case NewsCardMetaEmphasis.muted:
        return AppTextStyles.bodySmall.copyWith(
          color: AppColors.white.withValues(alpha: _mutedMetaAlpha),
        );
    }
  }
}
