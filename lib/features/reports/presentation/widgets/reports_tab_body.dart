import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/widgets/recent_filings_section.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_status_views.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsTabBody extends StatelessWidget {
  const ReportsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const ReportsLoadingView(),
          failure: (_) => const ReportsErrorView(),
          loaded:
              (feed, lastViewedReports, todaysFilings, todaysWeeklyReports) {
                final bool isRecentEmpty =
                    todaysFilings.isEmpty && todaysWeeklyReports.isEmpty;
                final mascotAsset = context.watch<UserBloc>().state.mascotAsset;

                if (isRecentEmpty) {
                  return _ReportsEmptyState(mascotAsset: mascotAsset);
                }

                return SingleChildScrollView(
                  padding: AppConstants.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecentFilingsSection(
                        filings: todaysFilings,
                        weeklyReports: todaysWeeklyReports,
                        lastViewed: lastViewedReports,
                        mascotAsset: mascotAsset,
                      ),
                    ],
                  ),
                );
              },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _ReportsEmptyState extends StatelessWidget {
  final String mascotAsset;

  const _ReportsEmptyState({required this.mascotAsset});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppConstants.pagePadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  constraints.maxHeight - AppConstants.pagePadding.vertical,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Expanded(
                    child: BizzieEmptyState(
                      isFullPage: true,
                      mascotAsset: mascotAsset,
                      message:
                          'There are no recent reports for the companies on your watchlist',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BizziePrimaryButton(
                      title: 'Search for stocks',
                      onPressed: () {
                        context.read<ReportsBloc>().add(
                          const ReportsEvent.emptyCtaClicked(),
                        );
                        context.push(
                          AppRoutes.search,
                          extra: SearchSource.reports,
                        );
                      },
                    ),
                  ),
                  AppConstants.emptyWatchlistBottomSpacing,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
