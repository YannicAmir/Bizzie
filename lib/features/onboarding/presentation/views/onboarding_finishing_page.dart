import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_navigation_orchestrator.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _skipTimeout = Duration(seconds: 15);

class OnboardingFinishingPage extends StatefulWidget {
  const OnboardingFinishingPage({super.key});

  @override
  State<OnboardingFinishingPage> createState() =>
      _OnboardingFinishingPageState();
}

class _OnboardingFinishingPageState extends State<OnboardingFinishingPage> {
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _timeoutTimer = Timer(_skipTimeout, _onTimeout);
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _onTimeout() {
    if (!mounted) return;
    _onSkipFailed(context, null);
  }

  bool _shouldListen(OnboardingState previous, OnboardingState current) {
    final hasNewDestination =
        current.postOnboardingDestination != null &&
        current.postOnboardingDestination != previous.postOnboardingDestination;
    final hasSkipFailed =
        current.skipStatus == OnboardingSkipStatus.failure &&
        previous.skipStatus != OnboardingSkipStatus.failure;
    final hasFoundExistingProfile =
        current.skipStatus == OnboardingSkipStatus.existingProfile &&
        previous.skipStatus != OnboardingSkipStatus.existingProfile;
    return hasNewDestination || hasSkipFailed || hasFoundExistingProfile;
  }

  void _onStateChanged(BuildContext context, OnboardingState state) {
    final destination = state.postOnboardingDestination;
    if (destination != null) {
      _timeoutTimer?.cancel();
      unawaited(
        OnboardingNavigationOrchestrator.completeSkipFlow(context, destination),
      );
      return;
    }
    if (state.skipStatus == OnboardingSkipStatus.existingProfile) {
      _timeoutTimer?.cancel();
      context.go(AppRoutes.home);
      return;
    }
    _onSkipFailed(context, state.failureMessage);
  }

  void _onSkipFailed(BuildContext context, String? failureMessage) {
    _timeoutTimer?.cancel();
    BizzieSnackBar.show(
      context,
      message: failureMessage ?? 'Something went wrong. Please try again.',
      type: BizzieSnackBarType.error,
    );
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.landing);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: _shouldListen,
        listener: _onStateChanged,
        child: BizzieLoader(
          message: 'Setting up your Bizzie...',
          mascotAssetPath: context.select<OnboardingBloc, String>(
            (bloc) => bloc.state.mascotAsset,
          ),
        ),
      ),
    );
  }
}
