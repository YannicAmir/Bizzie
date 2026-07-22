import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_news_article_extensions.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_news_ticker_bar.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/widgets/cards/news_card.dart';
import 'package:bizzie/shared/widgets/news_card_carousel.dart';
import 'package:bizzie/shared/widgets/states/bizzie_inline_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const Duration _pageScrollDuration = Duration(milliseconds: 300);

class HomeNewsCarousel extends StatefulWidget {
  final String? pendingNewsId;

  const HomeNewsCarousel({super.key, this.pendingNewsId});

  @override
  State<HomeNewsCarousel> createState() => _HomeNewsCarouselState();
}

class _HomeNewsCarouselState extends State<HomeNewsCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: NewsCardCarousel.viewportFraction,
  );
  int _currentPage = 0;
  String? _pendingScrollNewsId;
  List<WatchlistNewsArticle>? _sortSourceArticles;
  List<WatchlistNewsArticle> _cachedSortedArticles = const [];
  List<WatchlistNewsArticle>? _tickerSourceArticles;
  List<String> _cachedTickers = const [];

  @override
  void initState() {
    super.initState();
    _pendingScrollNewsId = widget.pendingNewsId;
    if (_pendingScrollNewsId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _maybeScrollToPending(context.read<WatchlistNewsBloc>().state);
      });
    }
  }

  @override
  void didUpdateWidget(covariant HomeNewsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pendingNewsId != oldWidget.pendingNewsId) {
      _pendingScrollNewsId = widget.pendingNewsId;
      if (_pendingScrollNewsId != null) {
        _maybeScrollToPending(context.read<WatchlistNewsBloc>().state);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onArticleTapped(WatchlistNewsArticle article) {
    context.read<HomeBloc>().add(
      HomeEvent.newsArticleTapped(ticker: article.symbol, site: article.site),
    );
    unawaited(UrlLauncherUtils.launch(article.url));
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  List<WatchlistNewsArticle> _sortedFor(List<WatchlistNewsArticle> articles) {
    if (!identical(articles, _sortSourceArticles)) {
      _sortSourceArticles = articles;
      _cachedSortedArticles = articles.sortedBySymbolThenRecency;
    }
    return _cachedSortedArticles;
  }

  List<String> _uniqueTickersFor(List<WatchlistNewsArticle> articles) {
    if (!identical(articles, _tickerSourceArticles)) {
      _tickerSourceArticles = articles;
      _cachedTickers = articles.uniqueTickers;
    }
    return _cachedTickers;
  }

  void _onTickerSelected(List<WatchlistNewsArticle> articles, String ticker) {
    final index = articles.indexWhere((article) => article.symbol == ticker);
    if (index == -1) return;
    _animateToPage(index);
  }

  void _animateToPage(int index) {
    unawaited(
      _pageController.animateToPage(
        index,
        duration: _pageScrollDuration,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onNewsStateChanged(BuildContext context, WatchlistNewsState state) {
    state.mapOrNull(
      failure: (f) {
        context.read<HomeBloc>().add(
          HomeEvent.newsLoadFailed(error: f.failure.errorMessage),
        );
      },
    );
    _maybeScrollToPending(state);
  }

  void _maybeScrollToPending(WatchlistNewsState state) {
    final pendingNewsId = _pendingScrollNewsId;
    if (pendingNewsId == null) return;

    state.mapOrNull(
      loaded: (s) {
        final index = _sortedFor(s.articles).indexWhere(
          (article) => article.id == pendingNewsId,
        );
        if (index == -1) return;
        _pendingScrollNewsId = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || !_pageController.hasClients) return;
          _animateToPage(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistNewsBloc, WatchlistNewsState>(
      listener: _onNewsStateChanged,
      child: BlocBuilder<WatchlistNewsBloc, WatchlistNewsState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (s) {
              final articles = _sortedFor(s.articles);
              if (articles.isEmpty) {
                final hasWatchlistCompanies = context
                    .watch<WatchlistBloc>()
                    .state
                    .maybeMap(
                      loaded: (w) => w.companies.isNotEmpty,
                      orElse: () => false,
                    );
                return hasWatchlistCompanies
                    ? const _LatestNewsEmptyState()
                    : const SizedBox.shrink();
              }
              return _CarouselContent(
                articles: articles,
                tickers: _uniqueTickersFor(articles),
                pageController: _pageController,
                currentPage: _currentPage,
                onPageChanged: _onPageChanged,
                onArticleTapped: _onArticleTapped,
                onTickerSelected: (ticker) =>
                    _onTickerSelected(articles, ticker),
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _CarouselContent extends StatelessWidget {
  final List<WatchlistNewsArticle> articles;
  final List<String> tickers;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<WatchlistNewsArticle> onArticleTapped;
  final ValueChanged<String> onTickerSelected;

  const _CarouselContent({
    required this.articles,
    required this.tickers,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.onArticleTapped,
    required this.onTickerSelected,
  });

  String get _selectedTicker =>
      articles[currentPage.clamp(0, articles.length - 1)].symbol;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LatestNewsHeader(),
        AppConstants.secondarySectionSpacing,
        WatchlistNewsTickerBar(
          tickers: tickers,
          selectedTicker: _selectedTicker,
          onTickerSelected: onTickerSelected,
        ),
        AppConstants.secondarySectionSpacing,
        NewsCardCarousel(
          controller: pageController,
          itemCount: articles.length,
          indicatorColor: theme.dividerColor,
          onPageChanged: onPageChanged,
          cardBuilder: (context, index) {
            final article = articles[index];
            return NewsCard(
              imageUrl: article.image,
              title: article.title,
              metaSegments: [
                NewsCardMetaSegment(
                  article.symbol,
                  NewsCardMetaEmphasis.leading,
                ),
                NewsCardMetaSegment(
                  article.site,
                  NewsCardMetaEmphasis.standard,
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

class _LatestNewsEmptyState extends StatelessWidget {
  const _LatestNewsEmptyState();

  @override
  Widget build(BuildContext context) {
    final mascotAsset = context.watch<UserBloc>().state.mascotAsset;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LatestNewsHeader(),
        AppConstants.secondarySectionSpacing,
        BizzieInlineEmptyState(
          mascotAsset: mascotAsset,
          message: 'No news yet on your watchlisted companies. Check out:',
          actionLabel: 'General News',
          onAction: () => context.go(AppRoutes.reports),
        ),
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}

class _LatestNewsHeader extends StatelessWidget {
  const _LatestNewsHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Latest News',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
