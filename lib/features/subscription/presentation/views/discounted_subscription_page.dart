import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_close_button.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_legal_footer.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_success_overlay.dart';
import 'package:bizzie/features/subscription/presentation/widgets/discount_title_card.dart';
import 'package:bizzie/features/subscription/presentation/widgets/discount_plan_box.dart';
import 'package:bizzie/features/subscription/presentation/widgets/savings_summary_card.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_bottom_actions.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountedSubscriptionPage extends StatefulWidget {
  final PaywallSource source;
  final String? tabName;
  final String? featureName;
  final VoidCallback? onEnter;

  const DiscountedSubscriptionPage({
    super.key,
    this.source = PaywallSource.unknown,
    this.tabName,
    this.featureName,
    this.onEnter,
  });

  @override
  State<DiscountedSubscriptionPage> createState() =>
      _DiscountedSubscriptionPageState();
}

class _DiscountedSubscriptionPageState
    extends State<DiscountedSubscriptionPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(
      SubscriptionEvent.viewed(
        source: widget.source,
        paywallType: PaywallType.discount,
        tabName: widget.tabName,
        featureName: widget.featureName,
      ),
    );

    if (widget.onEnter != null) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) widget.onEnter!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) {
              if (state.failure != null) {
                BizzieSnackBar.show(
                  context,
                  message: state.failure!.message,
                  type: BizzieSnackBarType.error,
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
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                );
              }
            },
            buildWhen: (previous, current) {
              return !current.status.isSubscribed;
            },
            builder: (context, subscriptionState) {
              final mascotAsset = context.select<UserBloc, String>(
                (bloc) => bloc.state.mascotAsset,
              );

              return subscriptionState.map(
                initial: (_) => BizzieLoader(
                  message: 'Loading subscription',
                  mascotAssetPath: mascotAsset,
                ),
                loading: (_) => BizzieLoader(
                  message: 'Loading subscription',
                  mascotAssetPath: mascotAsset,
                ),
                loaded: (s) => _DiscountedSubscriptionLoadedContent(
                  state: s,
                  mascotAsset: mascotAsset,
                ),
                failure: (s) => BizzieError(
                  message: s.failure.message,
                  onRetry: () => context.read<SubscriptionBloc>().add(
                    const SubscriptionEvent.offeringsRequested(),
                  ),
                ),
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
  final String mascotAsset;

  const _DiscountedSubscriptionLoadedContent({
    required this.state,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: AppConstants.pagePadding.copyWith(bottom: 100),
            child: Column(
              children: [
                const Row(children: [Spacer(), SubscriptionCloseButton()]),
                SubscriptionMascot(asset: mascotAsset),
                const SizedBox(height: 16),
                DiscountTitleCard(percentage: state.discountPercentageText),
                const SizedBox(height: 24),
                const SubscriptionHeader(),
                const SizedBox(height: 32),
                DiscountPlanBox(
                  package: state.discountAnnualPackage,
                  standardAnnualPriceText: state.standardAnnualPriceText,
                  savingsPercentageText: state.discountPercentageText,
                ),
                const SizedBox(height: 24),
                SubscriptionFeatureHighlights(features: state.features),
                const SizedBox(height: 24),
                SavingsSummaryCard(
                  package: state.discountAnnualPackage,
                  totalSavingsText: state.totalDiscountSavingsText,
                ),
                const SizedBox(height: 32),
                SubscriptionLegalFooter(
                  onRestore: () {
                    context.read<SubscriptionBloc>().add(
                      const SubscriptionEvent.restoreRequested(),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SubscriptionBottomActions(
            isLoading: state.isPurchasing,
            buttonTitle:
                'Claim ${state.discountPercentageText.replaceAll('-', '')} Off Now',
            disclaimer: state.discountRenewalDisclaimerText,
            onTap: state.discountAnnualPackage != null
                ? () {
                    context.read<SubscriptionBloc>().add(
                      SubscriptionEvent.purchaseRequested(
                        state.discountAnnualPackage!,
                      ),
                    );
                  }
                : () {
                    BizzieSnackBar.show(
                      context,
                      message:
                          'Offer is currently unavailable. Please try again later.',
                      type: BizzieSnackBarType.error,
                    );
                  },
          ),
        ),
      ],
    );
  }
}
