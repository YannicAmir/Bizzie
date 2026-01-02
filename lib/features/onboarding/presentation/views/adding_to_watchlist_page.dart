import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import '../widgets/onboarding_header.dart';

class AddingToWatchlistPage extends StatefulWidget {
  const AddingToWatchlistPage({super.key});

  @override
  State<AddingToWatchlistPage> createState() => _AddingToWatchlistPageState();
}

class _AddingToWatchlistPageState extends State<AddingToWatchlistPage> {
  @override
  void initState() {
    super.initState();
    // Wait for the build to complete before firing the event to ensure smooth entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(
        const OnboardingEvent.startWatchlistAddition(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const OnboardingHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        // Heading
                        Center(
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.blueGradientStart,
                                  AppColors.primary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: state.isWatchlistComplete
                                  ? Image.asset(
                                      AppAssets.onboardingLargeCheckIcon,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      AppAssets.onboardingLargePlusIcon,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          state.watchlistTitle,
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: 0.406,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.watchlistSubtitle,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),

                        Expanded(
                          child: ListView.separated(
                            itemCount:
                                state.onboardingData.detectedCompanies.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return _WatchlistItem(
                                company: state
                                    .onboardingData
                                    .detectedCompanies[index],
                                state: state.getWatchlistItemStatus(index),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Progress Bar (Visible only when adding)
                        if (!state.isWatchlistComplete) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SizedBox(
                              height: 8,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0,
                                  // Target: "step" items done. We want smooth fill for the current "active" item.
                                  // If step = 0 (Item 0 active), we want to animate 0 -> 1/total.
                                  // So end = (step + 1) / total.
                                  end:
                                      state
                                          .onboardingData
                                          .detectedCompanies
                                          .isNotEmpty
                                      ? (state.watchlistStep + 1) /
                                            state
                                                .onboardingData
                                                .detectedCompanies
                                                .length
                                      : 0,
                                ),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.linear,
                                builder: (context, value, _) {
                                  return LinearProgressIndicator(
                                    value: value.clamp(0.0, 1.0),
                                    backgroundColor: AppColors.inputBackground,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          AppColors.primary,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Continue Button (Visible only when complete)
                        if (state.isWatchlistComplete)
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                context.go(AppRoutes.notificationRequest);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Continue',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WatchlistItem extends StatelessWidget {
  final Company company;
  final AnalysisStepStatus state;

  const _WatchlistItem({required this.company, required this.state});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color iconBgColor;
    Color iconColor;
    IconData? iconData;
    String subtitle;

    switch (state) {
      case AnalysisStepStatus.completed:
        backgroundColor = AppColors.successBackground;
        borderColor = AppColors.successBorder;
        textColor = AppColors.textPrimary;
        iconBgColor = AppColors.successIconBackground;
        iconColor = AppColors.successText;
        iconData = Icons.check;
        subtitle = 'Added to watchlist';
        break;
      case AnalysisStepStatus.active:
        backgroundColor = AppColors.watchlistActiveBackground;
        borderColor = AppColors.watchlistActiveBorder;
        textColor = AppColors.textPrimary;
        iconBgColor = AppColors.brandChipSelectedBackground;
        iconColor = AppColors.primary;
        iconData = Icons.add;
        subtitle = 'Adding to watchlist...';
        break;
      case AnalysisStepStatus.pending:
        backgroundColor = AppColors.inputBackground;
        borderColor = AppColors.inputBorder;
        textColor = AppColors.textTertiary;
        iconBgColor = AppColors.slate100;
        iconColor = AppColors.textTertiary;
        iconData = Icons.add;
        subtitle = 'Pending';
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 2,
        ), // Width 2 to match Analysis steps usually
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              // If active, maybe we want a spinner?
              // User said "matches design" which showed Adding state having an icon (blue add)
              // But strictly speaking, "animation" could imply a loader.
              // Let's stick to the icon as per Figma reference unless user requested loader explicitly.
              // Actually, Analysis page used static icons.
              child: Icon(iconData, color: iconColor, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: state == AnalysisStepStatus.pending
                        ? AppColors.textTertiary
                        : (state == AnalysisStepStatus.active
                              ? AppColors.primary
                              : AppColors.successText),
                    // Figma "Added" subtitle color: usually textSecondary or Green.
                    // Let's use textSecondary for now or match icon color if emphasized.
                    // Safe bet: textSecondary for normal text, maybe specific color for 'Adding...'
                  ),
                ),
              ],
            ),
          ),
          if (state == AnalysisStepStatus.active)
            // Optional: Add a small loader here if desired to show activity
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          else
            const SizedBox(width: 24, height: 24),
        ],
      ),
    );
  }
}
