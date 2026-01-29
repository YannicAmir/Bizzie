import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/news/presentation/utils/news_article_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/images/bizzie_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;

  const NewsCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          _NewsCardBackground(imageUrl: article.image),
          _NewsCardContent(article: article),
        ],
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
                  AppColors.black.withValues(alpha: 0.3),
                  BlendMode.darken,
                ),
                placeholderScale: 120 / 48,
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
                  AppColors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NewsCardContent extends StatelessWidget {
  final NewsArticle article;

  const _NewsCardContent({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  text: article.site,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                TextSpan(
                  text: ' • ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                TextSpan(
                  text: article.timeAgo,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.surface.withValues(alpha: 0.8),
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
