import 'dart:async';

import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/company_profile_tour_request.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_notification_prompter.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _logger = BizzieLogger('OnboardingNavigationOrchestrator');

class OnboardingNavigationOrchestrator {
  OnboardingNavigationOrchestrator._();

  static Future<void> startTerminalFlow(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    context.go(AppRoutes.home);

    await WidgetsBinding.instance.endOfFrame;

    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext != null && rootContext.mounted) {
      await PaywallHelper.showPaywallSequence(
        rootContext,
        source: PaywallSource.onboarding,
      );
    } else {
      _logger.warning('Root navigator unavailable; onboarding paywall skipped');
    }

    onboardingBloc.add(const OnboardingEvent.onboardingFlowFinished());
  }

  static Future<void> startSkipFlow(
    BuildContext context,
    OnboardingStep step, {
    OnboardingSkipReason reason = OnboardingSkipReason.userSkipped,
  }) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    unawaited(context.push(AppRoutes.onboardingFinishing));

    await WidgetsBinding.instance.endOfFrame;

    onboardingBloc.add(OnboardingEvent.skipRequested(step, reason: reason));
  }

  static Future<void> completeSkipFlow(
    BuildContext context,
    PostOnboardingDestination destination,
  ) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    await _waitUntilUserReady(context.read<UserBloc>());
    if (!context.mounted) return;
    context.go(AppRoutes.home);

    await WidgetsBinding.instance.endOfFrame;

    if (!onboardingBloc.state.hasViewedCompanyProfile) {
      _openInitialCompany(destination, onboardingBloc);
    }
    _persistNotificationGrantIfNeeded(destination, onboardingBloc);
  }

  static Future<void> _waitUntilUserReady(UserBloc userBloc) async {
    if (_isUserReady(userBloc.state)) return;
    await userBloc.stream.firstWhere(_isUserReady);
  }

  static bool _isUserReady(UserState state) => state.maybeMap(
    loaded: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );

  static void _openInitialCompany(
    PostOnboardingDestination destination,
    OnboardingBloc onboardingBloc,
  ) {
    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext == null || !rootContext.mounted) {
      _logger.warning('Root navigator unavailable; initial company skipped');
      return;
    }

    unawaited(
      rootContext.pushNamed(
        AppRoutes.companyProfileHome,
        pathParameters: {'ticker': destination.ticker},
        extra: CompanyProfileTourRequest(
          shouldPromptNotifications: destination.shouldPromptNotifications,
          onPromptNotifications: () => unawaited(
            OnboardingNotificationPrompter.promptAndPersistGrant(rootContext),
          ),
        ),
      ),
    );
    onboardingBloc.add(OnboardingEvent.initialCompanyShown(destination));
  }

  static void _persistNotificationGrantIfNeeded(
    PostOnboardingDestination destination,
    OnboardingBloc onboardingBloc,
  ) {
    if (!destination.shouldPersistNotificationGrant) return;
    onboardingBloc.add(
      const OnboardingEvent.notificationGrantPersistRequested(),
    );
  }
}
