import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
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

  String _getTitle(int step) {
    if (step >= 3) return 'All done!';
    switch (step) {
      case 0:
      case 1:
        return 'Analyzing your\nbrands';
      case 2:
        return 'Identifying public\ncompanies';
      case 3:
        return 'Building your\nwatchlist';
      default:
        return 'Analyzing your\nbrands';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final isDone = state.analysisStep >= 3;
          final title = _getTitle(state.analysisStep);

          return SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  progressIndicator: LinearProgressIndicator(
                    value: 6 / 14,
                    backgroundColor: AppColors.slate200,
                    color: AppColors.primary,
                    minHeight: 4,
                  ),
                  title: title,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),

                        // Analysis Steps List
                        _AnalysisStepItem(
                          text: 'Analyzing your brands',
                          iconPath: AppAssets.searchIcon,
                          state: state.analysisStep >= 1
                              ? _StepState.completed
                              : state.analysisStep == 0
                              ? _StepState.active
                              : _StepState.pending,
                        ),
                        const SizedBox(height: 16),
                        _AnalysisStepItem(
                          text: 'Identifying public companies',
                          iconPath: AppAssets.arrowUpIcon,
                          state: state.analysisStep >= 2
                              ? _StepState.completed
                              : state.analysisStep == 1
                              ? _StepState.active
                              : _StepState.pending,
                        ),
                        const SizedBox(height: 16),
                        _AnalysisStepItem(
                          text: 'Building your watchlist',
                          iconPath: AppAssets.circledCheckIcon,
                          state: state.analysisStep >= 3
                              ? _StepState.completed
                              : state.analysisStep == 2
                              ? _StepState.active
                              : _StepState.pending,
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
                if (isDone)
                  OnboardingFooter(
                    primaryButton: ElevatedButton(
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
                  )
                else
                  const SizedBox(height: 88),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum _StepState { pending, active, completed }

class _AnalysisStepItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final _StepState state;

  const _AnalysisStepItem({
    required this.text,
    required this.iconPath,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Color iconBgColor;
    Color iconColor;

    switch (state) {
      case _StepState.completed:
        backgroundColor = const Color(0xFFECFDF5);
        borderColor = const Color(0xFFA4F4CF);
        textColor = AppColors.textPrimary;
        iconBgColor = const Color(0xFFD0FAE5);
        iconColor = const Color(0xFF047857);
        break;
      case _StepState.active:
        backgroundColor = const Color(0xFFEFF6FF);
        borderColor = const Color(0xFFBEDBFF);
        textColor = AppColors.textPrimary;
        iconBgColor = const Color(0xFFDBEAFE);
        iconColor = AppColors.primary;
        break;
      case _StepState.pending:
        backgroundColor = const Color(0xFFF8FAFC);
        borderColor = const Color(0xFFE2E8F0);
        textColor = AppColors.textTertiary;
        iconBgColor = const Color(0xFFF1F5F9);
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
              style: AppTextStyles.bodyMedium.copyWith(
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
