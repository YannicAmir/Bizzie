import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final mascotAsset =
        context.select<UserBloc, String>((bloc) => bloc.state.mascotAsset);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: AppConstants.emptyWatchlistPadding,
                child: Column(
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
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: BizziePrimaryButton(
                        title: 'Search for stocks',
                        onPressed: () => context.push(
                          AppRoutes.search,
                          extra: SearchSource.home,
                        ),
                      ),
                    ),
                    AppConstants.emptyWatchlistBottomSpacing,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
