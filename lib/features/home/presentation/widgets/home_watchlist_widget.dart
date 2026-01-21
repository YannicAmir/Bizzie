import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeWatchlistWidget extends StatelessWidget {
  const HomeWatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final mascot = userState.maybeMap(
          loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
          orElse: () => AppAssets.defaultMascot,
        );

        return BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
        return state.maybeWhen(
          initial: () => const _LoadingState(),
          loading: () => const _LoadingState(),
          failure: (f) => Center(
            child: BizzieError(
              message: 'Error loading watchlist',
              mascotAssetPath: mascot,
            ),
          ),
          loaded: (companies) {
            if (companies.isEmpty) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('Watchlist', style: AppTextStyles.sectionHeader),
                ),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: companies.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final company = companies[index];
                    return CompanyListTile(
                      symbol: company.ticker,
                      name: company.name,
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.companyProfileHome,
                          pathParameters: {'ticker': company.ticker},
                          extra: company,
                        );
                      },
                      // Placeholder for future more info
                      trailing: Text(
                        "\$--.--",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
          },
        );
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
