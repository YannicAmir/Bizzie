import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/constants/app_constants.dart';

class OnboardingShell extends StatelessWidget {
  final Widget child;

  const OnboardingShell({super.key, required this.child});

  static const List<String> _progressSteps = [
    AppRoutes.onboardingSectors,
    AppRoutes.onboardingBrands,
    AppRoutes.onboardingNotifications,
    AppRoutes.onboardingExperience,
    AppRoutes.onboardingName,
    AppRoutes.onboardingFeatureHighlights,
    AppRoutes.createAccount,
    AppRoutes.onboardingBuildingProfile,
    AppRoutes.onboardingProfileReady,
  ];

  double _getProgressValue(String path) {
    final stepIndex = _progressSteps.indexOf(path);
    if (stepIndex < 0) return 0.0;
    return (stepIndex + 1) / _progressSteps.length;
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    final double progress = _getProgressValue(location);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              if (location != AppRoutes.onboardingFinishing)
                _OnboardingProgressBar(progress: progress),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingProgressBar extends StatelessWidget {
  final double progress;

  const _OnboardingProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: AppConstants.onboardProgressAnimationDuration,
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return LinearProgressIndicator(value: value);
      },
    );
  }
}
