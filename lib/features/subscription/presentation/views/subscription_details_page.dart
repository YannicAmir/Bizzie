import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/subscription/domain/enums/membership_scenario.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_status_extensions.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_gift_modal.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/widgets/app_bar/bizzie_app_bar.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  const SubscriptionDetailsPage({super.key});

  @override
  State<SubscriptionDetailsPage> createState() =>
      _SubscriptionDetailsPageState();
}

class _SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.offeringsRequested(),
    );
  }

  void _showGiftModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SubscriptionGiftModal(),
    );
  }

  Future<void> _handleUpgrade() async {
    final result = await context.pushNamed(
      AppRoutes.paywall,
      extra: {'highlight': 'annual', 'isUpgradeFlow': true},
    );

    if (result != true && mounted) {
      _showGiftModal();
    }
  }

  void _handleCancel() {
    final state = context.read<SubscriptionBloc>().state;
    final url = state.status.managementURL;

    if (url != null && url.isNotEmpty) {
      UrlLauncherUtils.launch(url, mode: LaunchMode.externalApplication);
    } else {
      if (Platform.isIOS) {
        UrlLauncherUtils.launch(
          'https://apps.apple.com/account/subscriptions',
          mode: LaunchMode.externalApplication,
        );
      } else if (Platform.isAndroid) {
        UrlLauncherUtils.launch(
          'https://play.google.com/store/account/subscriptions',
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (!state.status.isSubscribed) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: const BizzieAppBar(title: 'Subscription Details'),
        body: SafeArea(
          child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
            builder: (context, state) {
              return BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  final status = state.status;

                  return Padding(
                    padding: AppConstants.pagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        _MascotHeader(mascotAsset: userState.mascotAsset),
                        const SizedBox(height: 48),
                        _ActivePlanCard(status: status),
                        const Spacer(),
                        _ActionButtons(
                          status: status,
                          onUpgrade: _handleUpgrade,
                          onManage: _handleCancel,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MascotHeader extends StatelessWidget {
  final String mascotAsset;

  const _MascotHeader({required this.mascotAsset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Center(child: Image.asset(mascotAsset, height: 180)),
        const SizedBox(height: 24),
        Center(child: Text('Bizzie Plus', style: theme.textTheme.displayLarge)),
        const SizedBox(height: 4),
        Center(
          child: Text(
            'Congrats on being a Bizzie Plus member!',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ActivePlanCard extends StatelessWidget {
  final SubscriptionStatus status;

  const _ActivePlanCard({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = status.trialRemainingText;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status.planTitle, style: theme.textTheme.labelLarge),
                const SizedBox(height: 2),
                Text(
                  'Includes full access to all Bizzie Plus features',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: theme.colorScheme.surface,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final SubscriptionStatus status;
  final VoidCallback onUpgrade;
  final VoidCallback onManage;

  const _ActionButtons({
    required this.status,
    required this.onUpgrade,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMonthly = status.scenario == MembershipScenario.monthly;

    return Column(
      children: [
        if (isMonthly) ...[
          BizziePrimaryButton(
            title: 'Upgrade to Yearly & Save',
            onPressed: onUpgrade,
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: onManage,
            child: Text(
              'Manage Subscription',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
