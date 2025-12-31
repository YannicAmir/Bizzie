import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalyzingBrandsPage extends StatefulWidget {
  const AnalyzingBrandsPage({super.key});

  @override
  State<AnalyzingBrandsPage> createState() => _AnalyzingBrandsPageState();
}

class _AnalyzingBrandsPageState extends State<AnalyzingBrandsPage> {
  @override
  void initState() {
    super.initState();
    // Start analysis when page loads
    context.read<OnboardingBloc>().add(const OnboardingEvent.startAnalysis());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final isDone = state.analysisStep >= 3;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Header
                  Text(
                    isDone ? 'All done!' : 'Gathering your\nfavorite brands',
                    style: AppTextStyles.h1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Analysis Steps List
                  _AnalysisStepItem(
                    text: 'Analyzing your brands',
                    isCompleted: state.analysisStep >= 1,
                    isActive: state.analysisStep == 0,
                  ),
                  const SizedBox(height: 16),
                  _AnalysisStepItem(
                    text: 'Identifying public companies',
                    isCompleted: state.analysisStep >= 2,
                    isActive: state.analysisStep == 1,
                  ),
                  const SizedBox(height: 16),
                  _AnalysisStepItem(
                    text: 'Building your watchlist',
                    isCompleted: state.analysisStep >= 3,
                    isActive: state.analysisStep == 2,
                  ),

                  const Spacer(),

                  // Progress Bar or Mascot
                  if (!isDone) ...[
                    // Progress Bar
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.inputBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0,
                            end: (state.analysisStep + 0.3) / 3.0,
                          ),
                          duration: const Duration(milliseconds: 500),
                          builder: (context, value, _) {
                            return LinearProgressIndicator(
                              value: value.clamp(0.0, 1.0),
                              backgroundColor: Colors.transparent,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ] else ...[
                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(AppRoutes.onboardingFoundCompanies);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Show Me the Stocks',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AnalysisStepItem extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final bool isActive;

  const _AnalysisStepItem({
    required this.text,
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Widget icon;

    if (isCompleted) {
      backgroundColor = const Color(0xFFECFDF5); // Green-ish bg
      borderColor = const Color(0xFFA4F4CF); // Green border
      textColor = AppColors.textPrimary;
      icon = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFD0FAE5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.circledCheckIcon,
            width: 24,
            height: 24,
            color: const Color(0xFF047857),
          ),
        ),
      );
    } else if (isActive) {
      backgroundColor = const Color(0xFFEFF6FF); // Blue-ish bg
      borderColor = const Color(0xFFBEDBFF); // Blue border
      textColor = AppColors.textPrimary;
      icon = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );
    } else {
      // Pending
      backgroundColor = const Color(0xFFF8FAFC);
      borderColor = Colors.transparent;
      textColor = AppColors.textTertiary;
      icon = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(14),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 76,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
