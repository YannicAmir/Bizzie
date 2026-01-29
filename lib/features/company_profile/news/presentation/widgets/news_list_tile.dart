import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/news/presentation/utils/news_article_extensions.dart';
import 'package:bizzie/shared/widgets/images/bizzie_network_image.dart';
import 'package:bizzie/shared/constants/app_constants.dart'; // Required for defaultBorderWidth
import 'package:flutter/material.dart'; // Required for StatelessWidget, Theme, etc.
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';

class NewsListTile extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;

  const NewsListTile({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(8),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NewsImage(article: article),
            const SizedBox(width: 16),
            Expanded(child: _NewsContent(article: article)),
          ],
        ),
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  final NewsArticle article;

  const _NewsImage({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BizzieNetworkImage(
          imageUrl: article.image,
          width: 96,
          height: 96,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _NewsContent extends StatelessWidget {
  final NewsArticle article;

  const _NewsContent({required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          article.title,
          style: AppTextStyles.bodyMediumBold,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        AppConstants.subSectionSpacing,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: article.site,
                style: AppTextStyles.bodySmallBoldSecondary,
              ),
              TextSpan(
                text: ' • ',
                style: AppTextStyles.bodySmallBoldSecondary,
              ),
              TextSpan(
                text: article.timeAgo,
                style: AppTextStyles.bodySmallSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
