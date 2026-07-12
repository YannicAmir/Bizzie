import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OnboardingNavigationOrchestrator {
  final OnboardingBloc _onboardingBloc;

  OnboardingNavigationOrchestrator(this._onboardingBloc);

  Future<void> startTerminalFlow(BuildContext context) async {
    context.go(AppRoutes.home);

    await Future.delayed(const Duration(milliseconds: 50));

    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext != null && rootContext.mounted) {
      await PaywallHelper.showPaywallSequence(
        rootContext,
        source: PaywallSource.onboarding,
      );

      _onboardingBloc.add(const OnboardingEvent.onboardingFlowFinished());
    }
  }
}
