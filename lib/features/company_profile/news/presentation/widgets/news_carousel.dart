import 'dart:async';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/utils/news_article_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/widgets/cards/news_card.dart';
import 'package:bizzie/shared/widgets/carousel_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _maxDisplayedArticles = 3;
const double _viewportFraction = 0.9;
const double _carouselHeight = 250;

class NewsCarousel extends StatefulWidget {
  final List<NewsArticle> news;

  const NewsCarousel({super.key, required this.news});

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: _viewportFraction,
  );
  late List<NewsArticle> _displayNews;

  @override
  void initState() {
    super.initState();
    _displayNews = _computeDisplayNews();
  }

  @override
  void didUpdateWidget(NewsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _displayNews = _computeDisplayNews();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<NewsArticle> _computeDisplayNews() =>
      widget.news.take(_maxDisplayedArticles).toList();

  @override
  Widget build(BuildContext context) {
    if (_displayNews.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.newsPagePadding),
          child: Text("Latest", style: AppTextStyles.h3),
        ),
        SizedBox(
          height: _carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            itemCount: _displayNews.length,
            itemBuilder: (context, index) {
              final article = _displayNews[index];
              return Padding(
                padding: index != _maxDisplayedArticles - 1
                    ? EdgeInsets.only(left: AppConstants.newsPagePadding)
                    : EdgeInsets.symmetric(
                        horizontal: AppConstants.newsPagePadding,
                      ),
                child: NewsCard(
                  imageUrl: article.image,
                  title: article.title,
                  metaSegments: [
                    NewsCardMetaSegment(
                      article.site,
                      NewsCardMetaEmphasis.leading,
                    ),
                    NewsCardMetaSegment(
                      article.timeAgo,
                      NewsCardMetaEmphasis.muted,
                    ),
                  ],
                  onTap: () {
                    context.read<CompanyNewsBloc>().add(
                      CompanyNewsEvent.articleTapped(
                        article: article,
                        isFeatured: true,
                      ),
                    );
                    unawaited(UrlLauncherUtils.launch(article.url));
                  },
                ),
              );
            },
          ),
        ),
        AppConstants.secondarySectionSpacing,
        Center(
          child: CarouselPageIndicator(
            controller: _pageController,
            count: _displayNews.length,
            dotColor: theme.dividerColor,
          ),
        ),
      ],
    );
  }
}
