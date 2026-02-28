import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_state.dart';
import 'package:bizzie/features/company_profile/news/presentation/widgets/news_carousel.dart';
import 'package:bizzie/features/company_profile/news/presentation/widgets/news_list_tile.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/loading/mascot_refresh_indicator.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsTab extends StatefulWidget {
  final String ticker;

  const NewsTab({super.key, required this.ticker});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TabVisibilityObserver(
      tabName: CompanyProfileTab.news.analyticsName,
      onTabShown: () => context.read<CompanyNewsBloc>().add(
        CompanyNewsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyNewsBloc>().add(
        const CompanyNewsEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyNewsBloc>().add(
        const CompanyNewsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyNewsBloc>().add(
        const CompanyNewsEvent.appForegrounded(),
      ),
      child: MascotRefreshIndicator(
        onRefresh: () async {
          context.read<CompanyNewsBloc>().add(
            CompanyNewsEvent.loadRequested(widget.ticker, forceRefresh: true),
          );
        },
        child: BlocBuilder<CompanyNewsBloc, CompanyNewsState>(
          builder: (context, state) {
            return state.map(
              initial: (_) =>
                  const CompanyProfileLoadingState(message: 'Loading News'),
              loading: (_) =>
                  const CompanyProfileLoadingState(message: 'Loading News'),
              failure: (e) => CompanyProfileErrorState(
                message: 'Error loading news',
                onRetry: () => context.read<CompanyNewsBloc>().add(
                  CompanyNewsEvent.loadRequested(
                    widget.ticker,
                    forceRefresh: true,
                  ),
                ),
              ),
              loaded: (data) {
                final carouselNews = data.articles.take(3).toList();
                final listNews = data.articles.skip(3).toList();

                return _NewsLoadedState(
                  carouselNews: carouselNews,
                  listNews: listNews,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _NewsLoadedState extends StatelessWidget {
  const _NewsLoadedState({required this.carouselNews, required this.listNews});

  final List<NewsArticle> carouselNews;
  final List<NewsArticle> listNews;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewsCarousel(news: carouselNews),
          if (listNews.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(AppConstants.newsPagePadding),
              child: Text("Earlier", style: AppTextStyles.h3),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.newsPagePadding,
              ),
              itemCount: listNews.length,
              itemBuilder: (context, index) {
                final article = listNews[index];
                return NewsListTile(
                  article: article,
                  onTap: () {
                    context.read<CompanyNewsBloc>().add(
                      CompanyNewsEvent.articleTapped(
                        article: article,
                        isFeatured: false,
                      ),
                    );
                    UrlLauncherUtils.launch(article.url);
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
