import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/shared/widgets/badges/watchlist_event_badge.dart';

class HomeWatchlistWidget extends StatelessWidget {
  const HomeWatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final mascot = userState.mascotAsset;

        return BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => _LoadingState(mascotAssetPath: mascot),
              loading: (_) => _LoadingState(mascotAssetPath: mascot),
              failure: (f) => Center(
                child: BizzieError(
                  message: 'Error loading watchlist',
                  mascotAssetPath: mascot,
                ),
              ),
              success: (s) => const SizedBox.shrink(),
              loaded: (s) {
                if (s.companies.isEmpty) {
                  return BizzieEmptyState(
                    mascotAsset: mascot,
                    title: 'No watchlist',
                    message: 'You have no companies in your watchlist',
                    isFullPage: true,
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Watchlist', style: theme.textTheme.displaySmall),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: s.companies.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final company = s.companies[index];
                        final event = s.events[company.ticker];

                        return CompanyListTile(
                          symbol: company.ticker,
                          name: company.name,
                          trailing: event != null
                              ? WatchlistEventBadge(status: event)
                              : null,
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.companyProfileHome,
                              pathParameters: {'ticker': company.ticker},
                              extra: company,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
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

class _LoadingState extends StatelessWidget {
  final String mascotAssetPath;
  const _LoadingState({required this.mascotAssetPath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Watchlist', style: theme.textTheme.displaySmall),
        const SizedBox(height: 128),
        BizzieLoader(
          message: 'Loading your watchlist...',
          mascotAssetPath: mascotAssetPath,
        ),
      ],
    );
  }
}
