import 'dart:async';

import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/utils/subscription_purchase_gate.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_bottom_actions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_legal_footer.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_plan_button.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_close_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionLoadedContent extends StatelessWidget {
  final SubscriptionStateLoaded state;
  final String mascotAsset;

  const SubscriptionLoadedContent({
    super.key,
    required this.state,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _SubscriptionScrollContent(
            state: state,
            mascotAsset: mascotAsset,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _SubscriptionPurchaseBar(state: state),
        ),
      ],
    );
  }
}

class _SubscriptionScrollContent extends StatelessWidget {
  final SubscriptionStateLoaded state;
  final String mascotAsset;

  const _SubscriptionScrollContent({
    required this.state,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding.copyWith(
        bottom: AppConstants.subscriptionContentBottomInset,
      ),
      child: Column(
        children: [
          const Row(children: [Spacer(), BizzieCloseButton()]),
          AppConstants.subSectionSpacing,
          SubscriptionMascot(asset: mascotAsset),
          AppConstants.secondarySectionSpacing,
          const SubscriptionHeader(),
          AppConstants.largeSectionSpacing,
          _SubscriptionPlanSelector(state: state),
          AppConstants.mainSectionSpacing,
          SubscriptionFeatureHighlights(features: state.features),
          AppConstants.largeSectionSpacing,
          SubscriptionLegalFooter(
            onRestore: () =>
                unawaited(SubscriptionPurchaseGate.requestRestore(context)),
          ),
          AppConstants.subSectionSpacing,
        ],
      ),
    );
  }
}

class _SubscriptionPlanSelector extends StatelessWidget {
  final SubscriptionStateLoaded state;

  const _SubscriptionPlanSelector({required this.state});

  @override
  Widget build(BuildContext context) {
    final isAnnual = state.isAnnualSelection;

    return Column(
      children: [
        SubscriptionPlanButton(
          title: 'Annual',
          package: state.annualPackage,
          isSelected: isAnnual,
          badgeText: state.annualSavingsText,
          onTap: () => context.read<SubscriptionBloc>().add(
            const SubscriptionEvent.planToggled(isAnnual: true),
          ),
        ),
        AppConstants.secondarySectionSpacing,
        SubscriptionPlanButton(
          title: 'Monthly',
          package: state.monthlyPackage,
          isSelected: !isAnnual,
          onTap: () => context.read<SubscriptionBloc>().add(
            const SubscriptionEvent.planToggled(isAnnual: false),
          ),
        ),
      ],
    );
  }
}

class _SubscriptionPurchaseBar extends StatelessWidget {
  final SubscriptionStateLoaded state;

  const _SubscriptionPurchaseBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final selectedPackage = state.selectedPackage;

    return SubscriptionBottomActions(
      isLoading: state.isPurchasing,
      buttonTitle: selectedPackage?.isEligibleForTrial ?? false
          ? 'Start Free Trial'
          : 'Continue',
      disclaimer: state.renewalDisclaimerText,
      onTap: () {
        if (selectedPackage == null) return;
        unawaited(
          SubscriptionPurchaseGate.requestPurchase(
            context,
            package: selectedPackage,
          ),
        );
      },
    );
  }
}
