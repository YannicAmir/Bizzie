import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class OnboardingShell extends StatelessWidget {
  final Widget child;

  const OnboardingShell({super.key, required this.child});

  double _getProgressValue(String path) {
    if (path == AppRoutes.onboardingName) return 1 / 14;
    if (path == AppRoutes.onboardingWelcome) return 2 / 14;
    if (path == AppRoutes.onboardingSectors) return 3 / 14;
    if (path == AppRoutes.onboardingMeetBizzie) return 4 / 14;
    if (path == AppRoutes.onboardingBrands) return 5 / 14;
    if (path == AppRoutes.onboardingAnalyzing) return 6 / 14;
    if (path == AppRoutes.onboardingFoundCompanies) return 7 / 14;
    if (path == AppRoutes.onboardingAddingWatchlist) return 8 / 14;
    if (path == AppRoutes.onboardingNotifications) return 9 / 14;
    if (path == AppRoutes.onboardingExperience) return 10 / 14;
    if (path == AppRoutes.onboardingFeatureHighlights) return 11 / 14;
    if (path == AppRoutes.createAccount) return 12 / 14;
    if (path == AppRoutes.onboardingBuildingProfile) return 13 / 14;
    if (path == AppRoutes.onboardingProfileReady) return 14 / 14;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    final double progress = _getProgressValue(location);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, _) {
                  return LinearProgressIndicator(value: value);
                },
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
