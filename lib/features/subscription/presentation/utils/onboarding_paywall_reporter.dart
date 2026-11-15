import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPaywallReporter {
  static const String _kSubscriptionTypeNone = 'none';

  static void paywallViewed(
    BuildContext context, {
    required PaywallSource source,
    required PaywallType paywallType,
  }) {
    if (source != PaywallSource.onboarding) return;
    final step = paywallType == PaywallType.discount
        ? OnboardingStep.discountPaywall
        : OnboardingStep.paywall;
    context.read<OnboardingBloc>()
      ..add(
        const OnboardingEvent.subscriptionStatusChanged(
          didSubscribe: false,
          subscriptionType: _kSubscriptionTypeNone,
        ),
      )
      ..add(OnboardingEvent.stepViewed(step));
  }

  static void giftViewed(
    BuildContext context, {
    required PaywallSource source,
  }) {
    if (source != PaywallSource.onboarding) return;
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.giftModal),
    );
  }

  static void purchaseCompleted(
    BuildContext context, {
    required PaywallSource source,
    required SubscriptionPackageType packageType,
  }) {
    if (source != PaywallSource.onboarding) return;
    context.read<OnboardingBloc>().add(
      OnboardingEvent.subscriptionStatusChanged(
        didSubscribe: true,
        subscriptionType: packageType.name,
      ),
    );
  }
}
