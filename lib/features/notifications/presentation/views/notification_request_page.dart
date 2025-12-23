import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';

class NotificationRequestPage extends StatelessWidget {
  const NotificationRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        state.maybeWhen(success: (_) => context.go('/home'), orElse: () {});
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const _ProgressBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      _BackButton(),
                      SizedBox(height: 64),
                      _NotificationCard(),
                      Spacer(),
                      _Header(),
                      Spacer(),
                      _ActionButtons(),
                      SizedBox(height: 24),
                    ],
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

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: double.infinity, height: 4, color: AppColors.slate200),
        Container(
          width:
              MediaQuery.of(context).size.width * 0.75, // Approximated progress
          height: 4,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: AppColors.slate900,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard();

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
            child: const Text(
              'B',
              style: TextStyle(
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
                  'NVDA Earnings Update',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'NVIDIA releases 10Q report in 2 days',
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stay in the loop',
          style: AppTextStyles.h1.copyWith(
            color: AppColors.slate900,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Get notifications on the companies in your watchlist',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
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
              style: AppTextStyles.button.copyWith(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: TextButton(
            onPressed: () {
              context.go('/home');
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
              style: AppTextStyles.button.copyWith(color: AppColors.slate700),
            ),
          ),
        ),
      ],
    );
  }
}
