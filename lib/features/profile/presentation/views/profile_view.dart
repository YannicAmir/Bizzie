import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_premium_card.dart';
import 'package:bizzie/features/profile/presentation/widgets/sector_highlight_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/profile_collapsing_header_delegate.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => current.maybeMap(
          loaded: (s) => s.shouldNavigateToSettings || s.shouldShowPaywall,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.mapOrNull(
            loaded: (s) {
              if (s.shouldNavigateToSettings) {
                context.push(AppRoutes.settings);
              } else if (s.shouldShowPaywall) {
                PaywallHelper.showPaywallSequence(
                  context,
                  source: PaywallSource.profile,
                );
              }
              context.read<ProfileBloc>().add(
                const ProfileEvent.navigationProcessed(),
              );
            },
          );
        },
        child: Scaffold(
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return state.map(
                initial: (_) => const _ProfileLoadingView(),
                loading: (_) => const _ProfileLoadingView(),
                failure: (f) =>
                    Center(child: Text('Error: ${f.failure.toString()}')),
                loaded: (state) => _ProfileLoadedView(data: state.data),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileLoadingView extends StatelessWidget {
  const _ProfileLoadingView();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final theme = Theme.of(context);

    final mascotAsset = context.select(
      (UserBloc bloc) => bloc.state.mascotAsset,
    );
    final displayName = context.select(
      (UserBloc bloc) => bloc.state.maybeMap(
        loaded: (s) => s.user.name,
        orElse: () => 'Loading...',
      ),
    );

    return Stack(
      children: [
        CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileCollapsingHeaderDelegate(
                displayName: displayName,
                sectorName: '',
                expandedHeight: 360,
                topPadding: topPadding,
                explicitAvatarAsset: mascotAsset,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text('Loading Profile', style: AppTextStyles.loaderMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileLoadedView extends StatelessWidget {
  final ProfileDisplayData data;

  const _ProfileLoadedView({required this.data});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: ProfileCollapsingHeaderDelegate(
            displayName: data.displayName,
            sectorName: data.sectorName,
            expandedHeight: 360,
            topPadding: topPadding,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverPadding(
          padding: AppConstants.profileTabWidgetPadding,
          sliver: SliverToBoxAdapter(
            child: SectorHighlightCard(
              sectorName: data.sectorName,
              sectorDescription: data.sectorDescription,
              sectorPe: data.sectorPe,
              sectorAverageChange: data.sectorAverageChange,
              marketDataDate: data.marketDataDate,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final isSubscribed = state.maybeMap(
                loaded: (s) => s.user.isSubscribed,
                orElse: () => false,
              );

              if (isSubscribed) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: AppConstants.profileTabWidgetPadding,
                child: Column(
                  children: [
                    const ProfilePremiumCard(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  ],
                ),
              );
            },
          ),
        ),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: SizedBox.shrink(),
        ),
      ],
    );
  }
}
