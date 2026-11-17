import 'dart:async';

import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/utils/onboarding_paywall_reporter.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/subscription/presentation/utils/subscription_purchase_gate.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_legal_footer.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_close_button.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_success_overlay.dart';
import 'package:bizzie/features/subscription/presentation/widgets/discount_title_card.dart';
import 'package:bizzie/features/subscription/presentation/widgets/discount_plan_box.dart';
import 'package:bizzie/features/subscription/presentation/widgets/savings_summary_card.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_bottom_actions.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:material_ui/material_ui.dart';
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
    OnboardingPaywallReporter.paywallViewed(
      context,
      source: widget.source,
      paywallType: PaywallType.discount,
    );

    if (widget.onEnter != null) {
      unawaited(
        Future.delayed(AppConstants.paywallOnEnterDelay, () {
          if (mounted) widget.onEnter?.call();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<SubscriptionBloc, SubscriptionState>(
            listenWhen: (previous, current) =>
                previous.completedPurchaseType == null &&
                current.completedPurchaseType != null,
            listener: (context, state) {
              final purchasedPackageType = state.completedPurchaseType;
              if (purchasedPackageType == null) return;
              OnboardingPaywallReporter.purchaseCompleted(
                context,
                source: widget.source,
                packageType: purchasedPackageType,
              );
            },
            child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
              listener: _onSubscriptionStateChanged,
              buildWhen: (previous, current) {
                return !current.status.isSubscribed;
              },
              builder: (context, subscriptionState) {
                final mascotAsset = context.select<UserBloc, String>(
                  (bloc) => bloc.state.mascotAsset,
                );
                final loader = BizzieLoader(
                  message: 'Loading subscription',
                  mascotAssetPath: mascotAsset,
                );

                return subscriptionState.map(
                  initial: (_) => loader,
                  loading: (_) => loader,
                  loaded: (s) => _DiscountedSubscriptionLoadedContent(
                    state: s,
                    mascotAsset: mascotAsset,
                  ),
                  failure: (s) => BizzieError(
                    message: s.failure.errorMessage,
                    onRetry: () => context.read<SubscriptionBloc>().add(
                      const SubscriptionEvent.offeringsRequested(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onSubscriptionStateChanged(
    BuildContext context,
    SubscriptionState state,
  ) {
    final failure = state.failure;
    if (failure != null) {
      BizzieSnackBar.show(
        context,
        message: failure.message,
        type: BizzieSnackBarType.error,
      );
    }

    final loadedState = state.mapOrNull(loaded: (s) => s);
    if (loadedState != null && loadedState.isLocalSuccessOverride) {
      _onLocalPurchaseSucceeded(context, loadedState);
    }
  }

  void _onLocalPurchaseSucceeded(
    BuildContext context,
    SubscriptionStateLoaded state,
  ) {
    SubscriptionSuccessOverlay.show(
      context,
      userName: context.read<UserBloc>().state.displayName,
      onDismiss: () => PaywallHelper.closePaywall(context),
    );

    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.purchaseUICompleted(),
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
          child: _DiscountedSubscriptionScrollContent(
            state: state,
            mascotAsset: mascotAsset,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _DiscountedSubscriptionPurchaseBar(state: state),
        ),
      ],
    );
  }
}

class _DiscountedSubscriptionScrollContent extends StatelessWidget {
  final SubscriptionStateLoaded state;
  final String mascotAsset;

  const _DiscountedSubscriptionScrollContent({
    required this.state,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding.copyWith(
        bottom: AppConstants.discountedSubscriptionContentBottomInset,
      ),
      child: Column(
        children: [
          const Row(children: [Spacer(), BizzieCloseButton()]),
          SubscriptionMascot(asset: mascotAsset),
          AppConstants.secondarySectionSpacing,
          DiscountTitleCard(percentage: state.discountPercentageText),
          AppConstants.mainSectionSpacing,
          const SubscriptionHeader(),
          AppConstants.largeSectionSpacing,
          DiscountPlanBox(
            package: state.discountAnnualPackage,
            standardAnnualPriceText: state.standardAnnualPriceText,
            savingsPercentageText: state.discountPercentageText,
          ),
          AppConstants.mainSectionSpacing,
          SubscriptionFeatureHighlights(features: state.features),
          AppConstants.mainSectionSpacing,
          SavingsSummaryCard(
            package: state.discountAnnualPackage,
            totalSavingsText: state.totalDiscountSavingsText,
          ),
          AppConstants.largeSectionSpacing,
          SubscriptionLegalFooter(
            onRestore: () =>
                unawaited(SubscriptionPurchaseGate.requestRestore(context)),
          ),
          AppConstants.mainSectionSpacing,
        ],
      ),
    );
  }
}

class _DiscountedSubscriptionPurchaseBar extends StatelessWidget {
  final SubscriptionStateLoaded state;

  const _DiscountedSubscriptionPurchaseBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final discountPackage = state.discountAnnualPackage;

    return SubscriptionBottomActions(
      isLoading: state.isPurchasing,
      buttonTitle: 'Claim ${state.discountPercentageValueText} Off Now',
      disclaimer: state.discountRenewalDisclaimerText,
      onTap: discountPackage != null
          ? () => unawaited(
              SubscriptionPurchaseGate.requestPurchase(
                context,
                package: discountPackage,
              ),
            )
          : () {
              BizzieSnackBar.show(
                context,
                message:
                    'Offer is currently unavailable. Please try again later.',
                type: BizzieSnackBarType.error,
              );
            },
    );
  }
}
