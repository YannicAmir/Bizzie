import 'package:bizzie/app/navigation/search_navigation.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/core/enums/search_source.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/states/bizzie_full_page_empty_layout.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeEmptyWatchlistView extends StatefulWidget {
  const HomeEmptyWatchlistView({super.key});

  @override
  State<HomeEmptyWatchlistView> createState() => _HomeEmptyWatchlistViewState();
}

class _HomeEmptyWatchlistViewState extends State<HomeEmptyWatchlistView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeBloc>().add(const HomeEvent.emptyStateViewed());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BizzieFullPageEmptyLayout(
      padding: AppConstants.emptyWatchlistPadding,
      content: const _HomeEmptyWatchlistContent(),
      action: BizziePrimaryButton(
        title: 'Search for stocks',
        onPressed: () =>
            SearchNavigation.push(context, source: SearchSource.home),
      ),
    );
  }
}

class _HomeEmptyWatchlistContent extends StatelessWidget {
  const _HomeEmptyWatchlistContent();

  @override
  Widget build(BuildContext context) {
    final mascotAsset = context.select<UserBloc, String>(
      (bloc) => bloc.state.mascotAsset,
    );

    return Column(
      children: [
        AppConstants.emptyWatchlistTopSpacing,
        Image.asset(
          mascotAsset,
          height: AppConstants.emptyWatchlistMascotHeight,
          excludeFromSemantics: true,
        ),
        AppConstants.mainSectionSpacing,
        Text(
          'No watchlist',
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),
        AppConstants.secondarySectionSpacing,
        Text(
          'You have no companies in your watchlist',
          style: AppTextStyles.bodyLargeSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
