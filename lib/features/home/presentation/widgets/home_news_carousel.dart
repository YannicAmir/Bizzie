import 'dart:async';

import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_news_card.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_news_ticker_bar.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/widgets/carousel_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _viewportFraction = 0.9;
const double _carouselHeight = 250;
const Duration _pageScrollDuration = Duration(milliseconds: 300);

class HomeNewsCarousel extends StatefulWidget {
  const HomeNewsCarousel({super.key});

  @override
  State<HomeNewsCarousel> createState() => _HomeNewsCarouselState();
}

class _HomeNewsCarouselState extends State<HomeNewsCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: _viewportFraction,
  );
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _dispatchLoadFromWatchlist(context.read<WatchlistBloc>().state);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _dispatchLoadFromWatchlist(WatchlistState state) {
    state.mapOrNull(
      loaded: (s) {
        context.read<WatchlistNewsBloc>().add(
          WatchlistNewsEvent.loadRequested(
            s.companies.map((company) => company.ticker).toList(),
          ),
        );
      },
    );
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

  void _onTickerSelected(List<WatchlistNewsArticle> articles, String ticker) {
    final index = articles.indexWhere((article) => article.symbol == ticker);
    if (index == -1) return;
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WatchlistBloc, WatchlistState>(
          listener: (context, state) => _dispatchLoadFromWatchlist(state),
        ),
        BlocListener<WatchlistNewsBloc, WatchlistNewsState>(
          listener: _onNewsStateChanged,
        ),
      ],
      child: BlocBuilder<WatchlistNewsBloc, WatchlistNewsState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (s) {
              if (s.articles.isEmpty) return const SizedBox.shrink();
              final articles = s.articles;
              return _CarouselContent(
                articles: articles,
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
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<WatchlistNewsArticle> onArticleTapped;
  final ValueChanged<String> onTickerSelected;

  const _CarouselContent({
    required this.articles,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.onArticleTapped,
    required this.onTickerSelected,
  });

  List<String> get _uniqueTickers =>
      articles.map((article) => article.symbol).toSet().toList();

  String get _selectedTicker =>
      articles[currentPage.clamp(0, articles.length - 1)].symbol;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Latest News', style: theme.textTheme.displaySmall),
        AppConstants.secondarySectionSpacing,
        WatchlistNewsTickerBar(
          tickers: _uniqueTickers,
          selectedTicker: _selectedTicker,
          onTickerSelected: onTickerSelected,
        ),
        AppConstants.secondarySectionSpacing,
        SizedBox(
          height: _carouselHeight,
          child: PageView.builder(
            controller: pageController,
            padEnds: false,
            onPageChanged: onPageChanged,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Padding(
                padding: index != articles.length - 1
                    ? const EdgeInsets.only(right: AppConstants.newsPagePadding)
                    : EdgeInsets.zero,
                child: WatchlistNewsCard(
                  article: article,
                  onTap: () => onArticleTapped(article),
                ),
              );
            },
          ),
        ),
        AppConstants.secondarySectionSpacing,
        Center(
          child: CarouselPageIndicator(
            controller: pageController,
            count: articles.length,
            dotColor: theme.dividerColor,
          ),
        ),
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}
