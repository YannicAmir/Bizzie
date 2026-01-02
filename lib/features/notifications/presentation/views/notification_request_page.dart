import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class NotificationRequestPage extends StatelessWidget {
  const NotificationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the first company from onboarding data
    final firstCompany = context
        .read<OnboardingBloc>()
        .state
        .onboardingData
        .detectedCompanies
        .firstOrNull;
    final ticker = firstCompany?.ticker ?? 'NVDA';
    final companyName = firstCompany?.name ?? 'NVIDIA';

    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (_) => context.go(AppRoutes.onboardingExperience),
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: _NotificationCard(
                    ticker: ticker,
                    companyName: companyName,
                  ),
                ),
              ),
              Spacer(),
              OnboardingFooter(
                title: 'Stay in the loop',
                subtitle:
                    'Get notifications on the companies in your watchlist',
                primaryButton: ElevatedButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(
                      const NotificationEvent.setupRequested(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Enable Notifications',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                secondaryButton: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRoutes.onboardingExperience);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.slate100,
                      foregroundColor: AppColors.slate700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Maybe Later',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.slate700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _NotificationCard({required this.ticker, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.slate200.withValues(alpha: 0.5),
          width: 0.67,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 50,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              ticker.isNotEmpty ? ticker[0] : 'B',
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$ticker Earnings Update',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$companyName releases 10Q report in 2 days',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'now',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
