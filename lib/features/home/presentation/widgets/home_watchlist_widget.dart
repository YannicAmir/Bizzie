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
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/di/injection.dart';
import 'package:go_router/go_router.dart';

class HomeWatchlistWidget extends StatelessWidget {
  const HomeWatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final cachedSector = getIt<IUserRepository>().getCachedFavoriteSector();
        final mascot = userState.maybeMap(
          loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
          orElse: () => cachedSector != null
              ? AppAssets.getMascotForSector(cachedSector)
              : AppAssets.defaultMascot,
        );

        return BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => _LoadingState(mascotAssetPath: mascot),
              loading: () => _LoadingState(mascotAssetPath: mascot),
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
                    Text('Watchlist', style: AppTextStyles.sectionHeader),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
  final String mascotAssetPath;
  const _LoadingState({required this.mascotAssetPath});

  @override
  Widget build(BuildContext context) {
    return BizzieLoader(
      message: 'Loading your watchlist...',
      mascotAssetPath: mascotAssetPath,
    );
  }
}
