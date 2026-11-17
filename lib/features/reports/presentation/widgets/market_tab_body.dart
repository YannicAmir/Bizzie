import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/widgets/market_news_carousel.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/market_upcoming_section.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/extensions/watchlist_ytd_state_extensions.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/widgets/watchlist_ytd_section.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/foundation.dart' show listEquals, mapEquals;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MarketTabBody extends StatelessWidget {
  final ValueChanged<MarketNewsArticle> onArticleTapped;
  final ValueChanged<String> onLoadFailed;

  const MarketTabBody({
    super.key,
    required this.onArticleTapped,
    required this.onLoadFailed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketNewsCarousel(
            onArticleTapped: onArticleTapped,
            onLoadFailed: onLoadFailed,
          ),
          const _MarketUpcomingBlocSection(),
          const _MarketYtdSection(),
        ],
      ),
    );
  }
}

class _MarketUpcomingBlocSection extends StatelessWidget {
  const _MarketUpcomingBlocSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      buildWhen: (previous, current) =>
          _upcomingEarnings(previous) != _upcomingEarnings(current),
      builder: (context, state) {
        return MarketUpcomingSection(earnings: _upcomingEarnings(state));
      },
    );
  }

  List<UpcomingEarnings> _upcomingEarnings(ReportsState state) {
    return state.maybeMap(
      loaded: (loaded) => loaded.feed.upcomingEarnings,
      orElse: () => const <UpcomingEarnings>[],
    );
  }
}

class _MarketYtdSection extends StatelessWidget {
  const _MarketYtdSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.tickerOrder, current.tickerOrder) ||
          !mapEquals(previous.logoUrlsByTicker, current.logoUrlsByTicker),
      builder: (context, watchlistState) {
        return BlocBuilder<WatchlistYtdBloc, WatchlistYtdState>(
          builder: (context, state) {
            return WatchlistYtdSection(
              changes: state.orderedChanges(watchlistState.tickerOrder),
              logoUrls: watchlistState.logoUrlsByTicker,
              onCardTapped: (change) => _onCardTapped(context, change),
            );
          },
        );
      },
    );
  }

  void _onCardTapped(BuildContext context, YtdPriceChange change) {
    context.read<ReportsBloc>().add(
      ReportsEvent.ytdCompanyClicked(ticker: change.ticker),
    );
    context.pushNamed(
      AppRoutes.companyProfileReports,
      pathParameters: {'ticker': change.ticker},
    );
  }
}
