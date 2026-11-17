import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';

import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_overlay.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_secondary_button.dart';

class NotificationRequestPage extends StatefulWidget {
  const NotificationRequestPage({super.key});

  @override
  State<NotificationRequestPage> createState() =>
      _NotificationRequestPageState();
}

class _NotificationRequestPageState extends State<NotificationRequestPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.notificationsPrompt),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            state.status.maybeMap(
              success: (_) {
                context.read<OnboardingBloc>().add(
                  const OnboardingEvent.notificationGrantPersistRequested(),
                );
                context.go(AppRoutes.onboardingExperience);
              },
              orElse: () {},
            );
          },
          child: _NotificationRequestView(
            ticker: state.notificationTicker,
            companyName: state.notificationCompanyName,
          ),
        );
      },
    );
  }
}

class _NotificationRequestView extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _NotificationRequestView({
    required this.ticker,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnboardingSkipOverlay(
          step: OnboardingStep.notificationsPrompt,
          child: _NotificationRequestContent(
            ticker: ticker,
            companyName: companyName,
          ),
        ),
      ),
    );
  }
}

class _NotificationRequestContent extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _NotificationRequestContent({
    required this.ticker,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppConstants.onboardNotificationCardTopSpacing,
        Padding(
          padding: AppConstants.onboardHorizontalPadding,
          child: Center(
            child: _NotificationCard(ticker: ticker, companyName: companyName),
          ),
        ),
        const Spacer(),
        const OnboardingFooter(
          title: 'Stay in the loop',
          subtitle: 'Get notifications on the companies in your watchlist',
          primaryButton: _EnableNotificationsButton(),
          secondaryButton: _MaybeLaterButton(),
        ),
      ],
    );
  }
}

class _EnableNotificationsButton extends StatelessWidget {
  const _EnableNotificationsButton();

  @override
  Widget build(BuildContext context) {
    return BizziePrimaryButton(
      onPressed: () {
        context.read<OnboardingBloc>().add(
          const OnboardingEvent.notificationsToggled(enabled: true),
        );
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
        context.read<OnboardingBloc>().add(
          const OnboardingEvent.notificationsToggled(enabled: false),
        );
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
    return Container(
      padding: AppConstants.onboardNotificationCardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(
          alpha: AppConstants.onboardNotificationCardSurfaceAlpha,
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.onboardNotificationCardBorderRadius,
        ),
        border: Border.all(
          color: AppColors.slate200.withValues(
            alpha: AppConstants.onboardNotificationCardBorderAlpha,
          ),
          width: AppConstants.defaultBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: AppConstants.onboardNotificationCardShadowBlur,
            offset: AppConstants.onboardNotificationCardShadowOffset,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppConstants.onboardNotificationIconBorderRadius,
            ),
            child: Image.asset(
              AppAssets.appIcon,
              width: AppConstants.onboardNotificationIconSize,
              height: AppConstants.onboardNotificationIconSize,
            ),
          ),
          AppConstants.onboardNotificationIconSpacing,
          Expanded(
            child: _NotificationCardText(
              ticker: ticker,
              companyName: companyName,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCardText extends StatelessWidget {
  final String ticker;
  final String companyName;

  const _NotificationCardText({
    required this.ticker,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _NotificationCardHeader(ticker: ticker),
        AppConstants.onboardNotificationTitleSpacing,
        Text(
          '$companyName releases earnings in 2 days',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _NotificationCardHeader extends StatelessWidget {
  final String ticker;

  const _NotificationCardHeader({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$ticker Earnings Update', style: AppTextStyles.bodyLargeBold),
        const Spacer(),
        Text('now', style: AppTextStyles.bodySmallSecondary),
      ],
    );
  }
}
