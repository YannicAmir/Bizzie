import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/recent_filings_section.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_section.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ReportsBloc>();
    bloc.state.mapOrNull(loaded: (_) => bloc.add(const ReportsEvent.viewed()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BizzieSearchBar(
          readOnly: true,
          onTap: () {
            context.push(AppRoutes.search, extra: 'reports');
          },
        ),
      ),
      body: BlocListener<ReportsBloc, ReportsState>(
        listener: (context, state) {
          state.mapOrNull(
            loaded: (_) =>
                context.read<ReportsBloc>().add(const ReportsEvent.viewed()),
          );
        },
        child: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (failure) => BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  final mascot = userState.maybeMap(
                    loaded: (u) =>
                        AppAssets.getMascotForSector(u.user.favoriteSector),
                    orElse: () => AppAssets.defaultMascot,
                  );
                  return Center(
                    child: BizzieError(
                      message: 'Error loading reports',
                      mascotAssetPath: mascot,
                    ),
                  );
                },
              ),
              loaded: (feed, lastViewedReports, todaysFilings) {
                final bool isUpcomingEmpty = feed.upcomingEarnings.isEmpty;
                final bool isRecentEmpty = todaysFilings.isEmpty;
                final mascotAsset = context.watch<UserBloc>().state.mascotAsset;

                if (isUpcomingEmpty && isRecentEmpty) {
                  return _ReportsEmptyState(mascotAsset: mascotAsset);
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UpcomingEarningsSection(
                        earnings: feed.upcomingEarnings,
                        mascotAsset: mascotAsset,
                      ),
                      const SizedBox(height: 24),

                      RecentFilingsSection(
                        filings: todaysFilings,
                        lastViewed: lastViewedReports,
                        mascotAsset: mascotAsset,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

class _ReportsEmptyState extends StatelessWidget {
  final String mascotAsset;

  const _ReportsEmptyState({required this.mascotAsset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Image.asset(mascotAsset, height: 160),
            const SizedBox(height: 24),
            Text(
              'There are no recent or upcoming notifications',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BizziePrimaryButton(
                title: 'Search for stocks',
                onPressed: () {
                  context.push(AppRoutes.search, extra: 'reports');
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
