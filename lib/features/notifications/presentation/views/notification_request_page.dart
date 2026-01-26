import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_assets.dart';

import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_secondary_button.dart';

class NotificationRequestPage extends StatelessWidget {
  const NotificationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (_) => context.go(AppRoutes.onboardingExperience),
              orElse: () {},
            );
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: _NotificationCard(
                        ticker: state.notificationTicker,
                        companyName: state.notificationCompanyName,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const OnboardingFooter(
                    title: 'Stay in the loop',
                    subtitle:
                        'Get notifications on the companies in your watchlist',
                    primaryButton: _EnableNotificationsButton(),
                    secondaryButton: _MaybeLaterButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EnableNotificationsButton extends StatelessWidget {
  const _EnableNotificationsButton();

  @override
  Widget build(BuildContext context) {
    return BizziePrimaryButton(
      onPressed: () {
        context.read<NotificationBloc>().add(
          const NotificationEvent.setupRequested(),
        );
      },
      title: 'Enable Notifications',
    );
  }
}

class _MaybeLaterButton extends StatelessWidget {
  const _MaybeLaterButton();

  @override
  Widget build(BuildContext context) {
    return BizzieSecondaryButton(
      onPressed: () {
        context.go(AppRoutes.onboardingExperience);
      },
      title: 'Maybe Later',
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _NotificationCard({required this.ticker, required this.companyName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.slate200.withValues(alpha: 0.5),
          width: 0.67,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 50,
            offset: Offset(0, 25),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(AppAssets.appIcon, width: 44, height: 44),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      '$ticker Earnings Update',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'now',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$companyName releases earnings in 2 days',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
