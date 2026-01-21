import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/news/news_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';

class NewsCarousel extends StatefulWidget {
  final List<NewsArticle> news;

  const NewsCarousel({super.key, required this.news});

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.news.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    final displayNews = widget.news.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text("Latest", style: AppTextStyles.h3),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            itemCount: displayNews.length,
            itemBuilder: (context, index) {
              final article = displayNews[index];
              return Padding(
                padding: index != 2
                    ? EdgeInsets.only(left: AppConstants.newsPagePadding)
                    : EdgeInsets.symmetric(
                        horizontal: AppConstants.newsPagePadding,
                      ),
                child: NewsCard(
                  article: article,
                  onTap: () => UrlLauncherUtils.launch(article.url),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: displayNews.length,
            effect: ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: theme.colorScheme.primary,
              dotColor: theme.dividerColor,
            ),
          ),
        ),
      ],
    );
  }
}
