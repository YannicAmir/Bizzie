import 'package:bizzie/app/navigation/search_navigation.dart';
import 'package:bizzie/core/enums/search_source.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_feed_item_card.dart';
import 'package:bizzie/features/reports/presentation/widgets/reports_status_views.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/states/bizzie_full_page_empty_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class ReportsTabBody extends StatelessWidget {
  const ReportsTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const ReportsLoadingView(),
          failure: (_) => const ReportsErrorView(),
          loaded: (loaded) {
            final items = loaded.feedItems;

            if (items.isEmpty) {
              return const _ReportsEmptyState();
            }

            return ListView.separated(
              padding: AppConstants.pagePadding,
              itemCount: items.length,
              separatorBuilder: (_, __) => AppConstants.secondarySectionSpacing,
              itemBuilder: (context, index) =>
                  ReportsFeedItemCard(item: items[index]),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _ReportsEmptyState extends StatelessWidget {
  const _ReportsEmptyState();

  @override
  Widget build(BuildContext context) {
    final mascotAsset = context.select<UserBloc, String>(
      (bloc) => bloc.state.mascotAsset,
    );

    return BizzieFullPageEmptyLayout(
      padding: AppConstants.pagePadding,
      content: BizzieEmptyState(
        isFullPage: true,
        mascotAsset: mascotAsset,
        message:
            'There are no recent reports for the companies on your watchlist',
      ),
      action: BizziePrimaryButton(
        title: 'Search for stocks',
        onPressed: () {
          context.read<ReportsBloc>().add(const ReportsEvent.emptyCtaClicked());
          SearchNavigation.push(context, source: SearchSource.reports);
        },
      ),
    );
  }
}
