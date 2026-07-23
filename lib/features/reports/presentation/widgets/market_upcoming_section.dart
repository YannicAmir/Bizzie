import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_card.dart';
import 'package:bizzie/features/reports/presentation/widgets/upcoming_earnings_modal.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/states/bizzie_inline_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MarketUpcomingSection extends StatelessWidget {
  final List<UpcomingEarnings> earnings;

  const MarketUpcomingSection({super.key, required this.earnings});

  static const int _visibleCount = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (earnings.isEmpty) return const _UpcomingEmptyState();

    final visible = earnings.take(_visibleCount).toList();
    final remaining = earnings.length - visible.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _UpcomingHeader(),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: UpcomingEarningsCard(
                    earnings: visible[i],
                    onTap: () => _onCardTapped(context, visible[i]),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (remaining > 0)
          InkWell(
            onTap: () => _onViewMoreTapped(context),
            splashColor: theme.colorScheme.scrim,
            highlightColor: theme.colorScheme.scrim,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                'View $remaining More',
                style: AppTextStyles.bodyMediumBold.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _onCardTapped(BuildContext context, UpcomingEarnings earnings) {
    context.read<ReportsBloc>().add(
      ReportsEvent.upcomingCompanyClicked(ticker: earnings.symbol),
    );
    context.pushNamed(
      AppRoutes.companyProfileReports,
      pathParameters: {'ticker': earnings.symbol},
    );
  }

  void _onViewMoreTapped(BuildContext context) {
    context.read<ReportsBloc>().add(const ReportsEvent.upcomingExpanded());
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UpcomingEarningsModal(earnings: earnings),
    );
  }
}

class _UpcomingEmptyState extends StatelessWidget {
  const _UpcomingEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mascotAsset = context.select(
      (UserBloc bloc) => bloc.state.mascotAsset,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _UpcomingHeader(),
        Container(
          padding: const EdgeInsets.all(
            AppConstants.mainSectionContainerPadding,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(
              color: theme.dividerColor,
              width: theme.dividerTheme.thickness ??
                  AppConstants.defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: BizzieInlineEmptyState(
            mascotAsset: mascotAsset,
            message: 'No upcoming events for your watchlisted companies.',
            actionLabel: 'Search for stocks',
            onAction: () =>
                context.push(AppRoutes.search, extra: SearchSource.reports),
          ),
        ),
      ],
    );
  }
}

class _UpcomingHeader extends StatelessWidget {
  const _UpcomingHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        'Upcoming',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
