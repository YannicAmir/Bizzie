import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class AddingToWatchlistPage extends StatefulWidget {
  const AddingToWatchlistPage({super.key});

  @override
  State<AddingToWatchlistPage> createState() => _AddingToWatchlistPageState();
}

class _AddingToWatchlistPageState extends State<AddingToWatchlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.startWatchlistAddition(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final companies = state.onboardingData.detectedCompanies;
        final step = state.watchlistStep;
        final total = companies.length;
        final isComplete = step >= total && total > 0;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Heading
                  Container(
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
                      child: Image.asset(
                        isComplete ? AppAssets.checkIcon : AppAssets.plusIcon,
                        width: 48,
                        height: 48,
                        color: Colors.white,
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
                        // Items are "checked" as step progresses
                        // If step=0, 0 items checked.
                        // If step=1, item 0 is checked.
                        final isAdded = index < step;
                        return _WatchlistItem(
                          company: companies[index],
                          isAdded: isAdded,
                          // Show loader for the current item being added
                          isLoading: !isComplete && index == step,
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
                            end: total > 0 ? step / total : 0,
                          ),
                          duration: const Duration(milliseconds: 500),
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
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to next or complete
                          // For now just print or go home?
                          // The flow usually goes to Results or Main App
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
  final bool isAdded;
  final bool isLoading;

  const _WatchlistItem({
    required this.company,
    required this.isAdded,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAdded ? const Color(0xFFA4F4CF) : AppColors.inputBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Center(
              child: Text(
                company.ticker.substring(0, 1),
                style: AppTextStyles.h3,
              ),
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
                  ),
                ),
                Text(
                  company.ticker,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (isAdded)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF10B981), // Green
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            )
          else if (isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            const SizedBox(width: 24, height: 24), // Placeholder
        ],
      ),
    );
  }
}
