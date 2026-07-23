import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/widgets/market_news_carousel.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/market_upcoming_section.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/extensions/watchlist_ytd_state_extensions.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/widgets/watchlist_ytd_section.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const _MarketUpcomingSection(),
          const _MarketYtdSection(),
        ],
      ),
    );
  }
}

class _MarketUpcomingSection extends StatelessWidget {
  const _MarketUpcomingSection();

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
      loaded: (s) => s.feed.upcomingEarnings,
      orElse: () => const <UpcomingEarnings>[],
    );
  }
}

class _MarketYtdSection extends StatelessWidget {
  const _MarketYtdSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistYtdBloc, WatchlistYtdState>(
      builder: (context, state) {
        final order = context.watch<WatchlistBloc>().state.tickerOrder;
        return WatchlistYtdSection(changes: state.orderedChanges(order));
      },
    );
  }
}
