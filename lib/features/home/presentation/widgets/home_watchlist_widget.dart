import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_price_trailing.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/watchlist/domain/extensions/watchlist_event_status_extensions.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/badges/watchlist_event_badge.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/company_logo_avatar.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeWatchlistWidget extends StatelessWidget {
  const HomeWatchlistWidget({super.key});

  void _onWatchlistStateChanged(BuildContext context, WatchlistState state) {
    state.mapOrNull(
      failure: (f) {
        context.read<HomeBloc>().add(
          HomeEvent.watchlistLoadFailed(error: f.failure.errorMessage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final mascot = userState.mascotAsset;

        return BlocConsumer<WatchlistBloc, WatchlistState>(
          listener: _onWatchlistStateChanged,
          builder: (context, state) {
            return state.map(
              initial: (_) => _LoadingState(mascotAssetPath: mascot),
              loading: (_) => _LoadingState(mascotAssetPath: mascot),
              failure: (_) => Center(
                child: BizzieError(
                  message: 'Error loading watchlist',
                  mascotAssetPath: mascot,
                ),
              ),
              success: (_) => const SizedBox.shrink(),
              loaded: (s) {
                if (s.companies.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _WatchlistHeader(),
                    AppConstants.secondarySectionSpacing,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: s.companies.length,
                      separatorBuilder: (context, index) =>
                          AppConstants.secondarySectionSpacing,
                      itemBuilder: (context, index) {
                        final company = s.companies[index];
                        final event = s.events[company.ticker];

                        return CompanyListTile(
                          symbol: company.ticker,
                          name: company.name,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          leading: CompanyLogoAvatar(
                            ticker: company.ticker,
                            logoUrl: company.logoUrl,
                          ),
                          trailing: _WatchlistTileTrailing(
                            ticker: company.ticker,
                            event: event,
                          ),
                          onTap: () {
                            context.read<HomeBloc>().add(
                              HomeEvent.watchlistTapped(
                                ticker: company.ticker,
                                eventText: event?.analyticsEventText,
                                isUpcoming: event?.isUpcoming,
                              ),
                            );
                            context.pushNamed(
                              AppRoutes.companyProfileHome,
                              pathParameters: {'ticker': company.ticker},
                              extra: company,
                            );
                          },
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class _WatchlistHeader extends StatelessWidget {
  const _WatchlistHeader();

  @override
  Widget build(BuildContext context) {
    return Text('Watchlist', style: Theme.of(context).textTheme.displaySmall);
  }
}

class _WatchlistTileTrailing extends StatelessWidget {
  final String ticker;
  final WatchlistEventStatus? event;

  const _WatchlistTileTrailing({required this.ticker, this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistPricesBloc, WatchlistPricesState>(
      builder: (context, state) {
        final WatchlistStockPrice? stockPrice = state.maybeMap(
          loaded: (s) => s.prices[ticker],
          orElse: () => null,
        );

        if (stockPrice != null) {
          return WatchlistPriceTrailing(stockPrice: stockPrice);
        }
        if (event != null) {
          return WatchlistEventBadge(status: event!);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  final String mascotAssetPath;
  const _LoadingState({required this.mascotAssetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _WatchlistHeader(),
        AppConstants.watchlistLoaderTopSpacing,
        BizzieLoader(
          message: 'Loading your watchlist...',
          mascotAssetPath: mascotAssetPath,
        ),
      ],
    );
  }
}
