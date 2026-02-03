import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_close_button.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_success_overlay.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountedSubscriptionPage extends StatelessWidget {
  const DiscountedSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure!.message),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            }

            if (state.maybeMap(
              loaded: (s) => s.isLocalSuccessOverride,
              orElse: () => false,
            )) {
              final userState = context.read<UserBloc>().state;
              final userName = userState.maybeMap(
                loaded: (s) => s.user.name,
                orElse: () => null,
              );

              SubscriptionSuccessOverlay.show(
                context,
                userName: userName ?? 'Friend',
                onDismiss: () {
                  context.go(AppRoutes.home);
                },
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return BlocBuilder<SubscriptionBloc, SubscriptionState>(
                buildWhen: (previous, current) {
                  return !current.status.isSubscribed;
                },
                builder: (context, subscriptionState) {
                  return subscriptionState.map(
                    initial: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: userState.mascotAsset,
                    ),
                    loading: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: userState.mascotAsset,
                    ),
                    loaded: (s) => _DiscountedSubscriptionLoadedContent(
                      state: s,
                      userState: userState,
                    ),
                    failure: (s) => BizzieError(
                      message: s.failure.message,
                      onRetry: () => context.read<SubscriptionBloc>().add(
                        const SubscriptionEvent.offeringsRequested(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DiscountedSubscriptionLoadedContent extends StatelessWidget {
  final SubscriptionStateLoaded state;
  final UserState userState;

  const _DiscountedSubscriptionLoadedContent({
    required this.state,
    required this.userState,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: AppConstants.pagePadding.copyWith(bottom: 100),
            child: Column(
              children: [
                const Row(children: [Spacer(), SubscriptionCloseButton()]),
                SubscriptionMascot(asset: userState.mascotAsset),
                const SizedBox(height: 16),
                const _DiscountTitleCard(),
                const SizedBox(height: 24),
                const SubscriptionHeader(),
                const SizedBox(height: 32),
                const _DiscountPlanBox(),
                const SizedBox(height: 24),
                const SubscriptionFeatureHighlights(),
                const SizedBox(height: 24),
                const _SavingsSummaryCard(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IgnorePointer(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.surface.withAlpha(0),
                        theme.colorScheme.surface,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: theme.colorScheme.surface,
                padding: AppConstants.pagePadding.copyWith(top: 0, bottom: 8),
                child: BizziePrimaryButton(
                  title: 'Claim 40% Off Now',
                  isLoading: state.isPurchasing,
                  onPressed: () {
                    if (state.discountAnnualPackage != null) {
                      context.read<SubscriptionBloc>().add(
                        SubscriptionEvent.purchaseRequested(
                          state.discountAnnualPackage!,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiscountTitleCard extends StatelessWidget {
  const _DiscountTitleCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '40% OFF',
          style: theme.textTheme.displayLarge?.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}

class _DiscountPlanBox extends StatelessWidget {
  const _DiscountPlanBox();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.primary, width: 2),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Annual Plan',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$240',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-40%',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '\$144',
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '/ year',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Just \$12 / month',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.discountBadgeBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'SAVE 40%',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SavingsSummaryCard extends StatelessWidget {
  const _SavingsSummaryCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: badgeTheme?.goodBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeTheme?.goodText ?? Colors.transparent),
      ),
      child: Column(
        children: [
          Text(
            'You save \$96 with this offer!',
            style: theme.textTheme.titleMedium?.copyWith(
              color: badgeTheme?.goodText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Subscribe now to enjoy Bizzie Plus',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: badgeTheme?.goodText,
            ),
          ),
        ],
      ),
    );
  }
}
