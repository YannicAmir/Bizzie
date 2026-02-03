import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_bottom_actions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_close_button.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_plan_button.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_restore_button.dart';
import 'package:flutter/material.dart';
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
    final isAnnual = state.isAnnualSelection;

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: AppConstants.pagePadding.copyWith(bottom: 120),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubscriptionRestoreButton(),
                    SubscriptionCloseButton(),
                  ],
                ),
                const SizedBox(height: 8),
                SubscriptionMascot(asset: mascotAsset),
                const SizedBox(height: 16),
                const SubscriptionHeader(),
                const SizedBox(height: 32),
                SubscriptionPlanButton(
                  title: 'Annual',
                  package: state.annualPackage,
                  isSelected: isAnnual,
                  badgeText: 'Save 43%',
                  onTap: () => context.read<SubscriptionBloc>().add(
                    const SubscriptionEvent.planToggled(isAnnual: true),
                  ),
                ),
                const SizedBox(height: 16),
                SubscriptionPlanButton(
                  title: 'Monthly',
                  package: state.monthlyPackage,
                  isSelected: !isAnnual,
                  onTap: () => context.read<SubscriptionBloc>().add(
                    const SubscriptionEvent.planToggled(isAnnual: false),
                  ),
                ),
                const SizedBox(height: 24),
                const SubscriptionFeatureHighlights(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SubscriptionBottomActions(
            isAnnual: isAnnual,
            isLoading: state.isPurchasing,
            selectedPackage: isAnnual
                ? state.annualPackage
                : state.monthlyPackage,
            onTap: () {
              final package = isAnnual
                  ? state.annualPackage
                  : state.monthlyPackage;
              if (package != null) {
                context.read<SubscriptionBloc>().add(
                  SubscriptionEvent.purchaseRequested(package),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
