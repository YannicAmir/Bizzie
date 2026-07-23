import 'dart:async';

import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bizzie/features/market_news/presentation/utils/market_news_article_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/widgets/cards/news_card.dart';
import 'package:bizzie/shared/widgets/news_card_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketNewsCarousel extends StatefulWidget {
  final ValueChanged<MarketNewsArticle>? onArticleTapped;
  final ValueChanged<String>? onLoadFailed;

  const MarketNewsCarousel({
    super.key,
    this.onArticleTapped,
    this.onLoadFailed,
  });

  @override
  State<MarketNewsCarousel> createState() => _MarketNewsCarouselState();
}

class _MarketNewsCarouselState extends State<MarketNewsCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: NewsCardCarousel.viewportFraction,
  );
  List<MarketNewsArticle>? _sortSourceArticles;
  List<MarketNewsArticle> _cachedSortedArticles = const [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onArticleTapped(MarketNewsArticle article) {
    widget.onArticleTapped?.call(article);
    unawaited(UrlLauncherUtils.launch(article.url));
  }

  void _onStateChanged(BuildContext context, MarketNewsState state) {
    state.mapOrNull(
      failure: (f) => widget.onLoadFailed?.call(f.failure.errorMessage),
    );
  }

  List<MarketNewsArticle> _sortedFor(List<MarketNewsArticle> articles) {
    if (!identical(articles, _sortSourceArticles)) {
      _sortSourceArticles = articles;
      _cachedSortedArticles = articles.sortedByRecency;
    }
    return _cachedSortedArticles;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketNewsBloc, MarketNewsState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return state.maybeMap(
          loaded: (s) {
            final articles = _sortedFor(s.articles);
            if (articles.isEmpty) return const SizedBox.shrink();
            return _CarouselContent(
              articles: articles,
              pageController: _pageController,
              onArticleTapped: _onArticleTapped,
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _CarouselContent extends StatelessWidget {
  final List<MarketNewsArticle> articles;
  final PageController pageController;
  final ValueChanged<MarketNewsArticle> onArticleTapped;

  const _CarouselContent({
    required this.articles,
    required this.pageController,
    required this.onArticleTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('News', style: theme.textTheme.displaySmall),
        AppConstants.secondarySectionSpacing,
        NewsCardCarousel(
          controller: pageController,
          itemCount: articles.length,
          indicatorColor: theme.dividerColor,
          cardBuilder: (context, index) {
            final article = articles[index];
            return NewsCard(
              imageUrl: article.image,
              title: article.title,
              metaSegments: [
                NewsCardMetaSegment(
                  article.publisher,
                  NewsCardMetaEmphasis.leading,
                ),
                NewsCardMetaSegment(
                  article.timeAgo,
                  NewsCardMetaEmphasis.muted,
                ),
              ],
              onTap: () => onArticleTapped(article),
            );
          },
        ),
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}
