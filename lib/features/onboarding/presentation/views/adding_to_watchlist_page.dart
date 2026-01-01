import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

enum _WatchlistStepState { pending, active, completed }

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
        final companies = state.onboardingData.detectedCompanies;
        final step = state.watchlistStep;
        final total = companies.length;

        // Completion is when step equals total counts.
        // Step 0: Initial
        // Step 1: Item 0 is Adding... (Active) -> then Done?
        // Wait, the bloc logic:
        // for i = 0 to count:
        //   emit(step = i)
        //   delay
        //
        // If count = 3.
        // i=0: step=0. (Item 0 is Pending? Or Active?)
        // Let's align with logic:
        // If step = 0: All pending? Or Item 0 active?
        // Let's assume Step k means "k items are fully added".
        // So Step 0: 0 items added. Item 0 is being added (Active).
        // Step 1: 1 item added. Item 1 is being added.
        // Step k: k items added.

        // So for index i:
        // if i < step: Completed.
        // if i == step: Active (Adding).
        // if i > step: Pending.

        final isComplete = step >= total;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  // Heading
                  Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: isComplete
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
                    isComplete ? 'Added to Watchlist' : 'Adding to Watchlist',
                    style: AppTextStyles.h1,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isComplete
                        ? 'Added the companies Bizzie found to your personal watchlist.'
                        : 'Adding the companies Bizzie found to your personal watchlist.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Companies List
                  Expanded(
                    child: ListView.separated(
                      itemCount: companies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        _WatchlistStepState itemState;
                        if (index < step) {
                          itemState = _WatchlistStepState.completed;
                        } else if (index == step) {
                          itemState = _WatchlistStepState.active;
                        } else {
                          itemState = _WatchlistStepState.pending;
                        }

                        return _WatchlistItem(
                          company: companies[index],
                          state: itemState,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Progress Bar or Button
                  if (!isComplete) ...[
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
                            end: total > 0 ? (step + 1) / total : 0,
                          ),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.linear,
                          builder: (context, value, _) {
                            return LinearProgressIndicator(
                              value: value.clamp(0.0, 1.0),
                              backgroundColor: AppColors.inputBackground,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ), // Adding some bottom padding for the bar
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to notification request or next step
                          context.go(AppRoutes.notificationRequest);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WatchlistItem extends StatelessWidget {
  final Company company;
  final _WatchlistStepState state;

  const _WatchlistItem({required this.company, required this.state});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color iconBgColor;
    Color iconColor;
    IconData? iconData;
    String subtitle;

    switch (state) {
      case _WatchlistStepState.completed:
        backgroundColor = const Color(0xFFECFDF5); // Green-ish bg
        borderColor = const Color(0xFFA4F4CF); // Green border
        textColor = AppColors.textPrimary;
        iconBgColor = const Color(0xFFD0FAE5);
        iconColor = const Color(0xFF047857);
        iconData = Icons.check;
        subtitle = 'Added to watchlist';
        break;
      case _WatchlistStepState.active:
        backgroundColor = const Color(0xFFEFF6FF); // Blue-ish bg
        borderColor = const Color(0xFFBEDBFF); // Blue border
        textColor = AppColors.textPrimary;
        iconBgColor = const Color(0xFFDBEAFE);
        iconColor = AppColors.primary;
        iconData = Icons
            .add; // Or create a custom loader if needed, but Figma showed Icon
        subtitle = 'Adding to watchlist...';
        break;
      case _WatchlistStepState.pending:
        backgroundColor = const Color(0xFFF8FAFC);
        borderColor = const Color(0xFFE2E8F0);
        textColor = AppColors.textTertiary;
        iconBgColor = const Color(0xFFF1F5F9);
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
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: state == _WatchlistStepState.pending
                        ? AppColors.textTertiary
                        : (state == _WatchlistStepState.active
                              ? AppColors.primary
                              : const Color(
                                  0xFF047857,
                                )), // Green text for added?
                    // Figma "Added" subtitle color: usually textSecondary or Green.
                    // Let's use textSecondary for now or match icon color if emphasized.
                    // Safe bet: textSecondary for normal text, maybe specific color for 'Adding...'
                  ),
                ),
              ],
            ),
          ),
          // Checkmark circle for completed?
          // if (state == _WatchlistStepState.completed)
          // Container(
          //   width: 24,
          //   height: 24,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Color(0xFF10B981), // Green
          //   ),
          //   child: const Icon(Icons.check, size: 16, color: Colors.white),
          // )
          if (state == _WatchlistStepState.active)
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
