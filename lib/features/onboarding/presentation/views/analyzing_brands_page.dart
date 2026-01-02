import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          final isDone = state.analysisStep >= 3;
          final title = state.analysisTitle;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 144),
                        SizedBox(
                          height:
                              77, // Height for 2 lines of text (32 * 1.2 * 2 = 76.8)
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: 0.406,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Analysis Steps List
                        _AnalysisStepItem(
                          text: 'Analyzing your brands',
                          iconPath: AppAssets.searchIcon,
                          state: state.stepAnalysisStatus,
                        ),
                        const SizedBox(height: 16),
                        _AnalysisStepItem(
                          text: 'Identifying public companies',
                          iconPath: AppAssets.arrowUpIcon,
                          state: state.stepPublicCompaniesStatus,
                        ),
                        const SizedBox(height: 16),
                        _AnalysisStepItem(
                          text: 'Building your watchlist',
                          iconPath: AppAssets.circledCheckIcon,
                          state: state.stepWatchlistStatus,
                        ),

                        const SizedBox(height: 48),

                        // Progress Bar (Always Visible)
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
                                end: isDone
                                    ? 1.0
                                    : (state.analysisStep + 1.0) / 3.0,
                              ),
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.linear,
                              builder: (context, value, _) {
                                return LinearProgressIndicator(
                                  value: value.clamp(0.0, 1.0),
                                  backgroundColor: Colors.transparent,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                );
                              },
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isDone,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: OnboardingFooter(
                    primaryButton: ElevatedButton(
                      onPressed: () {
                        context.push(AppRoutes.onboardingFoundCompanies);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Show Me the Stocks',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AnalysisStepItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final AnalysisStepStatus state;

  const _AnalysisStepItem({
    required this.text,
    required this.iconPath,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color iconBgColor;
    Color iconColor;

    switch (state) {
      case AnalysisStepStatus.completed:
        backgroundColor = AppColors.successBackground;
        borderColor = AppColors.successBorder;
        textColor = AppColors.textPrimary;
        iconBgColor = AppColors.successIconBackground;
        iconColor = AppColors.successText;
        break;
      case AnalysisStepStatus.active:
        backgroundColor = AppColors.mascotBackground;
        borderColor = AppColors.brandChipSectorBorder;
        textColor = AppColors.textPrimary;
        iconBgColor = AppColors.brandChipSelectedBackground;
        iconColor = AppColors.primary;
        break;
      case AnalysisStepStatus.pending:
        backgroundColor = AppColors.inputBackground;
        borderColor = AppColors.inputBorder;
        textColor = AppColors.textTertiary;
        iconBgColor = AppColors.slate100;
        iconColor = AppColors.textTertiary;
        break;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: iconColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
