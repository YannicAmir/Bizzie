import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_news_article_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/images/bizzie_network_image.dart';
import 'package:flutter/material.dart';

const _metaSeparator = ' • ';
const _imageDarkenAlpha = 0.3;
const _gradientBottomAlpha = 0.8;
const _gradientStops = [0.5, 1.0];
const _timestampAlpha = 0.8;
const _placeholderScale = 120 / 48;

class WatchlistNewsCard extends StatelessWidget {
  final WatchlistNewsArticle article;
  final VoidCallback onTap;

  const WatchlistNewsCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          _WatchlistNewsCardBackground(imageUrl: article.image),
          _WatchlistNewsCardContent(article: article),
        ],
      ),
    );
  }
}

class _WatchlistNewsCardBackground extends StatelessWidget {
  final String? imageUrl;

  const _WatchlistNewsCardBackground({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(
                AppConstants.mainSectionBorderRadius,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppConstants.mainSectionBorderRadius,
              ),
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
              borderRadius: BorderRadius.circular(
                AppConstants.mainSectionBorderRadius,
              ),
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

class _WatchlistNewsCardContent extends StatelessWidget {
  final WatchlistNewsArticle article;

  const _WatchlistNewsCardContent({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = AppTextStyles.bodySmall.copyWith(
      color: theme.colorScheme.surface,
    );
    final separatorSpan = TextSpan(text: _metaSeparator, style: metaStyle);
    return Padding(
      padding: const EdgeInsets.all(AppConstants.newsPagePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: article.symbol,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                separatorSpan,
                TextSpan(text: article.site, style: metaStyle),
                separatorSpan,
                TextSpan(
                  text: article.timeAgo,
                  style: metaStyle.copyWith(
                    color: theme.colorScheme.surface.withValues(
                      alpha: _timestampAlpha,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppConstants.subSectionSpacing,
          Text(
            article.title,
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: theme.colorScheme.surface,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
